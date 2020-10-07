import 'package:bucks/src/DAO/tipo_producao_dao.dart';
import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/classes/tipo_producao.dart';
import 'package:bucks/src/pages/producao/producao_controller.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/shared/utils/formatar_id_descr.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DropdownFindItemEstoqueEntrada extends StatefulWidget {
  final ProducaoListController store;
  final ProducaoController store2;
  final Producao producao;

  const DropdownFindItemEstoqueEntrada(
      {Key key, @required this.store, @required this.store2, this.producao})
      : super(key: key);

  @override
  _DropdownFindItemEstoqueEntradaState createState() =>
      _DropdownFindItemEstoqueEntradaState();
}

class _DropdownFindItemEstoqueEntradaState
    extends State<DropdownFindItemEstoqueEntrada> {
  ProducaoListController get store => widget.store;
  ProducaoController get store2 => widget.store2;
  Producao get producao => widget.producao;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (!store.hasResultsItemEstoqueEntrada) {
          //if (1 == 2) {
          return Container();
        }

        if (store.itemsEstoqueEntrada.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhuma Item Estoque encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }

        ItemEstoque itemSelect;
        if (store.itemEstoqueEntrada != null) {
          itemSelect = store.itemEstoqueEntrada;
        }
        return FindDropdown<ItemEstoque>(
          selectedItem:
              itemSelect, //store.items.isNotEmpty ? store.items.first : null,
          onFind: (String filter) async {
            return await store.filteredListItemEstoqueEntrada(filter);
          },
          onChanged: (ItemEstoque data) async {
            await store.setLixo();
            bool jaPossuiItem = store.validaDataTableEntradaPossuiItem(data);

            if (store.tipoProducaoItem == null) {
              snackbarInfoWithoutDuration(
                  context: context,
                  msg: "Primeiro selecione um tipo de movimento('E' ou 'S')");

              return;
            } else if (store.tipoProducaoItem == 'S') {
              snackbarInfoWithoutDuration(
                  context: context,
                  msg: "Para escolher um item de entrada selecione o tipo 'E'");

              return;
            } else if (jaPossuiItem) {
              snackbarInfoWithoutDuration(
                  context: context,
                  msg: "O item escolhido já está inserido na tabela !");

              return;
            } else {
              await store.setProducaoItemEstoqueEntrada(data, producao);
              //data, store2.id.text.toString());
            }

            print(data.fkItemDescr);
          },
          dropdownBuilder: (BuildContext context, ItemEstoque item) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: (item == null)
                  ? ListTile(
                      title: Text(
                        "Escolha o item para entrada na produção",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListTile(
                      title: Text(
                        //'${item.fkItemId.toString()} - ${item.fkItemDescr}',
                        formatarIdDescr(
                                item.fkItemId.toString(), item.fkItemDescr) +
                            formatarItemEstoqueQt(
                                item.qtSaldo, item.fkItemUnmedId),
                        style: TextStyle(fontSize: 24),
                      ),
                      // subtitle: Text(item.empresaDescr),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, ItemEstoque item, bool isSelected) {
            return Container(
              decoration: !isSelected
                  ? null
                  : BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    selected: isSelected,
                    title: Text(
                      formatarIdDescr(
                              item.fkItemId.toString(), item.fkItemDescr) +
                          formatarItemEstoqueQt(
                              item.qtSaldo, item.fkItemUnmedId),
                      style: TextStyle(fontSize: 24),
                    ),
                    // subtitle: Text(item.empresaDescr),
                  ),
                  Divider()
                ],
              ),
            );
          },
        );
      },
    );
  }

  String formatarItemEstoqueQt(double pQtSaldo, String pUnmed) {
    String result = "";
    if (pQtSaldo != null) {
      result = ' Qt:' + pQtSaldo.toString();
    }
    /*if (pQtReservado != null) {
      result = result + '/ QT. RESERVADO:' + pQtReservado.toString();
    }*/
    if (pUnmed != null) {
      result = result + '/ UN. MED.:' + pUnmed;
    }
    return result;
  }
}

//-----------------------------------------------------------------------
class DropdownFindItemSaida extends StatefulWidget {
  final ProducaoListController store;
  final ProducaoController store2;
  final Producao producao;

