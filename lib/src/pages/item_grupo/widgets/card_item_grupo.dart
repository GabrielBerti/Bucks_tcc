import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/item_grupo.dart';
import 'package:bucks/src/pages/item_grupo/item_grupo_controller.dart';
import 'package:bucks/src/pages/item_grupo/item_grupo_list/item_grupo_list_controller.dart';
import 'package:bucks/src/pages/item_grupo/item_grupo_list/item_grupo_list_page.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/widgets/button.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:bucks/src/shared/widgets/text_field_app.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../dash_board.dart';
import '../item_grupo_page.dart';

class CardItemGrupo extends StatefulWidget {
  final ItemGrupoController store;
  final ItemGrupoListController storeItemGrupoList;
  final ItemGrupo itemGrupo;

  const CardItemGrupo({
    Key key,
    @required this.store,
    @required this.storeItemGrupoList,
    @required this.itemGrupo,
  }) : super(key: key);

  @override
  _CardItemGrupoState createState() => _CardItemGrupoState();
}

class _CardItemGrupoState extends State<CardItemGrupo> {
  ItemGrupoController get store => widget.store;
  ItemGrupoListController get storeItemGrupoList => widget.storeItemGrupoList;
  ItemGrupo get itemGrupo => widget.itemGrupo;

  CardCustom cadastroItemGrupo() {
    List<Widget> list = List();

    onPressedButtons() async {
      if (store.descr.text == "") {
        snackbarError(context: context, msg: "Informe a descrição do grupo !");
      } else {
        store.salvar(store: store, storeItemGrupoList: storeItemGrupoList);
        snackbarSucces(
            context: context,
            msg: "Item grupo inserido com sucesso !",
            title: "Item grupo Inserido");
      }
    }

    list.add(TextFieldApp(
      controller: store.descr,
      text: "Digite a descrição do Grupo do Item",
    ));
    list.add(SizedBox(height: 10));
    /*list.add(
      Container(
        width: 250,
        child: FlatButtonApp(
          label: "Salvar",
          onPressed: () => store.salvar(
              store: store, storeItemGrupoList: storeItemGrupoList),
        ),
      ),
    );*/
    /*list.add(Buttons(
      store: store,
      storeItemGrupoList: storeItemGrupoList,
      itemGrupo: itemGrupo,
    ));*/

    // Container(
    //   width: 250,
    //   child: FlatButtonApp(
    //     label: "Salvar Produção",
    //     onPressed: () =>
    //         store.salvar(store: store, storeProducaoList: storeProducaoList),
    //   ),
    // ),
    list.add(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
        ),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          width: 250,
          child: AppButton(
            "Salvar",
            onPressedButtons,
          ),
        ),
      ),
    );

    return CardCustom(
      padding: 20,
      borderRadius: 15.0,
      widget: Column(
        children: list,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return cadastroItemGrupo();
  }
}

class CardItemGrupoList extends StatefulWidget {
  final ItemGrupoListController store;

  const CardItemGrupoList({Key key, @required this.store}) : super(key: key);

  @override
  _CardItemGrupoListState createState() => _CardItemGrupoListState();
}

class _CardItemGrupoListState extends State<CardItemGrupoList> {
  ItemGrupoListController get store => widget.store;

