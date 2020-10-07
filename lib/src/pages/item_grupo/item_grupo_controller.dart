import 'package:bucks/src/DAO/item_dao.dart';
import 'package:bucks/src/DAO/item_grupo_dao.dart';
import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/item_grupo.dart';
import 'package:bucks/src/pages/item_grupo/item_grupo_list/item_grupo_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'item_grupo_controller.g.dart';

class ItemGrupoController = _ItemGrupoControllerBase with _$ItemGrupoController;

abstract class _ItemGrupoControllerBase with Store {
  ItemGrupoDAO itemGrupoDAO;
  bool possuiRelacao;

  @observable
  TextEditingController id = TextEditingController();

  @observable
  TextEditingController descr = TextEditingController();

  _ItemGrupoControllerBase() {
    itemGrupoDAO = itemGrupoDAO ?? ItemGrupoDAO();
  }

  @action
  salvar(
      {@required ItemGrupoController store,
      @required ItemGrupoListController storeItemGrupoList}) async {
    ItemGrupo itemGrupo = ItemGrupo();
    if (store.id.text != "") {
      itemGrupo.id = int.parse(store.id.text);
    }

    itemGrupo.descr = store.descr.text;

    await itemGrupoDAO.salvar(itemGrupo);
    //await itemGrupoDAO.deletar(1);
    await storeItemGrupoList.listarItensGrupo();
  }

  @action
  deletarItemGrupo({
    ItemGrupo itemGrupo,
  }) {
    //await itemGrupoDAO.salvar(itemGrupo);
    itemGrupoDAO.deletar(itemGrupo.id);
    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaRelacionamentosItemGrupo(
      {ItemGrupo itemGrupo, ItemGrupoController itemGrupoController}) async {
    ItemDAO itemDAO = ItemDAO();

    await itemDAO.verificaRelacionamentosItemGrupo(
        itemGrupo.id, itemGrupoController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
