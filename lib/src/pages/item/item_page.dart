import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/pages/item/item_controller.dart';
import 'package:bucks/src/pages/item/widgets/card_item.dart';
import 'package:bucks/src/shared/utils/formatar_id_descr.dart';
import 'package:flutter/material.dart';

import 'item_list/item_list_controller.dart';

class ItemPage extends StatefulWidget {
  final String title;
  final ItemListController storeItemList;
  final Item item;
  bool isAlteracao;

  ItemPage(
      {Key key,
      this.title = "Cadastro Item",
      @required this.storeItemList,
      @required this.item,
      @required this.isAlteracao})
      : super(key: key);

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  ItemController store;
  ItemListController get storeItemList => widget.storeItemList;
  Item get item => widget.item;
  //bool isAlteracao get isAlteracao => widget.isAlteracao;

  @override
  void initState() {
    super.initState();
    store = ItemController();

    if (item == null) {
      //storeItemGrupoList.producaoItensDt.clear();
      null;
    } else {
      store.id.text = item.id.toString();
      store.descricao.text = item.descr;

      if (item.qtdMinEstoque != null) {
        store.qtdMinEstoque.text = item.qtdMinEstoque.toString();
      }

      store.cdControlaEstoque.text = item.cdControlaEstoque.toString();

      storeItemList.isAlteracao = true;
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
              CardItem(
                store: store,
                storeItemList: storeItemList,
                item: item,
              ),
            ],
          ),
        ));
  }
}
