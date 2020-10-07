import 'package:bucks/src/classes/movto_estoque_tipo.dart';
import 'package:bucks/src/shared/utils/formatar_id_descr.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../movto_estoque_list_controller.dart';

///////////////// MovtoTipo
//-----------------------------------------------------------------------
class DropdownFindMovtoTipo extends StatefulWidget {
  final dynamic store;

  const DropdownFindMovtoTipo({Key key, @required this.store})
      : super(key: key);

  @override
  _DropdownFindMovtoTipoState createState() => _DropdownFindMovtoTipoState();
}

class _DropdownFindMovtoTipoState extends State<DropdownFindMovtoTipo> {
  MovtoEstoqueListController get store => widget.store;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (!store.hasResults) {
          //if (1 == 2) {
          return Container();
        }

        if (store.lovMovtoTipo.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhum Tipo de Movto encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }

        MovtoEstoqueTipo itemSelect;
        if (store.lovMovtoEstoqueTipoSelected != null) {
          itemSelect = store.lovMovtoEstoqueTipoSelected;
        }

        return FindDropdown<MovtoEstoqueTipo>(
          selectedItem: itemSelect,
          // onFind
          onFind: (String filter) async {
            return await store.filteredListMovtoEstoqueTipo(filter);
          },
          onChanged: (MovtoEstoqueTipo data) async {
            await store.setMovtoEstoqueTipo(data);
            await store.fetchItem();
            await store.fetchItemEstoque();
          },
          dropdownBuilder: (BuildContext context, MovtoEstoqueTipo item) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: (item == null)
                  ? ListTile(
                      title: Text(
                        "Nenhum item selecionado",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListTile(
                      title: Text(
                        "${item.id} - ${item.descr}  (${item.cdTipoMovto})",
                        style: TextStyle(fontSize: 24),
                      ),
                      // subtitle: Text(item.empresaDescr),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, MovtoEstoqueTipo item, bool isSelected) {
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
                      "${item.id} - ${item.descr}  (${item.cdTipoMovto})",
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

        // return Container(
        //   child: Text('testando1'),
        // );
      },
    );
  }
}
