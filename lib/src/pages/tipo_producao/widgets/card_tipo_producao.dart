import 'package:bucks/src/classes/item_tipo.dart';
import 'package:bucks/src/classes/tipo_producao.dart';
import 'package:bucks/src/pages/item_tipo/item_tipo_list/item_tipo_list_controller.dart';
import 'package:bucks/src/pages/item_tipo/item_tipo_list/item_tipo_list_page.dart';
import 'package:bucks/src/pages/item_tipo/item_tipo_page.dart';
import 'package:bucks/src/pages/tipo_producao/tipo_producao_list/tipo_producao_list_controller.dart';
import 'package:bucks/src/pages/tipo_producao/tipo_producao_list/tipo_producao_list_page.dart';
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
import '../tipo_producao_controller.dart';
import '../tipo_producao_page.dart';

class CardTipoProducao extends StatefulWidget {
  final TipoProducaoController store;
  final TipoProducaoListController storeItemTipoProducaoList;
  final TipoProducao tipoProducao;

  const CardTipoProducao({
    Key key,
    @required this.store,
    @required this.storeItemTipoProducaoList,
    @required this.tipoProducao,
  }) : super(key: key);

  @override
  _CardTipoProducaoState createState() => _CardTipoProducaoState();
}

class _CardTipoProducaoState extends State<CardTipoProducao> {
  TipoProducaoController get store => widget.store;
  TipoProducaoListController get storeItemTipoProducaoList =>
      widget.storeItemTipoProducaoList;
  TipoProducao get tipoProducao => widget.tipoProducao;

  CardCustom cadastroTipoProducao() {
    onPressedButtons() async {
      if (store.descr.text == "") {
        snackbarError(
            context: context, msg: "Informe a descrição do tipo de produção !");
        return;
      }

      store.salvarTipoProducao(
          store: store, storeTipoProducaoList: storeItemTipoProducaoList);
      snackbarSucces(
          context: context,
          msg: "Tipo de produção inserido com sucesso !",
          title: "Tipo de produção Inserido");
    }

    List<Widget> list = List();
    list.add(TextFieldApp(
      controller: store.descr,
      text: "Digite a descrição do Tipo do Produção",
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
    return cadastroTipoProducao();
  }
}

class CardTipoProducaoList extends StatefulWidget {
  final TipoProducaoListController store;

  const CardTipoProducaoList({Key key, @required this.store}) : super(key: key);

  @override
  _CardTipoProducaoListState createState() => _CardTipoProducaoListState();
}

class _CardTipoProducaoListState extends State<CardTipoProducaoList> {
  TipoProducaoListController get store => widget.store;

  showAlertDialogDeletaTipoProducao(
    BuildContext context,
    TipoProducao tipoProducao,
  ) {
    // configura o button
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        pushReplacement(context, DashboardMateriaisModule());
        push(context, TipoProducaoListPage());
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Sim"),
      onPressed: () async {
        TipoProducaoController tpc = TipoProducaoController();
        await tpc.verificaRelacionamentosTipoProducao(
            tipoProducao: tipoProducao, tipoProducaoController: tpc);

        if (tpc.possuiRelacao == false) {
          tpc.deletarTipoProducao(tipoProducao: tipoProducao);
          pushReplacement(context, DashboardMateriaisModule());
          push(context, TipoProducaoListPage());
          snackbarSucces(
              context: context,
              msg: "Tipo produção removido com sucesso !",
              title: "Tipo produção removido");
        } else {
          pushReplacement(context, DashboardMateriaisModule());
          push(context, TipoProducaoListPage());
          snackbarError(
              context: context,
              msg:
                  "Impossível deletar tipo de produção pois o mesmo está relacionado à um item !");
        }
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Excluir Tipo de Produção"),
      content: Text("Deseja realmente excluir este tipo de produção?"),
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
        store.tiposProducao.sort((a, b) => a.descr.compareTo(b.descr));
      } else {
        store.tiposProducao.sort((a, b) => b.descr.compareTo(a.descr));
      }
    }
  }

  CardCustom listaItemTipo() {
    List<Widget> list = List();
    list.add(
      Observer(builder: (context) {
        if (!store.hasResultsTiposProducao) {
          return Container();
        }
        if (store.tiposProducao.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhum tipo de produção encontrada. \nClique aqui para tentar novamente.',
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
                  rows: store.tiposProducao.map((item) {
                    // var item = Item.fromJson(data);

                    return DataRow(cells: [
                      DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.pen),
                          onPressed: () {
                            //store.listarProducaoItem(producao);
                            push(
                                context,
                                TipoProducaoPage(
                                  storeItemTipoProducaoList: store,
                                  tipoProducao: item,
                                ));
                          },
                        ),
                      ),
                      DataCell(
                        IconButton(
                          icon: Icon(FontAwesomeIcons.trash),
                          onPressed: () {
                            showAlertDialogDeletaTipoProducao(context, item);
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