  const DropdownFindItemSaida(
      {Key key, @required this.store, @required this.store2, this.producao})
      : super(key: key);

  @override
  _DropdownFindItemSaidaState createState() => _DropdownFindItemSaidaState();
}

class _DropdownFindItemSaidaState extends State<DropdownFindItemSaida> {
  ProducaoListController get store => widget.store;
  ProducaoController get store2 => widget.store2;
  Producao get producao => widget.producao;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (!store.hasResultsItemSaida) {
          //if (1 == 2) {
          return Container();
        }

        if (store.itemsSaida.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhuma Item encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }

        ItemEstoque itemSelect;
        if (store.itemSaida != null) {
          itemSelect = store.itemSaida;
        }
        return FindDropdown<ItemEstoque>(
          selectedItem:
              itemSelect, //store.items.isNotEmpty ? store.items.first : null,
          onFind: (String filter) async {
            return await store.filteredListItemSaida(filter);
          },
          onChanged: (ItemEstoque data) async {
            await store.setLixo();
            bool jaPossuiItem = store.validaDataTableItemSaidaPossuiItem(data);

            if (store.tipoProducaoItem == null) {
              snackbarInfoWithoutDuration(
                  context: context,
                  msg: "Primeiro selecione um tipo de movimento('E' ou 'S')");

              return;
            } else if (store.tipoProducaoItem == 'E') {
              snackbarInfoWithoutDuration(
                  context: context,
                  msg: "Para escolher um item de saída selecione o tipo 'S'");

              return;
            } else if (jaPossuiItem) {
              snackbarInfoWithoutDuration(
                  context: context,
                  msg: "O item escolhido já está inserido na tabela !");

              return;
            } else {
              await store.setProducaoItemSaida(data, producao);
            }

            print(data.fkItemDescr);
          },
          dropdownBuilder: (BuildContext context, ItemEstoque item) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: (item == null)
                  ? ListTile(
                      title: Text(
                        "Escolha o item para saida da produção",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListTile(
                      title: Text(
                        //'${item.id.toString()} - ${item.descr}',
                        formatarIdDescr(
                                item.fkItemId.toString(), item.fkItemDescr) +
                            formatarItemEstoqueQt(
                                item.qtSaldo, item.fkItemUnmedId),
                        style: TextStyle(fontSize: 24),
                      ),
                      // subtitle: Text(item.empresaDescr),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, ItemEstoque item, bool isSelected) {
            return Container(
              decoration: !isSelected
                  ? null
                  : BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    selected: isSelected,
                    title: Text(
                      //'${item.id.toString()} - ${item.descr}',
                      formatarIdDescr(
                              item.fkItemId.toString(), item.fkItemDescr) +
                          formatarItemEstoqueQt(
                              item.qtSaldo, item.fkItemUnmedId),
                      style: TextStyle(fontSize: 24),
                    ),
                    // subtitle: Text(item.empresaDescr),
                  ),
                  Divider()
                ],
              ),
            );
          },
        );
      },
    );
  }

  String formatarItemEstoqueQt(double pQtSaldo, String pUnmed) {
    String result = "";
    if (pQtSaldo != null) {
      result = ' Qt:' + pQtSaldo.toString();
    }
    /*if (pQtReservado != null) {
      result = result + '/ QT. RESERVADO:' + pQtReservado.toString();
    }*/
    if (pUnmed != null) {
      result = result + '/ UN. MED.:' + pUnmed;
    }
    return result;
  }
}

//-----------------------------------------------------------------------
class DropdownFindItemIndireto extends StatefulWidget {
  final ProducaoListController store;
  final ProducaoController store2;
  final Producao producao;

  const DropdownFindItemIndireto(
      {Key key, @required this.store, @required this.store2, this.producao})
      : super(key: key);

  @override
  _DropdownFindItemIndiretoState createState() =>
      _DropdownFindItemIndiretoState();
}

class _DropdownFindItemIndiretoState extends State<DropdownFindItemIndireto> {
  ProducaoListController get store => widget.store;
  ProducaoController get store2 => widget.store2;
  Producao get producao => widget.producao;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (!store.hasResultsItemIndireto) {
          //if (1 == 2) {
          return Container();
        }

        if (store.itemsIndiretos.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhuma Item encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }

