import 'package:bucks/src/classes/item_unmed.dart';
import 'package:bucks/src/pages/item_unmed/item_unmed_list/item_unmed_list_controller.dart';
import 'package:bucks/src/pages/item_unmed/item_unmed_list/item_unmed_list_page.dart';
import 'package:bucks/src/pages/item_unmed/widgets/buttons.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:bucks/src/shared/widgets/text_field_app.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../dash_board.dart';
import '../item_unmed_controller.dart';
import '../item_unmed_page.dart';

class CardItemUnmed extends StatefulWidget {
  final ItemUnmedController store;
  final ItemUnmedListController storeItemUnmedList;

  const CardItemUnmed(
      {Key key, @required this.store, @required this.storeItemUnmedList})
      : super(key: key);

  @override
  _CardItemUnmedState createState() => _CardItemUnmedState();
}

class _CardItemUnmedState extends State<CardItemUnmed> {
  ItemUnmedController get store => widget.store;
  ItemUnmedListController get storeItemUnmedList => widget.storeItemUnmedList;

  CardCustom cadastroItemUnmed() {
    List<Widget> list = List();
    list.add(TextFieldApp(
      controller: store.id,
      text: "Digite o código da Unidade de Medida",
    ));
    list.add(SizedBox(height: 10));
    list.add(TextFieldApp(
      controller: store.descr,
      text: "Digite a descrição da Unidade de Medida",
    ));
    list.add(SizedBox(height: 10));
    /*list.add(
      Container(
        width: 250,
        child: FlatButtonApp(
          label: "Salvar",
          onPressed: () => store.salvar(
              store: store, storeItemUnmedList: storeItemUnmedList),
        ),
      ),
    );*/

    list.add(Buttons(
      store: store,
      storeItemUnMedList: storeItemUnmedList,
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
    return cadastroItemUnmed();
  }
}

class CardItemUnmedList extends StatefulWidget {
  final ItemUnmedListController store;

  const CardItemUnmedList({Key key, @required this.store}) : super(key: key);

  @override
  _CardItemUnmedListState createState() => _CardItemUnmedListState();
}

class _CardItemUnmedListState extends State<CardItemUnmedList> {
  ItemUnmedListController get store => widget.store;

  showAlertDialogDeletaItemUnmed(
    BuildContext context,
    ItemUnmed itemUnmed,
  ) {
    // configura o button
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        pushReplacement(context, DashboardMateriaisModule());
        push(context, ItemUnmedListPage());
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Sim"),
      onPressed: () async {
        ItemUnmedController itemUnmedController = ItemUnmedController();
        await itemUnmedController.verificaRelacionamentosItemUnmed(
            itemUnmed: itemUnmed, itemUnmedController: itemUnmedController);

        if (itemUnmedController.possuiRelacao == false) {
          itemUnmedController.deletarItemUnmed(itemUnmed: itemUnmed);
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemUnmedListPage());
          snackbarSucces(
              context: context,
              msg: "Un. Medida removida com sucesso !",
              title: "Un. Medida removida");
        } else {
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemUnmedListPage());
          snackbarError(
              context: context,
              msg:
                  "Impossível deletar Un. Medida de item pois a mesma está relacionado à um item !");
        }
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Excluir Un. Medida"),
      content: Text("Deseja realmente excluir esta Un. Medida?"),
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
        store.itensUnmed.sort((a, b) => a.descr.compareTo(b.descr));
      } else {
        store.itensUnmed.sort((a, b) => b.descr.compareTo(a.descr));
      }
    }
  }

  CardCustom listaItemUnmed() {
    List<Widget> list = List();
    list.add(
      Observer(builder: (context) {
        if (!store.hasResultsItensUnmed) {
          return Container();
        }
        if (store.itensUnmed.isEmpty) {
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
          rows: store.itensUnmed
              .map(
                (itemTipo) => DataRow(
                  cells: [
                    DataCell(
                      Text(itemTipo.id.toString()),
                    ),
                    DataCell(
                      Text(itemTipo.descr),
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
                  ],
                  rows: store.itensUnmed.map((item) {
                    // var item = Item.fromJson(data);

                    return DataRow(cells: [
                      DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.pen),
                          onPressed: () {
                            //store.listarProducaoItem(producao);
                            push(
                                context,
                                ItemUnmedPage(
                                  storeItemUnmedList: store,
                                  itemUnMed: item,
                                ));
                          },
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.trash),
                          onPressed: () {
                            showAlertDialogDeletaItemUnmed(context, item);
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
    return listaItemUnmed();
  }
}
