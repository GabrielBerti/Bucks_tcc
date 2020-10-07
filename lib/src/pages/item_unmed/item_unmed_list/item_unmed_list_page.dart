import 'package:bucks/src/pages/item_unmed/widgets/card_item_unmed.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../item_unmed_page.dart';
import 'item_unmed_list_controller.dart';

class ItemUnmedListPage extends StatefulWidget {
  final String title;
  const ItemUnmedListPage({Key key, this.title = "Consulta Unidade de Medida"})
      : super(key: key);

  @override
  _ItemUnmedListPageState createState() => _ItemUnmedListPageState();
}

class _ItemUnmedListPageState extends State<ItemUnmedListPage> {
  ItemUnmedListController store;

  @override
  void initState() {
    super.initState();
    store = ItemUnmedListController();
    store.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      /*body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            CardItemUnmedList(store: store),
          ],
        ),
      ),*/

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            CorDeFundo.ContainerDecorationPadrao(
                text: 'ITEM UN. MEDIDA',
                fontSize: 24,
                fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            CardItemUnmedList(
              store: store,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(
              context,
              ItemUnmedPage(
                storeItemUnmedList: store,
                itemUnMed: null,
              ));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
