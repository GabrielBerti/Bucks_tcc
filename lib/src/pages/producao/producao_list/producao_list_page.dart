import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/pages/producao/widgets/card_producao.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../producao_page.dart';
import 'producao_list_controller.dart';

class ProducaoListPage extends StatefulWidget {
  final String title;
  final Producao producao;
  const ProducaoListPage(
      {Key key, this.title = "Consulta de Produção", this.producao})
      : super(key: key);

  @override
  _ProducaoListPageState createState() => _ProducaoListPageState();
}

class _ProducaoListPageState extends State<ProducaoListPage> {
  ProducaoListController store;
  Producao get producao => widget.producao;

  @override
  void initState() {
    super.initState();
    store = ProducaoListController();
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
        child: Column(
          children: <Widget>[
            CardProducaoList(
              store: store,
            ),
          ], 
        ),
      ),*/

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            CorDeFundo.ContainerDecorationPadrao(
                text: 'PRODUÇÃO', fontSize: 24, fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            CardProducaoList(store: store, producao: producao),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          store.tipoProducao = null;
          push(
              context,
              ProducaoPage(
                storeProducaoList: store,
                producao: producao,
              ));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
