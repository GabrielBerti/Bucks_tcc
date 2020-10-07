import 'package:bucks/src/classes/producao_item.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/shared/utils/number_format.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';

class DatatableProducaoItemEstoqueEntrada extends StatefulWidget {
  final List<ProducaoItem> itensProducao;
  final ProducaoListController store;

  const DatatableProducaoItemEstoqueEntrada({
    Key key,
    this.itensProducao,
    this.store,
  }) : super(key: key);
  @override
  _DatatableProducaoItemEstoqueEntradaState createState() =>
      _DatatableProducaoItemEstoqueEntradaState();
}

class _DatatableProducaoItemEstoqueEntradaState
    extends State<DatatableProducaoItemEstoqueEntrada> {
  List<ProducaoItem> get itens => widget.itensProducao;
  ProducaoListController get store => widget.store;
  //get tipoDataTable => widget.tipoDataTable;
  bool sort = false;
  bool screen;
  Orientation orientation;

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
                    "REM.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),

                //     numeric: false,
                //     onSort: (columnIndex, ascending) {
                //       setState(() {
                //         sort = !sort;
                //       });
                //       onSortColum(columnIndex, ascending);
                //     }),
                DataColumn(
                  label: Text(
                    "DESCR. ITEM",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),
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

                      // DataCell(
                      //   Text(
                      //     "${data.seq}",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

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
                      DataCell(
                        Text(
                          data.cdTipo != null ? data.cdTipo.toString() : "",
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

                      DataCell(
                        TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            onSubmitted: (String value) async {
                              //var resp = validaPorcentagem(value, data);
                              setState(() {
                                if (value != '') {
                                  data.qt = double.parse(value);
                                }
                              });
                            }),
                      ),

                      DataCell(
                        TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            onSubmitted: (String value) async {
                              //var resp = validaPorcentagem(value, data);
                              setState(() {
                                data.vlUnit = double.parse(value);
                              });
                            }),
                      ),

                      // DataCell(
                      //   Text(
                      //     "${data.cdTipo}".toString() ?? "0",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

                      // DataCell(
                      //   Text(
                      //     //item.qtdTotal != null ? item.qtdTotal.toString() : "0",
                      //     data.qt != null ? data.qt.toString() : "",
                      //     //"${data.qt}".toString() ?? "0",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

                      // DataCell(
                      //   Text(
                      //     "${data.vlUnit}".toString() ?? "0",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

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
        icon: Icon(Icons.close),
        onPressed: () {
          store.removeitemsDataTableEntrada(data);
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

  // bool validaPorcentagem(String value, Item data) {
  //   var qtde = num.parse(value);
  //   var porc = (1 * 0.20) + 1;
  //   print('20% Porc. > $porc');
  //   if (qtde > porc) {
  //     print('Não pode solicitar mais de 20% da Qtde');
  //     return false;
  //   } else {
  //     print('Qtde ok');
  //     return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double shortsSide = MediaQuery.of(context).size.shortestSide;
    screen = shortsSide < 600;
    orientation = MediaQuery.of(context).orientation;
    return listaItems();
  }
}

//--------------------------------------------------------------------
class DatatableProducaoItemSaida extends StatefulWidget {
  final List<ProducaoItem> itensProducao;
  final ProducaoListController store;

  const DatatableProducaoItemSaida({
    Key key,
    this.itensProducao,
    this.store,
  }) : super(key: key);
  @override
  _DatatableProducaoItemSaidaState createState() =>
      _DatatableProducaoItemSaidaState();
}

class _DatatableProducaoItemSaidaState
    extends State<DatatableProducaoItemSaida> {
  List<ProducaoItem> get itens => widget.itensProducao;
  ProducaoListController get store => widget.store;
  //get tipoDataTable => widget.tipoDataTable;
  bool sort = false;
  bool screen;
  Orientation orientation;

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
                    "REM.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),

                // DataColumn(
                //     label: Text(
                //       "SEQ.",
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: screen ? 16 : 20),
                //     ),
                //     numeric: false,
                //     onSort: (columnIndex, ascending) {
                //       setState(() {
                //         sort = !sort;
                //       });
                //       onSortColum(columnIndex, ascending);
                //     }),
                DataColumn(
                  label: Text(
                    "DESCR. ITEM",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),
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

                      // DataCell(
                      //   Text(
                      //     "${data.seq}",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

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
                      DataCell(
                        Text(
                          data.cdTipo != null ? data.cdTipo.toString() : "",
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

                      DataCell(
                        TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            onSubmitted: (String value) async {
                              //var resp = validaPorcentagem(value, data);
                              setState(() {
                                if (value != '') {
                                  data.qt = double.parse(value);
                                }
                              });
                            }),
                      ),

                      DataCell(
                        TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            onSubmitted: (String value) async {
                              //var resp = validaPorcentagem(value, data);
                              setState(() {
                                data.vlUnit = double.parse(value);
                              });
                            }),
                      ),

                      // DataCell(
                      //   Text(
                      //     "${data.cdTipo}".toString() ?? "0",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

                      // DataCell(
                      //   Text(
                      //     //item.qtdTotal != null ? item.qtdTotal.toString() : "0",
                      //     data.qt != null ? data.qt.toString() : "",
                      //     //"${data.qt}".toString() ?? "0",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

                      // DataCell(
                      //   Text(
                      //     "${data.vlUnit}".toString() ?? "0",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

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
        icon: Icon(Icons.close),
        onPressed: () {
          store.removeitemsDtSaida(data);
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

  // bool validaPorcentagem(String value, Item data) {
  //   var qtde = num.parse(value);
  //   var porc = (1 * 0.20) + 1;
  //   print('20% Porc. > $porc');
  //   if (qtde > porc) {
  //     print('Não pode solicitar mais de 20% da Qtde');
  //     return false;
  //   } else {
  //     print('Qtde ok');
  //     return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double shortsSide = MediaQuery.of(context).size.shortestSide;
    screen = shortsSide < 600;
    orientation = MediaQuery.of(context).orientation;
    return listaItems();
  }
}

//--------------------------------------------------------------------
class DatatableItensIndiretos extends StatefulWidget {
  final List<ProducaoItem> itensProducao;
  final ProducaoListController store;

  const DatatableItensIndiretos({
    Key key,
    this.itensProducao,
    this.store,
  }) : super(key: key);
  @override
  _DatatableItensIndiretosState createState() =>
      _DatatableItensIndiretosState();
}

class _DatatableItensIndiretosState extends State<DatatableItensIndiretos> {
  List<ProducaoItem> get itens => widget.itensProducao;
  ProducaoListController get store => widget.store;
  //get tipoDataTable => widget.tipoDataTable;
  bool sort = false;
  bool screen;
  Orientation orientation;

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
                    "REM.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),

                // DataColumn(
                //     label: Text(
                //       "SEQ.",
                //       style: TextStyle(
                //           fontWeight: FontWeight.bold,
                //           fontSize: screen ? 16 : 20),
                //     ),
                //     numeric: false,
                //     onSort: (columnIndex, ascending) {
                //       setState(() {
                //         sort = !sort;
                //       });
                //       onSortColum(columnIndex, ascending);
                //     }),
                DataColumn(
                  label: Text(
                    "DESCR. ITEM",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: screen ? 16 : 20),
                  ),
                  numeric: false,
                ),
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

                      // DataCell(
                      //   Text(
                      //     "${data.seq}",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

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
                      DataCell(
                        Text(
                          data.cdTipo != null ? data.cdTipo.toString() : "",
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

                      DataCell(
                        TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            onSubmitted: (String value) async {
                              //var resp = validaPorcentagem(value, data);
                              setState(() {
                                if (value != '') {
                                  data.qt = double.parse(value);
                                }
                              });
                            }),
                      ),

                      DataCell(
                        TextField(
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                            onSubmitted: (String value) async {
                              //var resp = validaPorcentagem(value, data);
                              setState(() {
                                if (value != '') {
                                  data.vlUnit = double.parse(value);
                                }
                              });
                            }),
                      ),

                      // DataCell(
                      //   Text(
                      //     "${data.cdTipo}".toString() ?? "0",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

                      // DataCell(
                      //   Text(
                      //     //item.qtdTotal != null ? item.qtdTotal.toString() : "0",
                      //     data.qt != null ? data.qt.toString() : "",
                      //     //"${data.qt}".toString() ?? "0",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

                      // DataCell(
                      //   Text(
                      //     "${data.vlUnit}".toString() ?? "0",
                      //     style: TextStyle(fontSize: screen ? 16 : 20),
                      //   ),
                      // ),

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
        icon: Icon(Icons.close),
        onPressed: () {
          store.removeitemsIndiretosDt(data);
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

  // bool validaPorcentagem(String value, Item data) {
  //   var qtde = num.parse(value);
  //   var porc = (1 * 0.20) + 1;
  //   print('20% Porc. > $porc');
  //   if (qtde > porc) {
  //     print('Não pode solicitar mais de 20% da Qtde');
  //     return false;
  //   } else {
  //     print('Qtde ok');
  //     return true;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final double shortsSide = MediaQuery.of(context).size.shortestSide;
    screen = shortsSide < 600;
    orientation = MediaQuery.of(context).orientation;
    return listaItems();
  }
}
