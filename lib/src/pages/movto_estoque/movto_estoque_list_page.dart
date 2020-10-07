import 'package:bucks/src/pages/movto_estoque/movto_estoque_page.dart';
import 'package:bucks/src/pages/movto_estoque/widgets/card_movto_estoque.dart';
import 'package:bucks/src/shared/utils/colors.dart';
import 'package:bucks/src/shared/widgets/snackbar_custom.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../shared/utils/nav.dart';
import 'movto_estoque_list_controller.dart';

class MovtoEstoqueListPage extends StatefulWidget {
  final String title;
  const MovtoEstoqueListPage({Key key, this.title = "Consulta Movto Estoque"})
      : super(key: key);

  @override
  _MovtoEstoqueListPageState createState() => _MovtoEstoqueListPageState();
}

class _MovtoEstoqueListPageState extends State<MovtoEstoqueListPage> {
  MovtoEstoqueListController storeList;

  @override
  void initState() {
    super.initState();
    storeList = MovtoEstoqueListController();
    storeList.init();
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
            CardMovtoEstoqueList(store: storeList),
          ],
        ),
      ),*/

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            SizedBox(height: 15),
            CorDeFundo.ContainerDecorationPadrao(
                text: 'MOVTOS. ESTOQUE',
                fontSize: 24,
                fontWeight: FontWeight.bold),
            SizedBox(height: 10),
            CardMovtoEstoqueList(
              store: storeList,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          /*Future<DateTime> seiqla = showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2018),
              lastDate: DateTime(2040),
              builder: (BuildContext context, Widget child) {
                return Theme(data: ThemeData.dark(), child: child);
              });

          print(seiqla);

          storeList.lovItemEstoqueSelected = null;
          storeList.lovMovtoEstoqueTipoSelected = null;*/
          push(
              context,
              MovtoEstoquePage(
                storeMovtoEstoqueList: storeList,
              ));
        },
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}
