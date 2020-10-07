import 'package:bucks/src/classes/item_tipo.dart';
import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/pages/item/item_controller.dart';
import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:bucks/src/pages/item/item_list/item_list_page.dart';
import 'package:bucks/src/pages/item/widgets/dropdown_find.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:bucks/src/shared/utils/formatar_id_descr.dart';
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
import '../item_page.dart';

class CardItem extends StatefulWidget {
  final ItemController store;
  final ItemListController storeItemList;
  final Item item;

  CardItem(
      {Key key,
      @required this.store,
      @required this.storeItemList,
      @required this.item})
      : super(key: key);

  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  ItemController get store => widget.store;
  ItemListController get storeItemList => widget.storeItemList;
  Item get item => widget.item;

  CardCustom cadastroItem() {
    List<Widget> list = List();

    onPressedButtons() async {
      if (store.descricao.text == '' ||
          storeItemList.itemTipo == null ||
          storeItemList.itemGrupo == null ||
          storeItemList.itemUnmed == null) {
        snackbarError(
            context: context,
            msg: "Existem campos que não estão preenchidos !");
      } else if (store.cdControlaEstoque.text == null ||
          (store.cdControlaEstoque.text != 'S' &&
              store.cdControlaEstoque.text != 'N' &&
              store.cdControlaEstoque.text != 's' &&
              store.cdControlaEstoque.text != 'n')) {
        snackbarError(context: context, msg: "Código do estoque inválido !");
      } else if ((store.cdControlaEstoque.text == 'n' ||
              store.cdControlaEstoque.text == 'N') &&
          store.qtdMinEstoque.text != "") {
        snackbarError(
            context: context,
            msg:
                "Não é possível informar a qtd. mínima do item no estoque quando o item não é controlado por estoque !");
      } else {
        store.salvarItem(store: store, storeItemList: storeItemList);
        snackbarSucces(
            context: context,
            msg: "Item inserido com sucesso !",
            title: "Item Inserido");
      }
    }

    //list.add(CorDeFundo.ContainerDecorationPadrao(
    //    text: 'Descrição', fontSize: 20, fontWeight: FontWeight.bold));
    list.add(TextFieldApp(
      controller: store.descricao,
      text: "Digite a descrição do Item",
    ));

    list.add(TextFieldApp(
      controller: store.cdControlaEstoque,
      text: "Digite o cd. estoque(N=SERVIÇO, S=ESTOQUE)",
    ));

    list.add(TextFieldApp(
      controller: store.qtdMinEstoque,
      text: "Digite o valor mínimo do item no estoque",
    ));

    list.add(SizedBox(height: 20));
    list.add(CorDeFundo.ContainerDecorationPadrao(
        text: 'ITEM TIPO', fontSize: 24, fontWeight: FontWeight.bold));

    list.add(DropdownFindItemTipo(
      store: storeItemList,
      item: item,
    ));
    list.add(SizedBox(height: 10));

    list.add(CorDeFundo.ContainerDecorationPadrao(
        text: 'ITEM GRUPO', fontSize: 24, fontWeight: FontWeight.bold));
    list.add(DropdownFindItemGrupo(store: storeItemList));
    list.add(SizedBox(height: 10));

    list.add(CorDeFundo.ContainerDecorationPadrao(
        text: 'ITEM UN. MEDIDA', fontSize: 24, fontWeight: FontWeight.bold));
    list.add(DropdownFindItemUnMed(store: storeItemList));
    list.add(SizedBox(height: 10));

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

    /*list.add(Buttons(
      store: store,
      storeItemList: storeItemList,
    ));*/

    /*list.add(
      Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
      ),
      margin: EdgeInsets.only(top: 20),
      child: Container(
                width: 550,
                child:  AppButton(
                "Salvarrr",
                validaItem(data: store, storeItemList: storeItemList),
              ),
                /*FlatButtonApp(
                  label: "Salvar",
                  onPressed: () => validaItem(data: store, storeItemList: storeItemList),
                ),*/
              ),
      ),
    );*/

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
    return cadastroItem();
  }
}

class CardItemList extends StatefulWidget {
  final ItemListController store;
  final ItemTipo itemTipo;

  const CardItemList({Key key, @required this.store, @required this.itemTipo})
      : super(key: key);

  @override
  _CardItemListState createState() => _CardItemListState();
}

class _CardItemListState extends State<CardItemList> {
  ItemListController get store => widget.store;
  ItemTipo itemTipo;

