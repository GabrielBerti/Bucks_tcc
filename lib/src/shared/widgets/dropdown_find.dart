import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/shared/utils/formatar_id_descr.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class DropdownFindUnidade extends StatefulWidget {
  final dynamic store;

  const DropdownFindUnidade({Key key, @required this.store}) : super(key: key);

  @override
  _DropdownFindUnidadeState createState() => _DropdownFindUnidadeState();
}

class _DropdownFindUnidadeState extends State<DropdownFindUnidade> {
  dynamic get store => widget.store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (!store.hasResultsUnidade) {
          //if (1 == 2) {
          return Container();
        }

        if (store.unidades.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhuma unidade encontrada. \nClique aqui para tentar novamente.',
                fontSize: 18,
                onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }
        Item itemSelect;
        if (store.unidade != null) {
          itemSelect = store.unidade;
        }
        return FindDropdown<Item>(
          selectedItem:
              itemSelect, //store.items.isNotEmpty ? store.items.first : null,
          onFind: (String filter) async {
            return await store.filteredListUnidades(filter);
          },
          onChanged: (Item data) async {
            await store.setUnidade(data);
            print(data.id);
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
                        "Nenhuma unidade selecionada",
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
