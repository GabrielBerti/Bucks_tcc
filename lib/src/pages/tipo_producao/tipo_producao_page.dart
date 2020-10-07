import 'package:bucks/src/classes/tipo_producao.dart';
import 'package:bucks/src/pages/tipo_producao/tipo_producao_list/tipo_producao_list_controller.dart';
import 'package:bucks/src/pages/tipo_producao/widgets/card_tipo_producao.dart';
import 'package:flutter/material.dart';
import 'tipo_producao_controller.dart';

class TipoProducaoPage extends StatefulWidget {
  final String title;
  final TipoProducaoListController storeItemTipoProducaoList;
  final TipoProducao tipoProducao;

  const TipoProducaoPage(
      {Key key,
      this.title = "Cadastro Tipo de Produção",
      @required this.tipoProducao,
      @required this.storeItemTipoProducaoList,
      TipoProducao itemTipo,
      TipoProducaoListController storeItemTipoList})
      : super(key: key);

  @override
  _TipoProducaoPageState createState() => _TipoProducaoPageState();
}

class _TipoProducaoPageState extends State<TipoProducaoPage> {
  TipoProducaoController store;
  TipoProducaoListController get storeItemTipoProducaoList =>
      widget.storeItemTipoProducaoList;
  TipoProducao get tipoProducao => widget.tipoProducao;

  @override
  void initState() {
    super.initState();
    store = TipoProducaoController();

    if (tipoProducao == null) {
      //storeItemGrupoList.producaoItensDt.clear();
      null;
    } else {
      store.id.text = tipoProducao.id.toString();
      store.descr.text = tipoProducao.descr;
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
              CardTipoProducao(
                store: store,
                storeItemTipoProducaoList: storeItemTipoProducaoList,
                tipoProducao: tipoProducao,
              ),
            ],
          ),
        ));
  }
}
