import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:bucks/src/pages/item/item_page.dart';
import 'package:bucks/src/pages/item/widgets/card_item.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ItemListPage extends StatefulWidget {
  final String title;
  const ItemListPage({Key key, this.title = "Consulta Item"}) : super(key: key);

  @override
  _ItemListPageState createState() => _ItemListPageState();
}

class _ItemListPageState extends State<ItemListPage> {
  ItemListController store;
  //ItemTipo itemTipo;

  @override
  void initState() {
    super.initState();
    store = ItemListController();
    store.init();
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
            SizedBox(height: 15),
            CorDeFundo.ContainerDecorationPadrao(
                text: 'ITEM', fontSize: 24, fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            CardItemList(
              store: store,
              itemTipo: store.itemTipo,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          store.itemTipo = null;
          store.itemGrupo = null;
          store.itemUnmed = null;
          push(
              context,
              ItemPage(
                storeItemList: store,
                item: null,
                isAlteracao: false,
              ));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
