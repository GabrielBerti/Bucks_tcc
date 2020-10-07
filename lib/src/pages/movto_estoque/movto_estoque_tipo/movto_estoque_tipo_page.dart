import 'package:bucks/src/classes/movto_estoque_tipo.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_tipo/widgets/card_movto_estoque_tipo.dart';
import 'package:flutter/material.dart';
import 'movto_estoque_tipo_controller.dart';
import 'movto_estoque_tipo_list/movto_estoque_tipo_list_controller.dart';

class MovtoEstoqueTipoPage extends StatefulWidget {
  final String title;
  final MovtoEstoqueTipoListController storeMovtoEstoqueTipoList;
  final MovtoEstoqueTipo movtoEstoqueTipo;

  const MovtoEstoqueTipoPage(
      {Key key,
      this.title = "Cadastro de Unidade de Medida",
      @required this.movtoEstoqueTipo,
      @required this.storeMovtoEstoqueTipoList})
      : super(key: key);

  @override
  _MovtoEstoqueTipoPageState createState() => _MovtoEstoqueTipoPageState();
}

class _MovtoEstoqueTipoPageState extends State<MovtoEstoqueTipoPage> {
  MovtoEstoqueTipoController store;
  MovtoEstoqueTipoListController get storeMovtoEstoqueTipoList =>
      widget.storeMovtoEstoqueTipoList;
  MovtoEstoqueTipo get movtoEstoqueTipo => widget.movtoEstoqueTipo;

  @override
  void initState() {
    super.initState();
    store = MovtoEstoqueTipoController();

    if (movtoEstoqueTipo == null) {
      //storeItemGrupoList.producaoItensDt.clear();
      null;
    } else {
      store.tecId.text = movtoEstoqueTipo.id.toString();
      store.tecDescr.text = movtoEstoqueTipo.descr;
      store.tecCdTipoMovto.text = movtoEstoqueTipo.cdTipoMovto;
      //storeItemGrupoList.listarProducaoItem(producao);
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
              CardMovtoEstoqueTipo(
                store: store,
                storeMovtoEstoqueTipoList: storeMovtoEstoqueTipoList,
              ),
            ],
          ),
        ));
  }
}
