import 'dart:io';

import 'package:bucks/src/pages/item/item_list/item_list_page.dart';
import 'package:bucks/src/pages/item_estoque/item_estoque_list_page.dart';
import 'package:bucks/src/pages/item_grupo/item_grupo_list/item_grupo_list_page.dart';
import 'package:bucks/src/pages/item_tipo/item_tipo_list/item_tipo_list_page.dart';
import 'package:bucks/src/pages/item_unmed/item_unmed_list/item_unmed_list_page.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_list_page.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_tipo/movto_estoque_tipo_list/movto_estoque_tipo_list_page.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_page.dart';
import 'package:bucks/src/pages/tipo_producao/tipo_producao_list/tipo_producao_list_page.dart';
import 'package:bucks/src/shared/utils/nav.dart';
import 'package:bucks/src/shared/widgets/dashboard_drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardMateriaisPage extends StatefulWidget {
  final String title;
  DashboardMateriaisPage({Key key, this.title = "DashBoard Bucks"})
      : super(key: key);

  @override
  _DashboardMateriaisPageState createState() => _DashboardMateriaisPageState();
}

class _DashboardMateriaisPageState extends State<DashboardMateriaisPage> {
  bool screen;
  Orientation orientation;

  @override
  Widget build(BuildContext context) {
    final double shortsSide = MediaQuery.of(context).size.shortestSide;
    screen = shortsSide < 600;
    orientation = MediaQuery.of(context).orientation;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Menu",
          style: TextStyle(fontSize: screen ? 22 : 28),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.explicit,
              size: screen ? 24 : 32,
            ),
            onPressed: () => _exec_procedure(),
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              size: screen ? 24 : 32,
            ),
            onPressed: () => exit(0),
          ),
        ],
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // BgImage(),
          Container(
            child: Container(
              padding: EdgeInsets.all(5),
              // padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
              child: _listView(context),
            ),
          ),
        ],
      ),
      drawer: DashboardDrawerWidget(),
    );
  }

  void _exec_procedure() {
    print('<<< _exec_procedure executar >>>');
    //UserDb userDb = UserDb();
    //userDb.deletarTabelasManualmente();

    /*MovtoEstoque movtoEstoque = MovtoEstoque();
    movtoEstoque.fkItemEstoqueItemId = storeMovtoEstoqueList.lovItemSelected.id;
    movtoEstoque.fkMovtoEstoqueTipoId =
        storeMovtoEstoqueList.lovMovtoEstoqueTipoSelected.id;
    movtoEstoque.dt = store.dt.text;
    movtoEstoque.qtd = double.parse(store.qtd.text);
    movtoEstoque.vlUnit = double.parse(store.vlUnit.text);

    await movtoEstoqueDAO.salvar(movtoEstoque);*/

    print('<<< _exec_procedure executada com sucesso >>>');
  }

  _listView(context) {
    List<String> applications = [];

    applications.addAll([
      "Produção",
      "Tipo Produção",
      "Item",
      "Item Grupo",
      "Item Tipo",
      "Un. Medida",
      //"CgRefCodes",
      "Movto Estoque Tipo",
      //"Tarefas",
      //"Gifs",
      "Mov. Estoque",
      "Item Estoque",
      //"Receita",
      //"teste drodown",
    ]);

    List<IconData> icons = [];

    icons.addAll([
      FontAwesomeIcons.wineBottle,
      FontAwesomeIcons.receipt,
      FontAwesomeIcons.prescriptionBottle,
      FontAwesomeIcons.tools,
      FontAwesomeIcons.productHunt,
      FontAwesomeIcons.clipboardList,
      // FontAwesomeIcons.wineBottle,
      FontAwesomeIcons.addressCard,
      //FontAwesomeIcons.tasks,
      //FontAwesomeIcons.gift,
      FontAwesomeIcons.cartArrowDown,
      FontAwesomeIcons.shopware,
      //FontAwesomeIcons.receipt,
      //FontAwesomeIcons.tools,
      //  FontAwesomeIcons.cookieBite,
    ]);

    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount:
                screen ? 2 : orientation == Orientation.portrait ? 4 : 6),
        itemCount: applications.length,
        itemBuilder: (context, idx) {
          return _listItem(applicatiions: applications, idx: idx, icons: icons);
        });
    // }
  }

  Widget _listItem(
      {List<String> applicatiions,
      int idx,
      List<IconData> icons,
      List<String> images}) {
    final backgroundColor1 = Colors.orange;
    final backgroundColor2 = Colors.orangeAccent;
    return Stack(
      children: <Widget>[
        SizedBox.expand(
          child: InkWell(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              // color: Colors.orangeAccent,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  gradient: LinearGradient(
                    colors: [backgroundColor1, backgroundColor2],
                    begin: FractionalOffset.topCenter,
                    end: FractionalOffset.bottomCenter,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 10),
                    Expanded(
                        flex: 4,
                        child: Icon(
                          icons[idx],
                          color: Colors.white,
                          size: 100,
                        )
                        // Image.asset(images[idx])
                        ),
                    SizedBox(
                      height: 5,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                            color: Colors.grey.withOpacity(0.5)),
                        child: Center(
                          child: Text(
                            applicatiions[idx],
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            onTap: () async {
              Widget page;

              switch (idx) {
                case 0:
                  page = ProducaoListPage();
                  break;
                case 1:
                  page = TipoProducaoListPage();
                  break;
                case 2:
                  page = ItemListPage();
                  break;
                case 3:
                  page = ItemGrupoListPage();
                  break;
                case 4:
                  page = ItemTipoListPage();
                  break;
                case 5:
                  page = ItemUnmedListPage();
                  break;
                case 6:
                  page = MovtoEstoqueTipoListPage();
                  break;
                case 7:
                  page = MovtoEstoqueListPage();
                  break;
                case 8:
                  page = ItemEstoqueListPage();
                  break;
                /*case 8:
                  page = GifsHomePage();
                  break;
                case 9:
                  page = MovtoEstoqueListPage();
                  break;
                case 10:
                  page = ItemEstoqueListPage();
                  break;
                case 11:
                  page = ReceitaPage();
                  break;
                case 12:
                  page = HelloDropDown2();
                  break;*/
                default:
              }

              push(context, page);
            },
          ),
        ),
      ],
    );
  }
}
