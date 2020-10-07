import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/pages/producao/producao_controller.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/pages/producao/producao_page.dart';
import 'package:bucks/src/pages/producao/widgets/buttonsProducao.dart';
import 'package:bucks/src/pages/producao/widgets/dropdown_find.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/utils/number_format.dart';
import 'package:bucks/src/shared/widgets/button.dart';
import 'package:bucks/src/shared/widgets/card_custom.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:bucks/src/shared/widgets/text_field_app.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CardProducao extends StatefulWidget {
  final ProducaoController store;
  final ProducaoListController storeProducaoList;
  final Producao producao;

  const CardProducao(
      {Key key,
      @required this.store,
      @required this.storeProducaoList,
      @required this.producao})
      : super(key: key);

  @override
  _CardProducaoState createState() => _CardProducaoState();
}

class _CardProducaoState extends State<CardProducao> {
  ProducaoController get store => widget.store;
  ProducaoListController get storeProducaoList => widget.storeProducaoList;
  Producao get producao => widget.producao;
  //double custoTotalProd;
  CardCustom cadastroProducao() {
    List<Widget> list = List();

    if (producao != null) {
      store.id.text = producao.id.toString();
      store.descr.text = producao.descr;
      if (producao.vlMo.toString() != "null") {
        store.vlMo.text = producao.vlMo.toString();
      }

      if (producao.vlCustosInd.toString() != "null") {
        store.vlCustosInd.text = producao.vlCustosInd.toString();
      }

      //store.fkProducaoTipoId.text = producao.fkProducaoTipoId.toString();
      store.dtProducaoIni.text = producao.dtProducaoIni;
      store.dtProducaoFim.text = producao.dtProducaoFim;
      store.cdStatus.text = producao.cdStatus;
    }

    calculaCustoProducao() async {
      if (store.id.text != "") {
        Producao producao = Producao();
        producao.id = int.parse(store.id.text);

        if (store.vlMo.text != "") {
          producao.vlMo = double.parse(store.vlMo.text);
        }

        if (store.vlCustosInd.text != "") {
          producao.vlCustosInd = double.parse(store.vlCustosInd.text);
        }

        await storeProducaoList.calculaCustoDaProducao(producao);

        snackbarInfoWithoutDuration(
            context: context,
            msg: "Custo desta produção: ${storeProducaoList.custoTotalProd}");
        return;
      } else {
        snackbarInfoWithoutDuration(
            context: context, msg: "Nenhuma produção inserida !");
      }
    }

    onPressedButtons() async {
      if (store.descr.text == "" ||
          storeProducaoList.tipoProducao.id == null ||
          store.dtProducaoIni.text == "") {
        snackbarError(
            context: context,
            msg: "Existem campos que devem ser preenchidos !");
        return;
      }

      store.salvar(
        store: store,
        storeProducaoList: storeProducaoList,
      );

      /*push(
          context,
          ProducaoListPage(
            producao: producao, 
          ));*/

      snackbarSucces(
          context: context,
          msg: "Produção inserida com sucesso !",
          title: "Producão Inserida");
    }

    //if(producao.descr == null){
    //list.add(Text('CUSTO TOTAL DESTA PRODUÇÃO:', fo,));
    /*list.add(TextFormField(
      decoration: InputDecoration(
        labelText: "ZmaskField3",
        contentPadding: EdgeInsets.all(10), // Espaçamento entre bordas e texto
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ), // Essa borda é a que você procura
      ),
      initialValue: "233.4", // Valor inicial do campo, pode ser sua variável
      enabled:
          false, // Se você só quiser mostrar o valor, sem permitir edição, coloque essa linha com false
    ));*/
    /*double custoTotalProd = storeProducaoList.custoTotalProd;
    list.add(Text(
      'Custo dessa produção: ${numberFormatThousand(value: custoTotalProd)}',
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 20, color: Colors.red),
    )); */

    list.add(TextFieldApp(
      controller: store.descr,
      text: "Digite a descrição da Produção",
    ));
    list.add(SizedBox(height: 10));

    list.add(CorDeFundo.ContainerDecorationPadrao(
        text: 'TIPO PRODUÇÃO', fontSize: 24, fontWeight: FontWeight.bold));
    list.add(DropdownFindTipoProducao(
      store2: store,
      store: storeProducaoList,
    ));

    list.add(SizedBox(height: 10));

    list.add(TextFieldApp(
      controller: store.vlMo,
      text: "Digite a Valor de Mão de Obra",
    ));
    list.add(SizedBox(height: 10));

    list.add(TextFieldApp(
      controller: store.vlCustosInd,
      text: "Digite o Valor dos Custos Indiretos",
    ));
    list.add(SizedBox(height: 10));

    list.add(TextFieldApp(
      controller: store.dtProducaoIni,
      text: "Digite a Data da Produção",
    ));
    list.add(SizedBox(height: 10));

    list.add(TextFieldApp(
      controller: store.dtProducaoFim,
      text: "Digite a Data do Fim da Produção",
    ));

    list.add(
      // Container(
      //   width: 250,
      //   child: FlatButtonApp(
      //     label: "Salvar Produção",
      //     onPressed: () =>
      //         store.salvar(store: store, storeProducaoList: storeProducaoList),
      //   ),
      // ),
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
        ),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          width: 250,
          child: AppButton(
            "Salvar Produção",
            onPressedButtons,
          ),
        ),
      ),
    );

    list.add(
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
        ),
        margin: EdgeInsets.only(top: 20),
        child: Container(
          width: 250,
          child: AppButton(
            "Custo da produção",
            calculaCustoProducao,
          ),
        ),
      ),
    );

    list.add(SizedBox(height: 25));
    // }

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
    return cadastroProducao();
  }
}