  showAlertDialogDeletaItem(
    BuildContext context,
    Item item,
  ) {
    // configura o button
    Widget cancelButton = FlatButton(
      child: Text("Cancelar"),
      onPressed: () {
        pushReplacement(context, DashboardMateriaisModule());
        push(context, ItemListPage());
      },
    );
    Widget confirmButton = FlatButton(
      child: Text("Sim"),
      onPressed: () async {
        ItemController ic = ItemController();
        await ic.verificaRelacionamentosItemEstoque(
            item: item, itemController: ic);

        await ic.verificaRelacionamentosMovtoEstoque(
            item: item, itemController: ic);

        await ic.verificaRelacionamentosProdItem(
            item: item, itemController: ic);

        if (ic.possuiRelacaoItemEstoque == false &&
            ic.possuiRelacaoMovtoEstoque == false &&
            ic.possuiRelacaoProdItem == false) {
          ic.deletarItem(item: item);
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemListPage());
          snackbarSucces(
              context: context,
              msg: "Item removido com sucesso !",
              title: "Item removido");
        } else {
          pushReplacement(context, DashboardMateriaisModule());
          push(context, ItemListPage());

          String wMsg;

          if (ic.possuiRelacaoItemEstoque == true) {
            wMsg = "Impossível deletar o item pois o mesmo existe no estoque !";
          } else if (ic.possuiRelacaoMovtoEstoque == true) {
            wMsg =
                "Impossível deletar o item pois o mesmo possui movto. estoque !";
          } else if (ic.possuiRelacaoProdItem == true) {
            wMsg =
                "Impossível deletar o item pois o mesmo possui produções relacionadas à ele !";
          }

          snackbarError(context: context, msg: wMsg);
        }
      },
    );
    // configura o  AlertDialog
    AlertDialog alerta = AlertDialog(
      title: Text("Excluir Item"),
      content: Text("Deseja realmente excluir este item?"),
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

  List<Item> itens;

  onSortColum(int columnIndex, bool ascending) {
    if (columnIndex == 3) {
      if (ascending) {
        store.itens.sort((a, b) => a.descr.compareTo(b.descr));
      } else {
        store.itens.sort((a, b) => b.descr.compareTo(a.descr));
      }
    }
  }

  CardCustom listaItem() {
    List<Widget> list = List();
    list.add(
      Observer(
        builder: (context) {
          if (!store.hasResultsItens) {
            return Container();
          }

          if (store.itens.isEmpty) {
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
                      DataColumn(
                        label: Text(
                          "CD EST.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                        label: Text(
                          "QTD. MIN. EST.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        numeric: false,
                      ),
                      DataColumn(
                        label: Text(
                          "ITEM TIPO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "ITEM GRUPO",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "ITEM UN. MED.",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                      ),
                    ],
                    rows: store.itens.map((item) {
                      // var item = Item.fromJson(data);

                      return DataRow(cells: [
                        DataCell(
                          IconButton(
                            icon: Icon(FontAwesomeIcons.pen),
                            onPressed: () async {
                              //store.listarProducaoItem(producao);
                              await store.fetchItemTipoAlteracao(item.id);
                              await store.fetchItemGrupoAlteracao(item.id);
                              await store.fetchItemUnMedAlteracao(item.id);
                              push(
                                  context,
                                  ItemPage(
                                    item: item,
                                    storeItemList: store,
                                    isAlteracao: true,
                                  ));
                            },
                          ),
                        ),
                        DataCell(
                          IconButton(
                            icon: Icon(FontAwesomeIcons.trash),
                            onPressed: () {
                              showAlertDialogDeletaItem(context, item);
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
                            //"${item.cdControlaEstoque}",
                            item.cdControlaEstoque != null
                                ? item.cdControlaEstoque.toString()
                                : "",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        DataCell(
                          Text(
                            //"${item.cdControlaEstoque}",
                            item.qtdMinEstoque != null
                                ? item.qtdMinEstoque.toString()
                                : "",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        DataCell(
                          Text(
                            "${item.fkItemTipoId} - ${item.itemTipoDescr}",
                            //formatarIdDescr(item.fkItemTipoId.toString(),item.itemTipoDescr),

                            // "${item.itemTipoDescr}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        DataCell(
                          Text(
                            //formatarIdDescr(item.fkItemGrupoId.toString(),item.itemGrupoDescr),
                            "${item.fkItemGrupoId} - ${item.itemGrupoDescr}",
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        DataCell(
                          Text(
                            //formatarIdDescr(item.fkItemUnmedId, item.itemUnMedDescr),
                            "${item.fkItemUnmedId} - ${item.itemUnMedDescr}",
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

  @override
  Widget build(BuildContext context) {
    return listaItem();
  }
}
