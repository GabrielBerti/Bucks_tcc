import 'package:bucks/src/pages/tipo_producao/widgets/card_tipo_producao.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../shared/utils/colors.dart';
import '../tipo_producao_page.dart';
import 'tipo_producao_list_controller.dart';

class TipoProducaoListPage extends StatefulWidget {
  final String title;
  const TipoProducaoListPage({Key key, this.title = "Consulta Tipo Producao"})
      : super(key: key);

  @override
  _TipoProducaoListPageState createState() => _TipoProducaoListPageState();
}

class _TipoProducaoListPageState extends State<TipoProducaoListPage> {
  TipoProducaoListController store;

  @override
  void initState() {
    super.initState();
    store = TipoProducaoListController();
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
                text: 'TIPO PRODUÇÃO',
                fontSize: 24,
                fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            CardTipoProducaoList(
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
              TipoProducaoPage(
                storeItemTipoProducaoList: store,
                tipoProducao: null,
              ));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
