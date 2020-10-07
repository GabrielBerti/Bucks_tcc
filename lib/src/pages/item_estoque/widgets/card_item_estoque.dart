import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:bucks/src/shared/utils/formatar_id_descr.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/utils/number_format.dart';
import 'package:bucks/src/shared/widgets/button.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:bucks/src/shared/widgets/text_field_app.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../dash_board.dart';
import '../item_estoque_list_controller.dart';
import '../item_estoque_list_page.dart';

class CardItemEstoqueList extends StatefulWidget {
  final ItemEstoqueListController store;

  const CardItemEstoqueList({Key key, @required this.store}) : super(key: key);

  @override
  _CardItemEstoqueListState createState() => _CardItemEstoqueListState();
}

class _CardItemEstoqueListState extends State<CardItemEstoqueList> {
  ItemEstoqueListController get store => widget.store;

  showAlertDialogDeletaItemGrupo(
    BuildContext context,
    ItemEstoque itemEstoque,
  ) {
    // configura o button
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        pushReplacement(context, DashboardMateriaisModule());
        push(context, ItemEstoqueListPage());
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Sim"),
      onPressed: () async {
        ItemEstoqueListController iec = ItemEstoqueListController();

        await iec.verificaRelacionamentosMovtoEstoque(
            itemEstoque: itemEstoque, itemEstoqueListController: iec);

        if (iec.possuiRelacao == false) {
          iec.deletarItemEstoque(itemEstoque: itemEstoque);
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemEstoqueListPage());
          snackbarSucces(
              context: context,
              msg: "Item grupo removido com sucesso !",
              title: "Item grupo removido");
        } else {
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemEstoqueListPage());
          snackbarError(
              context: context,
              msg:
                  "Impossível deletar item do estoque pois o mesmo está relacionado à um movto. do estoque !");
        }
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Excluir Item Estoque"),
      content: Text("Deseja realmente excluir este item do estoque?"),
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
    if (columnIndex == 0) {
      if (ascending) {
        store.itemsEstoque
            .sort((a, b) => a.fkItemDescr.compareTo(b.fkItemDescr));
      } else {
        store.itemsEstoque
            .sort((a, b) => b.fkItemDescr.compareTo(a.fkItemDescr));
      }
    }
  }

  onPressedButtons() async {
    await store.filtraItemEstoque();
  }

  CardCustom listaItemEstoque() {
    List<Widget> list = List();

    list.add(Row(
      children: <Widget>[
        Expanded(
          flex: 3,
          child: Column(
            children: <Widget>[
              // CorDeFundo.ContainerDecorationPadrao(
              //     text: 'Id Item', fontSize: 24, fontWeight: FontWeight.bold),
              //SizedBox(height: 10),
              TextFieldApp(
                controller: store.idItemCons,
                text: "Id do item",
              )
            ],
          ),
        ),
        Expanded(
          flex: 6,
          child: Column(
            children: <Widget>[
              //CorDeFundo.ContainerDecorationPadrao(
              //    text: 'Descr. Item',
              //    fontSize: 24,
              //    fontWeight: FontWeight.bold),
              // SizedBox(height: 10),
              TextFieldApp(
                controller: store.descrItemCons,
                text: "Digite a descrição do item",
              )
            ],
          ),
        ),
      ],
    ));

    list.add(Row(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
          ),
          margin: EdgeInsets.only(top: 20),
          child: Container(
            width: 340,
            child: AppButton(
              "Pesquisar",
              onPressedButtons,
            ),
          ),
        ),
      ],
    ));

    list.add(SizedBox(height: 10));
    list.add(SizedBox(height: 10));
    list.add(CorDeFundo.ContainerDecorationPadrao(
        text: 'ITEM ESTOQUE', fontSize: 24, fontWeight: FontWeight.bold));
    //list.add(SizedBox(height: 10));

    list.add(
      Observer(builder: (context) {
        if (!store.hasResults) {
          return Container();
        }
        if (store.itemsEstoque.isEmpty) {
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
            DataColumn(label: Text("Item"), numeric: false),
            DataColumn(label: Text("Un."), numeric: false),
            DataColumn(label: Text("Saldo"), numeric: false),
            DataColumn(label: Text("Valor Unit."), numeric: false),
            DataColumn(label: Text("Total"), numeric: false),
            DataColumn(label: Text("Qtd. Reservado"), numeric: false),
          ],
          rows: store.itemsEstoque
              .map(
                (item) => DataRow(
                  cells: [
                    DataCell(Text(item.fkItemId.toString() +
                        ') ' +
                        item.fkItemDescr.toString())),
                    DataCell(Text(formatarIdDescr(
                        item.fkItemUnmedId.toString(), item.fkItemUnmedDescr))),
                    DataCell(Text(item.qtSaldo.toString())),
                    DataCell(Text(item.vlUnit.toString())),
                    DataCell(Text((item.calculaVlTotal(
                            item.qtSaldo.toString(), item.vlUnit.toString()))
                        .toString())),
                    DataCell(Text(item.qtReservado.toString())),
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
                  sortColumnIndex: 0,
                  columns: [
                    /*DataColumn(
                      label: Text(
                        "",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      numeric: false,
                    ),*/
                    DataColumn(
                        label: Text(
                          "ITEM",
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
                        "SALDO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "VALOR UNIT.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "TOTAL",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    /*DataColumn(
                      label: Text(
                        "QTD.",
                        style: TextStyle( 
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),*/
                  ],
                  rows: store.itemsEstoque.map((item) {
                    // var item = Item.fromJson(data);

                    return DataRow(cells: [
                      /*DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.trash),
                          onPressed: () {
                            showAlertDialogDeletaItemGrupo(context, item);
                          },
                        ),
                      ),*/
                      DataCell(
                        Text(
                          "${item.fkItemId}" + " - " + "${item.fkItemDescr}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DataCell(
                        Text(
                          //"${item.qtSaldo}",
                          item.qtSaldo != null ? item.qtSaldo.toString() : "",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DataCell(
                        Text(
                          //"${item.vlUnit}",
                          item.vlUnit != null
                              ? numberFormatThousand(value: item.vlUnit)
                              : "",

                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DataCell(
                        Text(
                          //"RS " +
                          numberFormatThousand(
                              value: item.calculaVlTotal(
                                  item.qtSaldo.toString(),
                                  item.vlUnit.toString())),
                          /*item
                              .calculaVlTotal(item.qtSaldo.toString(),
                                  item.vlUnit.toString())
                              .toString(),*/
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      /*DataCell(
                        Text(
                          //"${item.qtReservado}",
                          item.qtReservado != null
                              ? numberFormatThousand(value: item.qtReservado)
                              : "",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),*/
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
    return listaItemEstoque();
  }
}