        Item itemSelect;
        if (store.itemIndireto != null) {
          itemSelect = store.itemIndireto;
        }
        return FindDropdown<Item>(
          selectedItem:
              itemSelect, //store.items.isNotEmpty ? store.items.first : null,
          onFind: (String filter) async {
            return await store.filteredListItemIndireto(filter);
          },
          onChanged: (Item data) async {
            await store.setLixo();
            bool jaPossuiItem =
                store.validaDataTableItemIndiretoPossuiItem(data);

            if (store.tipoProducaoItem == null) {
              snackbarInfoWithoutDuration(
                  context: context,
                  msg: "Primeiro selecione um tipo de movimento('E' ou 'S')");

              return;
            } else if (store.tipoProducaoItem == 'S') {
              snackbarInfoWithoutDuration(
                  context: context,
                  msg: "Para escolher um item de entrada selecione o tipo 'E'");

              return;
            } else if (jaPossuiItem) {
              snackbarInfoWithoutDuration(
                  context: context,
                  msg: "O item escolhido já está inserido na tabela !");

              return;
            } else {
              await store.setProducaoItemIndireto(data, producao);
            }

            print(data.descr);
          },
          dropdownBuilder: (BuildContext context, Item item) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: (item == null)
                  ? ListTile(
                      title: Text(
                        "Escolha o item indireto para entrada da produção",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListTile(
                      title: Text(
                        '${item.id.toString()} - ${item.descr}',
                        // '${item.fkItemId.toString()} - ${item.descrItem}',
                        style: TextStyle(fontSize: 24),
                      ),
                      // subtitle: Text(item.empresaDescr),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, Item item, bool isSelected) {
            return Container(
              decoration: !isSelected
                  ? null
                  : BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    selected: isSelected,
                    title: Text(
                      '${item.id.toString()} - ${item.descr}',
                      style: TextStyle(fontSize: 24),
                    ),
                    // subtitle: Text(item.empresaDescr),
                  ),
                  Divider()
                ],
              ),
            );
          },
        );
      },
    );
  }
}
//-----------------------------------------------------------------------

class DropdownFindTipoProducao extends StatefulWidget {
  final ProducaoListController store;
  final ProducaoController store2;
  final Producao producao;

  const DropdownFindTipoProducao(
      {Key key, @required this.store, @required this.store2, this.producao})
      : super(key: key);

  @override
  _DropdownFindTipoProducaoState createState() =>
      _DropdownFindTipoProducaoState();
}

class _DropdownFindTipoProducaoState extends State<DropdownFindTipoProducao> {
  ProducaoListController get store => widget.store;
  ProducaoController get store2 => widget.store2;
  Producao get producao => widget.producao;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (!store.hasResultsTipoProducao && store.isAlteracao == false) {
          //if (1 == 2) {
          return Container();
        }

        if (store.tiposProducao.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhuma Tipo de Produção encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }

        TipoProducao itemSelect;
        if (store.tipoProducao != null) {
          itemSelect = store.tipoProducao;
        }
        return FindDropdown<TipoProducao>(
          selectedItem:
              itemSelect, //store.items.isNotEmpty ? store.items.first : null,
          onFind: (String filter) async {
            return await store.filteredListTipoProducao(filter);
          },
          onChanged: (TipoProducao data) async {
            await store.setTipoProducao(data);
            print(data.descr);
          },
          dropdownBuilder: (BuildContext context, TipoProducao item) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: (item == null)
                  ? ListTile(
                      title: Text(
                        "Escolha o tipo de produção",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListTile(
                      title: Text(
                        '${item.id.toString()} - ${item.descr}',
                        // '${item.fkItemId.toString()} - ${item.descrItem}',
                        style: TextStyle(fontSize: 24),
                      ),
                      // subtitle: Text(item.empresaDescr),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, TipoProducao item, bool isSelected) {
            return Container(
              decoration: !isSelected
                  ? null
                  : BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                    ),
              child: Column(
                children: <Widget>[
                  ListTile(
                    selected: isSelected,
                    title: Text(
                      '${item.id.toString()} - ${item.descr}',
                      style: TextStyle(fontSize: 24),
                    ),
                    // subtitle: Text(item.empresaDescr),
                  ),
                  Divider()
                ],
              ),
            );
          },
        );
      },
    );
  }
}
