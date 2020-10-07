import 'package:bucks/src/classes/item_grupo.dart';
import 'package:bucks/src/pages/item_grupo/item_grupo_controller.dart';
import 'package:bucks/src/pages/item_grupo/item_grupo_list/item_grupo_list_controller.dart';
import 'package:bucks/src/pages/item_grupo/widgets/card_item_grupo.dart';
import 'package:flutter/material.dart';

class ItemGrupoPage extends StatefulWidget {
  final String title;
  final ItemGrupoListController storeItemGrupoList;
  final ItemGrupo itemGrupo;

  const ItemGrupoPage(
      {Key key,
      this.title = "Cadastro Item Grupo",
      @required this.itemGrupo,
      @required this.storeItemGrupoList})
      : super(key: key);

  @override
  _ItemGrupoPageState createState() => _ItemGrupoPageState();
}

class _ItemGrupoPageState extends State<ItemGrupoPage> {
  ItemGrupoController store;
  ItemGrupoListController get storeItemGrupoList => widget.storeItemGrupoList;
  ItemGrupo get itemGrupo => widget.itemGrupo;

  @override
  void initState() {
    super.initState();
    store = ItemGrupoController();

    if (itemGrupo == null) {
      //storeItemGrupoList.producaoItensDt.clear();
      null;
    } else {
      store.id.text = itemGrupo.id.toString();
      store.descr.text = itemGrupo.descr;
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
              CardItemGrupo(
                store: store,
                storeItemGrupoList: storeItemGrupoList,
                itemGrupo: null,
              ),
            ],
          ),
        ));
  }
}
