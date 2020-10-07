import 'package:bucks/src/pages/item_estoque/item_estoque_list_controller.dart';
import 'package:bucks/src/pages/item_estoque/widgets/card_item_estoque.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:flutter/material.dart';

class ItemEstoqueListPage extends StatefulWidget {
  final String title;
  const ItemEstoqueListPage({Key key, this.title = "Consulta Item Estoque"})
      : super(key: key);

  @override
  _ItemEstoqueListPageState createState() => _ItemEstoqueListPageState();
}

class _ItemEstoqueListPageState extends State<ItemEstoqueListPage> {
  ItemEstoqueListController store;

  @override
  void initState() {
    super.initState();
    store = ItemEstoqueListController();
    store.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      /*body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,

        // scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            CardItemEstoqueList(store: store),
          ],
        ),
      ),*/

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            CardItemEstoqueList(
              store: store,
            ),
          ],
        ),
      ),
    );
  }
}
