import 'package:bucks/src/DAO/producao_dao.dart';
import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/classes/producao_item.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_page.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/utils/number_format.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../dash_board.dart';
import '../producao_item_page.dart';
import '../producao_page.dart';

class DataTableItensProducao extends StatefulWidget {
  final List<ProducaoItem> itensProducao;
  final ProducaoListController store;
  final Producao producao;

  const DataTableItensProducao({
    Key key,
    this.itensProducao,
    this.store,
    this.producao,
  }) : super(key: key);
  @override
  _DataTableItensProducaoState createState() => _DataTableItensProducaoState();
}

class _DataTableItensProducaoState extends State<DataTableItensProducao> {
  List<ProducaoItem> get itens => widget.itensProducao;
  ProducaoListController get store => widget.store;
  Producao get producao => widget.producao;

  //get tipoDataTable => widget.tipoDataTable;
  bool sort = false;
  bool screen;
  Orientation orientation;

  showAlertDialogDeletaItemGrupo(
    //BuildContext context,
    ProducaoItem producaoItem,
  ) async {
    if (producaoItem.cdStatus != "S") {
      ProducaoListController plc = ProducaoListController();

      await plc.deletarProducaoItem(producaoItem: producaoItem);

      Navigator.of(context).pop(false);

      //await store.listarProducaoItem(producao);

      push(
          context,
          ProducaoPage(
            producao: producao,
            storeProducaoList: store,
          ));

      snackbarSucces(
          context: context,
          msg: "Producao item removida com sucesso !",
          title: "Producao item removida");
    } else {
      snackbarError(
          context: context,
          msg: "Impossível deletar este item pois o mesmo já foi baixado !");
    }
  }

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 1) {
      if (ascending) {
        itens.sort((a, b) => a.cdTipo.compareTo(b.cdTipo));
      } else {
        itens.sort((a, b) => b.cdTipo.compareTo(a.cdTipo));
      }
    }
  }

  items() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.blue,
        ),
        child: Column(
          children: <Widget>[
            DataTable(
              sortAscending: sort,
              sortColumnIndex: 1,
              columns: [
                DataColumn(
                  label: Text(
                    "DEL.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),

                DataColumn(
                  label: Text(
                    "SEQ.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                ),
                DataColumn(
                    label: Text(
                      "DESCR. ITEM",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screen ? 16 : 20),
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
                    "DESCR. PROD",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),
                DataColumn(
                  label: Text(
                    "CD TIPO",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),
                DataColumn(
                  label: Text(
                    "QTD.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),
                DataColumn(
                  label: Text(
                    "VL. UNIT.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),
                DataColumn(
                  label: Text(
                    "TOTAL",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),
                DataColumn(
                  label: Text(
                    "BAIXADO",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),

                //mostrarColuna(valorIf: 1),
                //mostrarColuna(valorIf: 2),
                //mostrarColuna(valorIf: 3),
              ],
              rows: itens
                  .map(
                    (data) => DataRow(cells: [
                      // DataCell(
                      //   IconButton(
                      //     icon: Icon(Icons.close),
                      //     onPressed: () {
                      //       store.removeItemsDataTable(item: data);
                      //     },
                      //   ),
                      // ),
                      botaoRemoveDt(data),

                      DataCell(
                        Text(
                          "${data.seq}",
                          style: TextStyle(fontSize: screen ? 16 : 20),
                        ),
                      ),

                      DataCell(
                        Text(
                          "${data.descrItem}",
                          style: TextStyle(fontSize: screen ? 16 : 20),
                        ),
                        onTap: () {
                          print(
                              'Selected ${data.descrItem} - ${data.descrProducao}');
                          snackbarInfoWithoutDuration(
                              context: context,
                              msg: "${data.descrItem} - ${data.descrProducao}");
                          //data.qt != null ? data.qt.toString() : ""
                        },
                      ),

                      DataCell(
                        Text(
                          "${data.descrProducao}",
                          style: TextStyle(fontSize: screen ? 16 : 20),
                        ),
                      ),

                      // DataCell(
                      //   TextField(
                      //       keyboardType: TextInputType.text,
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(fontSize: 20),
                      //       onSubmitted: (String value) async {
                      //         //var resp = validaPorcentagem(value, data);
                      //         setState(() {
                      //           data.cdTipo = value;
                      //         });
                      //       }),
                      // ),

                      // DataCell(
                      //   TextField(
                      //       keyboardType: TextInputType.number,
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(fontSize: 20),
                      //       onSubmitted: (String value) async {
                      //         //var resp = validaPorcentagem(value, data);
                      //         setState(() {
                      //           data.qt = num.parse(value);
                      //         });
                      //       }),
                      // ),

                      // DataCell(
                      //   TextField(
                      //       keyboardType: TextInputType.number,
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(fontSize: 20),
                      //       onSubmitted: (String value) async {
                      //         //var resp = validaPorcentagem(value, data);
                      //         setState(() {
                      //           data.vlUnit = double.parse(value);
                      //         });
                      //       }),
                      // ),

                      DataCell(
                        Text(
                          data.cdTipo != null ? data.cdTipo.toString() : "",
                          style: TextStyle(fontSize: screen ? 16 : 20),
                        ),
                      ),

                      DataCell(
                        Text(
                          //item.qtdTotal != null ? item.qtdTotal.toString() : "0",
                          data.qt != null
                              ? numberFormatThousand(value: data.qt)
                              : "",
                          //"${data.qt}".toString() ?? "0",
                          style: TextStyle(fontSize: screen ? 16 : 20),
                        ),
                      ),

                      DataCell(
                        Text(
                          data.vlUnit != null
                              ? numberFormatThousand(value: data.vlUnit)
                              : "",
                          style: TextStyle(fontSize: screen ? 16 : 20),
                        ),
                      ),
                      DataCell(
                        Text(
                          numberFormatThousand(
                              value: data.calculaVlTotal(
                                  data.qt.toString(), data.vlUnit.toString())),
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DataCell(
                        Text(
                          data.cdStatus != null ? data.cdStatus.toString() : "",
                          style: TextStyle(fontSize: screen ? 16 : 20),
                        ),
                      ),

                      // mostrarCelula(data),
                      //mostrarCelula(item: data, valorIf: 1),
                      //mostrarCelula(item: data, valorIf: 2),
                      //mostrarCelula(item: data, valorIf: 3),
                    ]),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  DataCell botaoRemoveDt(ProducaoItem data) {
    return DataCell(
      IconButton(
        icon: Icon(FontAwesomeIcons.trash),
        onPressed: () {
          showAlertDialogDeletaItemGrupo(data);
        },
      ),
    );
  }

  CardCustom listaItems() {
    List<Widget> list = List();

    list.add(items());
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
    final double shortsSide = MediaQuery.of(context).size.shortestSide;
    screen = shortsSide < 600;
    orientation = MediaQuery.of(context).orientation;
    return listaItems();
  }
}