class CardProducaoList extends StatefulWidget {
  final ProducaoListController store;
  final Producao producao;

  const CardProducaoList({Key key, @required this.store, this.producao})
      : super(key: key);

  @override
  _CardProducaoListState createState() => _CardProducaoListState();
}

class _CardProducaoListState extends State<CardProducaoList> {
  ProducaoListController get store => widget.store;
  Producao get producao => widget.producao;
  double custoTotalProd = 0;

  bool sort = false;

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 2) {
      if (ascending) {
        store.producoes.sort((a, b) => a.descr.compareTo(b.descr));
      } else {
        store.producoes.sort((a, b) => b.descr.compareTo(a.descr));
      }
    }
  }

  CardCustom listaProducao() {
    List<Widget> list = List();
    list.add(
      Observer(builder: (context) {
        if (!store.hasResultsProducao) {
          return Container();
        }
        if (store.producoes.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhuma produção encontrada. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchItems,
              ),
            ],
          );
        }
        /*return DataTable(
          columns: [
            DataColumn(
              label: Text(""),
              numeric: false,
            ),
            DataColumn(
              label: Text("ID"),
              numeric: false,
            ),
            DataColumn(
              label: Text("TIPO"),
              numeric: false,
            ),
            DataColumn(
              label: Text("DESCRIÇÃO"),
              numeric: false,
            ),
            DataColumn(
              label: Text("DATA INI"),
              numeric: false,
            ),
            DataColumn(
              label: Text("DATA FIM"),
              numeric: false,
            ),
            DataColumn(
              label: Text("STATUS"),
              numeric: false,
            ),
          ],
          rows: store.producoes
              .map(
                (producao) => DataRow(
                  cells: [
                    DataCell(
                      IconButton(
                        icon: Icon(FontAwesomeIcons.pen),
                        onPressed: () {
                          //store.listarProducaoItem(producao);

                          push(
                              context,
                              ProducaoPage(
                                  storeProducaoList: store,
                                  producao: producao));
                        },
                      ),
                    ),
                    DataCell(
                      Text(producao.id.toString()),
                    ),
                    DataCell(
                      Text(producao.fkProducaoTipoId.toString()),
                    ),
                    DataCell(
                      Text(producao.descr),
                    ),
                    DataCell(
                      Text(producao.dtProducaoIni != null
                          ? producao.dtProducaoIni.toString()
                          : ""),
                    ),
                    DataCell(
                      Text(producao.dtProducaoFim != null
                          ? producao.dtProducaoFim.toString()
                          : ""),
                    ),
                    DataCell(
                      Text(producao.cdStatus != null
                          ? producao.cdStatus.toString()
                          : ""),
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
                  sortColumnIndex: 2,
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
                        "ID",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
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
                        "TIPO",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text(
                        "VL. MÃO OBRA",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text(
                        "VL. CUSTOS IND.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text(
                        "DT. INIC.",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "DT. FIM",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "STATUS",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                    ),
                  ],
                  rows: store.producoes.map((item) {
                    // var item = Item.fromJson(data);

                    return DataRow(cells: [
                      DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.pen),
                          onPressed: () async {
                            await store.listarProducaoItem(item);
                            await store.fetchTipoProducaoAlteracao(item.id);

                            push(
                                context,
                                ProducaoPage(
                                    storeProducaoList: store, producao: item));
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
                        onTap: () async {
                          await store.calculaCustoDaProducao(item);
                          print('Selected ${item.descr}');
                          snackbarInfoWithoutDuration(
                              context: context,
                              msg:
                                  "${item.descr} - Custo total da produção: ${numberFormatThousand(value: store.custoTotalProd)}");
                          //"${item.descr} - Custo total da produção: ${store.calculaCustoDaProducao(item)}");
                          //data.qt != null ? data.qt.toString() : ""
                        },
                      ),
                      DataCell(
                        Text(
                          "${item.fkProducaoTipoId} - ${item.fkProducaoTipoDescr}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.vlMo != null ? item.vlMo.toString() : "",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.vlCustosInd != null
                              ? item.vlCustosInd.toString()
                              : "",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.dtProducaoIni != null
                              ? item.dtProducaoIni.toString()
                              : "",
                          // "${item.itemTipoDescr}",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.dtProducaoFim != null
                              ? item.dtProducaoFim.toString()
                              : "",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      DataCell(
                        Text(
                          item.cdStatus != null ? item.cdStatus.toString() : "",
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
    return listaProducao();
  }
}

class CardButtonProducao extends StatefulWidget {
  final dynamic store;

  const CardButtonProducao({Key key, @required this.store}) : super(key: key);

  @override
  _CardButtonProducao createState() => _CardButtonProducao();
}

class _CardButtonProducao extends State<CardButtonProducao> {
  CardCustom buttons() {
    List<Widget> list = List();

    list.add(ButtonsProducao(
      store: widget.store,
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
    return buttons();
  }
}
