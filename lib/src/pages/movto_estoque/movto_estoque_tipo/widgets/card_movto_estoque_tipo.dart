import 'package:bucks/src/classes/movto_estoque_tipo.dart';
import 'package:bucks/src/pages/item_unmed/item_unmed_list/item_unmed_list_controller.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_tipo/movto_estoque_tipo_list/movto_estoque_tipo_list_controller.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_tipo/movto_estoque_tipo_list/movto_estoque_tipo_list_page.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_tipo/widgets/buttons.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/flat_button_app.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:bucks/src/shared/widgets/text_field_app.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../dash_board.dart';
import '../../movto_estoque_list_page.dart';
import '../movto_estoque_tipo_controller.dart';
import '../movto_estoque_tipo_page.dart';

class CardMovtoEstoqueTipo extends StatefulWidget {
  final MovtoEstoqueTipoController store;
  final MovtoEstoqueTipoListController storeMovtoEstoqueTipoList;

  const CardMovtoEstoqueTipo(
      {Key key, @required this.store, @required this.storeMovtoEstoqueTipoList})
      : super(key: key);

  @override
  _CardMovtoEstoqueTipoState createState() => _CardMovtoEstoqueTipoState();
}

class _CardMovtoEstoqueTipoState extends State<CardMovtoEstoqueTipo> {
  MovtoEstoqueTipoController get store => widget.store;
  MovtoEstoqueTipoListController get storeMovtoEstoqueTipoList =>
      widget.storeMovtoEstoqueTipoList;

  CardCustom cadastroMovtoEstoqueTipo() {
    List<Widget> list = List();

    list.add(TextFieldApp(
      controller: store.tecDescr,
      text: "Digite a descrição do Tipo de Movto",
    ));
    list.add(SizedBox(height: 10));

    list.add(TextFieldApp(
      controller: store.tecCdTipoMovto,
      text: "Digite se o movto é de (E)ntrada ou (S)aída",
    ));
    list.add(SizedBox(height: 10));

    /*list.add(
      Container(
        width: 250,
        child: FlatButtonApp(
          label: "Salvar",
          onPressed: () => store.salvar(store: store, 
                                        storeMovtoEstoqueTipoList: storeMovtoEstoqueTipoList),
        ),
      ),
    );*/

    list.add(Buttons(
      store: store,
      storeTipoMovtoEstoqueList: storeMovtoEstoqueTipoList,
    ));

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
    return cadastroMovtoEstoqueTipo();
  }
}

class CardMovtoEstoqueTipoList extends StatefulWidget {
  final MovtoEstoqueTipoListController store;

  const CardMovtoEstoqueTipoList({Key key, @required this.store})
      : super(key: key);

  @override
  _CardMovtoEstoqueTipoListState createState() =>
      _CardMovtoEstoqueTipoListState();
}

class _CardMovtoEstoqueTipoListState extends State<CardMovtoEstoqueTipoList> {
  MovtoEstoqueTipoListController get store => widget.store;

  showAlertDialogDeletaMovtoEstoqueTipo(
    BuildContext context,
    MovtoEstoqueTipo movtoEstoqueTipo,
  ) {
    // configura o button
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        pushReplacement(context, DashboardMateriaisModule());
        push(context, MovtoEstoqueTipoListPage());
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Sim"),
      onPressed: () async {
        MovtoEstoqueTipoController movtoEstoqueTipoController =
            MovtoEstoqueTipoController();
        await movtoEstoqueTipoController
            .verificaRelacionamentosMovtoEstoqueTipo(
                movtoEstoqueTipo: movtoEstoqueTipo,
                movtoEstoqueTipoController: movtoEstoqueTipoController);

        if (movtoEstoqueTipoController.possuiRelacao == false) {
          movtoEstoqueTipoController.deletarMovtoEstoqueTipo(
              movtoEstoqueTipo: movtoEstoqueTipo);
          pushReplacement(context, DashboardMateriaisModule());
          push(context, MovtoEstoqueTipoListPage());
          snackbarSucces(
              context: context,
              msg: "Tipo de Movto. removido com sucesso !",
              title: "Tipo de Movto. removido");
        } else {
          pushReplacement(context, DashboardMateriaisModule());
          push(context, MovtoEstoqueTipoListPage());
          snackbarError(
              context: context,
              msg:
                  "Impossível deletar tipo de movto. pois o mesmo está relacionado à um movto. de estoque !");
        }
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Excluir Tipo Movto. Estoque"),
      content: Text("Deseja realmente excluir este tipo de movto.?"),
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
        store.movtosEstoqueTipo.sort((a, b) => a.descr.compareTo(b.descr));
      } else {
        store.movtosEstoqueTipo.sort((a, b) => b.descr.compareTo(a.descr));
      }
    }
  }

  CardCustom listaMovtoEstoqueTipo() {
    List<Widget> list = List();
    list.add(
      Observer(builder: (context) {
        if (!store.hasResultsItensUnMed) {
          return Container();
        }
        if (store.movtosEstoqueTipo.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhum movimento encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchItems,
              ),
            ],
          );
        }
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
            DataColumn(
              label: Text("Tipo Movto"),
              numeric: false,
            ),
          ],
          rows: store.movtosEstoqueTipo
              .map(
                (itemTipo) => DataRow(
                  cells: [
                    DataCell(
                      Text(itemTipo.id.toString()),
                    ),
                    DataCell(
                      Text(itemTipo.descr),
                    ),
                    DataCell(
                      Text(itemTipo.cdTipoMovto),
                    ),
                  ],
                ),
              )
              .toList(),
        );*/

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
                          "DESCRIÇÃO",
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
                    DataColumn(
                      label: Text(
                        "TIPO MOVTO.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                  rows: store.movtosEstoqueTipo.map((item) {
                    // var item = Item.fromJson(data);

                    return DataRow(cells: [
                      DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.pen),
                          onPressed: () {
                            //store.listarProducaoItem(producao);
                            if (item.id == 1 || item.id == 2) {
                              snackbarError(
                                  context: context,
                                  msg:
                                      "Impossível alterar este tipo de movto !");
                            } else {
                              push(
                                  context,
                                  MovtoEstoqueTipoPage(
                                    movtoEstoqueTipo: item,
                                    storeMovtoEstoqueTipoList: store,
                                  ));
                            }
                          },
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.trash),
                          onPressed: () {
                            if (item.id == 1 || item.id == 2) {
                              snackbarError(
                                  context: context,
                                  msg:
                                      "Impossível deletar este tipo de movto !");
                            } else {
                              showAlertDialogDeletaMovtoEstoqueTipo(
                                  context, item);
                            }
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
                      DataCell(
                        Text(
                          "${item.cdTipoMovto}",
                          style: TextStyle(fontSize: 16),
                        ),
                      )
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
    return listaMovtoEstoqueTipo();
  }
}
