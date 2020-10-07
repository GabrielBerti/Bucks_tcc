import 'package:bucks/src/classes/item_unmed.dart';
import 'package:flutter/material.dart';

import 'item_unmed_controller.dart';
import 'item_unmed_list/item_unmed_list_controller.dart';
import 'widgets/card_item_unmed.dart';

class ItemUnmedPage extends StatefulWidget {
  final String title;
  final ItemUnmedListController storeItemUnmedList;
  final ItemUnmed itemUnMed;

  const ItemUnmedPage(
      {Key key,
      this.title = "Cadastro de Unidade de Medida",
      @required this.itemUnMed,
      @required this.storeItemUnmedList})
      : super(key: key);

  @override
  _ItemUnmedPageState createState() => _ItemUnmedPageState();
}

class _ItemUnmedPageState extends State<ItemUnmedPage> {
  ItemUnmedController store;
  ItemUnmedListController get storeItemUnmedList => widget.storeItemUnmedList;
  ItemUnmed get itemUnMed => widget.itemUnMed;

  @override
  void initState() {
    super.initState();
    store = ItemUnmedController();

    if (itemUnMed == null) {
      //storeItemGrupoList.producaoItensDt.clear();
      null;
    } else {
      store.id.text = itemUnMed.id.toString();
      store.descr.text = itemUnMed.descr;
      //storeItemGrupoList.listarProducaoItem(producao);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: <Widget>[
              CardItemUnmed(
                store: store,
                storeItemUnmedList: storeItemUnmedList,
              ),
            ],
          ),
        ));
  }
}
