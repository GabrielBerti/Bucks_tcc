import 'package:bucks/src/classes/item_tipo.dart';
import 'package:bucks/src/pages/item_tipo/item_tipo_list/item_tipo_list_controller.dart';
import 'package:bucks/src/pages/item_tipo/item_tipo_list/item_tipo_list_page.dart';
import 'package:bucks/src/pages/item_tipo/item_tipo_page.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/widgets/button.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:bucks/src/shared/widgets/text_field_app.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../dash_board.dart';
import '../item_tipo_controller.dart';

class CardItemTipo extends StatefulWidget {
  final ItemTipoController store;
  final ItemTipoListController storeItemTipoList; 
  final ItemTipo itemTipo;

  const CardItemTipo({
    Key key,
    @required this.store,
    @required this.storeItemTipoList,
    @required this.itemTipo,
  }) : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItemTipo> {
  ItemTipoController get store => widget.store;
  ItemTipoListController get storeItemTipoList => widget.storeItemTipoList;
  ItemTipo get itemTipo => widget.itemTipo;

  CardCustom cadastroItemTipo() {
    onPressedButtons() async {
      if (store.descr.text == "") {
        snackbarError(
            context: context, msg: "Informe a descrição do tipo de item !");
        return;
      }

      store.salvarItemTipo(store: store, storeItemTipoList: storeItemTipoList);
      snackbarSucces(
          context: context,
          msg: "Item tipo inserido com sucesso !",
          title: "Item tipo Inserido");
    }

    List<Widget> list = List();
    list.add(TextFieldApp(
      controller: store.descr,
      text: "Digite a descrição do Tipo do Item",
    ));
    list.add(SizedBox(height: 10));
    /*list.add(
      Container(
        width: 250, 
        child: FlatButtonApp(
          label: "Salvar",
          onPressed: () => store.salvarItemTipo(
              store: store, storeItemTipoList: storeItemTipoList),
        ), 
      ),
    );*/
    /*list.add(Buttons(
      store: store,
      storeItemTipoList: storeItemTipoList,
    ));*/

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
    return cadastroItemTipo();
  }
}

class CardItemTipoList extends StatefulWidget {
  final ItemTipoListController store;

  const CardItemTipoList({Key key, @required this.store}) : super(key: key);

  @override
  _CardItemTipoListState createState() => _CardItemTipoListState();
}

class _CardItemTipoListState extends State<CardItemTipoList> {
  ItemTipoListController get store => widget.store;

  showAlertDialogDeletaItemTipo(
    BuildContext context,
    ItemTipo itemTipo,
  ) {
    // configura o button
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        pushReplacement(context, DashboardMateriaisModule());
        push(context, ItemTipoListPage());
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Sim"),
      onPressed: () async {
        ItemTipoController itc = ItemTipoController();
        await itc.verificaRelacionamentosItemTipo(
            itemTipo: itemTipo, itemTipoController: itc);

        if (itc.possuiRelacao == false) {
          itc.deletarItemTipo(itemTipo: itemTipo);
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemTipoListPage());
          snackbarSucces(
              context: context,
              msg: "Item tipo removido com sucesso !",
              title: "Item tipo removido");
        } else {
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemTipoListPage());
          snackbarError(
              context: context,
              msg:
                  "Impossível deletar tipo de item pois o mesmo está relacionado à um item !");
        }
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Excluir Tipo de Item"),
      content: Text("Deseja realmente excluir este tipo de item?"),
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

  bool sort = false;

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 3) {
      if (ascending) {
        store.itensTipo.sort((a, b) => a.descr.compareTo(b.descr));
      } else {
        store.itensTipo.sort((a, b) => b.descr.compareTo(a.descr));
      }
    }
  }

  CardCustom listaItemTipo() {
    List<Widget> list = List();
    list.add(
      Observer(builder: (context) {
        if (!store.hasResultsItensTipo) {
          return Container();
        }
        if (store.itensTipo.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhum item tipo encontrado. \nClique aqui para tentar novamente.',
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
                  rows: store.itensTipo.map((item) {
                    // var item = Item.fromJson(data);

                    return DataRow(cells: [
                      DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.pen),
                          onPressed: () {
                            //store.listarProducaoItem(producao);
                            push(
                                context,
                                ItemTipoPage(
                                  storeItemTipoList: store,
                                  itemTipo: item,
                                ));
                          },
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.trash),
                          onPressed: () {
                            showAlertDialogDeletaItemTipo(context, item);
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
      }),
    );
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

  @override
  Widget build(BuildContext context) {
    return listaItemTipo();
  }
}