  showAlertDialogDeletaItemGrupo(
    BuildContext context,
    ItemGrupo itemGp,
  ) {
    // configura o button
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        pushReplacement(context, DashboardMateriaisModule());
        push(context, ItemGrupoListPage());
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Sim"),
      onPressed: () async {
        ItemGrupoController igc = ItemGrupoController();
        await igc.verificaRelacionamentosItemGrupo(
            itemGrupo: itemGp, itemGrupoController: igc);

        if (igc.possuiRelacao == false) {
          igc.deletarItemGrupo(itemGrupo: itemGp);
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemGrupoListPage());
          snackbarSucces(
              context: context,
              msg: "Item grupo removido com sucesso !",
              title: "Item grupo removido");
        } else {
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemGrupoListPage());
          snackbarError(
              context: context,
              msg:
                  "Impossível deletar grupo de item pois o mesmo está relacionado à um item !");
        }
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Excluir Grupo de Item"),
      content: Text("Deseja realmente excluir este grupo de item?"),
      actions: [cancelButton, confirmButton],
    );
    // exibe o dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alerta;
      },
    );
  }

  //dynamic get store => widget.store;
  bool sort = false;

  List<ItemGrupo> itens;

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 3) {
      if (ascending) {
        store.itensGrupo.sort((a, b) => a.descr.compareTo(b.descr));
      } else {
        store.itensGrupo.sort((a, b) => b.descr.compareTo(a.descr));
      }
    }
  }

  CardCustom listaItemGrupo() {
    List<Widget> list = List();
    list.add(
      Observer(
        builder: (context) {
          if (!store.hasResultsItensGrupo) {
            return Container();
          }

          if (store.itensGrupo.isEmpty) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextMessage(
                  'Nenhum item grupo encontrado. \nClique aqui para tentar novamente.',
                  fontSize: 18,
                  // onRefresh: store.fetchItems,
                ),
              ],
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.blue,
                scaffoldBackgroundColor: Colors.blue,
              ),
              child: Column(
                children: <Widget>[
                  DataTable(
                    sortAscending: sort,
                    sortColumnIndex: 3,
                    columns: [
                      DataColumn(
                        label: Text(
                          "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                        label: Text(
                          "",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                        label: Text(
                          "ID",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                          label: Text(
                            "DESCR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          numeric: false,
                          onSort: (columnIndex, ascending) {
                            setState(() {
                              sort = !sort;
                            });
                            onSortColum(columnIndex, ascending);
                          }),
                    ],
                    rows: store.itensGrupo.map((item) {
                      // var item = Item.fromJson(data);

                      return DataRow(cells: [
                        DataCell(
                          IconButton(
                            icon: Icon(FontAwesomeIcons.pen),
                            onPressed: () {
                              //store.listarProducaoItem(producao);
                              push(
                                  context,
                                  ItemGrupoPage(
                                    storeItemGrupoList: store,
                                    itemGrupo: item,
                                  ));
                            },
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: Icon(FontAwesomeIcons.trash),
                            onPressed: () {
                              showAlertDialogDeletaItemGrupo(context, item);
                            },
                          ),
                        ),
                        DataCell(
                          Text(
                            "${item.id}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        DataCell(
                          Text(
                            "${item.descr}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ]);
                    }).toList(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );

    /*return DataTable(
          columns: [
            DataColumn(
              label: Text("ID"),
              numeric: false,
            ),
            DataColumn(
              label: Text("DESCRIÇÃO"),
              numeric: false,
            ),
          ],
          rows: store.itens
              .map( 
                (item) => DataRow(
                  cells: [
                    DataCell(
                      Text(item.id.toString()),
                    ),
                    DataCell(
                      Text(item.descricao.toString()),
                    ),
                  ],
                ),
              )
              .toList(),
        );*/

    // list.add(SizedBox(height: 10));
    // list.add(
    //   Container(
    //     width: 250,
    //     child: FlatButtonApp(
    //       label: "Salvar",
    //       onPressed: () => store.salvarFarmacia(store: store),
    //     ),
    //   ),
    // );

    return CardCustom(
      padding: 20,
      borderRadius: 15.0,
      widget: Column(
        children: list,
      ),
    );
  }

  /*CardCustom listaItemGrupo() {
    List<Widget> list = List();
  
    list.add(
      Observer(builder: (context) {
        if (!store.hasResultsItensGrupo) {
          return Container();
        }
        if (store.itensGrupo.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhum item encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchItems,
              ),
            ],
          );
        }

        return Container(
          child: Expanded(
            child: ListView.builder(
              itemCount: store.itensGrupo.length,
              itemBuilder: (context, index) {
                return Container(
                  color: index % 2 == 0 ? Colors.grey[100] : Colors.white, // if current item is selected show blue color
                  child: Dismissible(
                    background: Container(
                      color: Colors.red[300],
                      child: Align(
                        alignment: Alignment(-0.9, 0.0),
                        child: Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                      ),
                    direction: DismissDirection.startToEnd,
                    key: ObjectKey(store.itensGrupo[index]),
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: Text(store.itensGrupo[index].descr),
                    ),
                    onDismissed: (direction){
                      setState(() {
                        _deletar(store.itensGrupo[index].id);
                        store.itensGrupo.removeAt(index);
                      });
                      }
                  ),
                );
              },
            ),
          ),
        );

        // return DataTable(
        //   columns: [
        //     DataColumn(
        //       label: Text("ID"),
        //       numeric: false,
        //     ),
        //     DataColumn(
        //       label: Text("DESCRIÇÃO"),
        //       numeric: false,
        //     ),
        //   ],
        //   rows: store.itensGrupo
        //       .map(
        //         (itemGrupo) => DataRow(
        //           cells: [
        //             DataCell(
        //               Text(itemGrupo.id.toString()),
        //             ),
        //             DataCell(
        //               Text(itemGrupo.descr),
        //             ),
        //           ],
        //         ),
        //       )
        //       .toList(),

        // );
      }),
    );

    return CardCustom(
      padding: 20,
      borderRadius: 15.0,
      widget: Column(
        children: list,
      ),
    );
  } */

  @override
  Widget build(BuildContext context) {
    return listaItemGrupo();
  }

  Future<int> _deletar(int pId) async {
    return await store.itemGrupoDAO.deletar(pId);
  }
}
