import 'package:bucks/src/pages/movto_estoque/movto_estoque_tipo/widgets/card_movto_estoque_tipo.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../movto_estoque_tipo_page.dart';
import 'movto_estoque_tipo_list_controller.dart';

class MovtoEstoqueTipoListPage extends StatefulWidget {
  final String title;
  const MovtoEstoqueTipoListPage(
      {Key key, this.title = "Consulta Tipo Movto Estoque"})
      : super(key: key);

  @override
  _MovtoEstoqueTipoListPageState createState() =>
      _MovtoEstoqueTipoListPageState();
}

class _MovtoEstoqueTipoListPageState extends State<MovtoEstoqueTipoListPage> {
  MovtoEstoqueTipoListController store;

  @override
  void initState() {
    super.initState();
    store = MovtoEstoqueTipoListController();
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
            CardMovtoEstoqueTipoList(store: store),
          ],
        ),
      ),*/

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            CorDeFundo.ContainerDecorationPadrao(
                text: 'TIPO MOVTO. ESTOQUE',
                fontSize: 24,
                fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            CardMovtoEstoqueTipoList(
              store: store,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          push(
              context,
              MovtoEstoqueTipoPage(
                storeMovtoEstoqueTipoList: store,
                movtoEstoqueTipo: null,
              ));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
