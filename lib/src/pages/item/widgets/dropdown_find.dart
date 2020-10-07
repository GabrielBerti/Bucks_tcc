import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/item_grupo.dart';
import 'package:bucks/src/classes/item_tipo.dart';
import 'package:bucks/src/classes/item_unmed.dart';
import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:bucks/src/shared/utils/formatar_id_descr.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DropdownFindItemTipo extends StatefulWidget {
  final dynamic store;
  final Item item;

  const DropdownFindItemTipo(
      {Key key, @required this.store, @required this.item})
      : super(key: key);

  @override
  _DropdownFindItemTipoState createState() => _DropdownFindItemTipoState();
}

class _DropdownFindItemTipoState extends State<DropdownFindItemTipo> {
  ItemListController get store => widget.store;
  Item get item => widget.item;

  @override
  Widget build(BuildContext context) {
    /*if (store.isAlteracao == true && store.itemTipo == null) {
      while (store.itemTipo == null) {
        store.fetchItemTipoAlteracao(item.id);
      }
    }*/

    return Observer(
      builder: (BuildContext context) {
        if (!store.hasResultsItemTipo && store.isAlteracao == false) {
          return Container();
        }

        if (store.itensTipo.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhum item tipo encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }
        ItemTipo itemSelect;

        if (store.itemTipo != null) {
          itemSelect = store.itemTipo;
        }
        return FindDropdown<ItemTipo>(
          selectedItem:
              itemSelect, //store.items.isNotEmpty ? store.items.first : null,
          onFind: (String filter) async {
            return await store.filteredListItensTipos(filter);
          },
          onChanged: (ItemTipo data) async {
            await store.setItemTipo(data);
            print(data.descr);
          },
          dropdownBuilder: (BuildContext context, ItemTipo item) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: (item == null)
                  ? ListTile(
                      title: Text(
                        "Nenhum item tipo selecionado",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListTile(
                      title: Text(
                        formatarIdDescr(item.id.toString(), item.descr),
                        style: TextStyle(fontSize: 24),
                      ),
                      // subtitle: Text(item.empresaDescr),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, ItemTipo item, bool isSelected) {
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
                      formatarIdDescr(item.id.toString(), item.descr),
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
class DropdownFindItemGrupo extends StatefulWidget {
  final dynamic store;

  const DropdownFindItemGrupo({Key key, @required this.store})
      : super(key: key);

  @override
  _DropdownFindItemGrupoState createState() => _DropdownFindItemGrupoState();
}

class _DropdownFindItemGrupoState extends State<DropdownFindItemGrupo> {
  ItemListController get store => widget.store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (!store.hasResultsItemGrupo) {
          //if (1 == 2) {
          return Container();
        }

        if (store.itensGrupo.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhum item grupo encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }
        ItemGrupo itemSelect;
        if (store.itemGrupo != null) {
          itemSelect = store.itemGrupo;
        }
        return FindDropdown<ItemGrupo>(
          selectedItem:
              itemSelect, //store.items.isNotEmpty ? store.items.first : null,
          onFind: (String filter) async {
            return await store.filteredListItensGrupos(filter);
          },
          onChanged: (ItemGrupo data) async {
            await store.setItemGrupo(data);
            print(data.descr);
          },
          dropdownBuilder: (BuildContext context, ItemGrupo item) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: (item == null)
                  ? ListTile(
                      title: Text(
                        "Nenhum item tipo selecionado",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListTile(
                      title: Text(
                        formatarIdDescr(item.id.toString(), item.descr),
                        style: TextStyle(fontSize: 24),
                      ),
                      // subtitle: Text(item.empresaDescr),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, ItemGrupo item, bool isSelected) {
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
                      formatarIdDescr(item.id.toString(), item.descr),
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
class DropdownFindItemUnMed extends StatefulWidget {
  final dynamic store;

  const DropdownFindItemUnMed({Key key, @required this.store})
      : super(key: key);

  @override
  _DropdownFindItemUnMedState createState() => _DropdownFindItemUnMedState();
}

class _DropdownFindItemUnMedState extends State<DropdownFindItemUnMed> {
  ItemListController get store => widget.store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (!store.hasResultsItemUnMed) {
          //if (1 == 2) {
          return Container();
        }

        if (store.itensUnMed.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhuma unid. medida encontrada. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }
        ItemUnmed itemSelect;
        if (store.itemGrupo != null) {
          itemSelect = store.itemUnmed;
        }
        return FindDropdown<ItemUnmed>(
          selectedItem:
              itemSelect, //store.items.isNotEmpty ? store.items.first : null,
          onFind: (String filter) async {
            return await store.filteredListItensUnMed(filter);
          },
          onChanged: (ItemUnmed data) async {
            await store.setItemUnMed(data);
            print(data.descr);
          },
          dropdownBuilder: (BuildContext context, ItemUnmed item) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: (item == null)
                  ? ListTile(
                      title: Text(
                        "Nenhuma unid. medida selecionada",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListTile(
                      title: Text(
                        formatarIdDescr(item.id.toString(), item.descr),
                        style: TextStyle(fontSize: 24),
                      ),
                      // subtitle: Text(item.empresaDescr),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, ItemUnmed item, bool isSelected) {
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
                      formatarIdDescr(item.id.toString(), item.descr),
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
