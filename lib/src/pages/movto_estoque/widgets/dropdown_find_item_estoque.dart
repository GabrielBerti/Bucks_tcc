import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_controller.dart';
import 'package:bucks/src/shared/utils/formatar_id_descr.dart';
import 'package:bucks/src/shared/widgets/text_message.dart';
import 'package:find_dropdown/find_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../movto_estoque_list_controller.dart';

//-----------------------------------------------------------------------
class DropdownFindItemEstoque extends StatefulWidget {
  final dynamic storeList;
  final dynamic storePage;

  const DropdownFindItemEstoque(
      {Key key, @required this.storeList, @required this.storePage})
      : super(key: key);

  @override
  _DropdownFindItemEstoqueState createState() =>
      _DropdownFindItemEstoqueState();
}

class _DropdownFindItemEstoqueState extends State<DropdownFindItemEstoque> {
  MovtoEstoqueListController get storeList => widget.storeList;
  MovtoEstoqueController get storePage => widget.storePage;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (BuildContext context) {
        if (!storeList.hasResultsItemEstoque) {
          return Container();
        }

        if (storeList.lovItensEstoque.isEmpty) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextMessage(
                'Nenhum item encontrado. \nClique aqui para tentar novamente.',
                fontSize: 18,
                // onRefresh: store.fetchUnidade,
              ),
            ],
          );
        }

        ItemEstoque itemSelect;
        if (storeList.lovItemEstoqueSelected != null) {
          itemSelect = storeList.lovItemEstoqueSelected;
        }

        return FindDropdown<ItemEstoque>(
          selectedItem: itemSelect,
          onFind: (String filter) async {
            return await storeList.filteredListItensEstoque(filter);
          },
          onChanged: (ItemEstoque data) async {
            await storeList.setItemEstoque(data);
            print(data.fkItemId);
          },
          dropdownBuilder: (BuildContext context, ItemEstoque itemEstoque) {
            return Container(
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
              ),
              child: (itemEstoque == null)
                  ? ListTile(
                      title: Text(
                        "Nenhum item estoque selecionado",
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : ListTile(
                      title: Text(
                        formatarIdDescr(itemEstoque.fkItemId.toString(),
                                itemEstoque.fkItemDescr) +
                            formatarItemEstoqueQt(
                                itemEstoque.qtSaldo,
                                //itemEstoque.qtReservado,
                                itemEstoque.fkItemUnmedId),
                        style: TextStyle(fontSize: 24),
                      ),
                      // subtitle: Text(item.empresaDescr),
                    ),
            );
          },
          dropdownItemBuilder:
              (BuildContext context, ItemEstoque itemEstoque, bool isSelected) {
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
                      formatarIdDescr(itemEstoque.fkItemId.toString(),
                              itemEstoque.fkItemDescr) +
                          formatarItemEstoqueQt(
                              itemEstoque.qtSaldo,
                              //itemEstoque.qtReservado,
                              itemEstoque.fkItemUnmedId),
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
