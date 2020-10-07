import 'package:bucks/src/pages/item_tipo/widgets/card_item_tipo.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../shared/utils/colors.dart';
import '../item_tipo_page.dart';
import 'item_tipo_list_controller.dart';

class ItemTipoListPage extends StatefulWidget {
  final String title;
  const ItemTipoListPage({Key key, this.title = "Consulta Item Tipo"})
      : super(key: key);

  @override
  _ItemTipoListPageState createState() => _ItemTipoListPageState();
}

class _ItemTipoListPageState extends State<ItemTipoListPage> {
  ItemTipoListController store;

  @override
  void initState() {
    super.initState();
    store = ItemTipoListController();
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
                text: 'ITEM TIPO', fontSize: 24, fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            CardItemTipoList(
              store: store,
            ),
          ],
        ),
      ),
      /*body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            CardItemTipoList(store: store),
          ],
        ),
      ),*/
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(
              context,
              ItemTipoPage(
                storeItemTipoList: store,
                itemTipo: null,
              ));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
