import 'package:bucks/src/DAO/item_dao.dart';
import 'package:bucks/src/DAO/item_tipo_dao.dart';
import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/item_tipo.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'item_tipo_list/item_tipo_list_controller.dart';

part 'item_tipo_controller.g.dart';

class ItemTipoController = _ItemTipoControllerBase with _$ItemTipoController;

abstract class _ItemTipoControllerBase with Store {
  ItemTipoDAO itemTipoDAO;
  bool possuiRelacao;

  @observable
  TextEditingController id = TextEditingController();

  @observable
  TextEditingController descr = TextEditingController();

  _ItemTipoControllerBase() {
    itemTipoDAO = itemTipoDAO ?? ItemTipoDAO();
  }

  @action
  salvarItemTipo(
      {@required ItemTipoController store,
      @required ItemTipoListController storeItemTipoList}) async {
    ItemTipo itemTipo = ItemTipo();
    if (store.id.text != "") {
      itemTipo.id = int.parse(store.id.text);
    }

    itemTipo.descr = store.descr.text;
    print('itemTipo.descr: $itemTipo.descr');
    await itemTipoDAO.salvar(itemTipo);

    await storeItemTipoList.listarItensTipo();
  }

  @action
  deletarItemTipo({
    ItemTipo itemTipo,
  }) {
    //await itemGrupoDAO.salvar(itemGrupo);
    itemTipoDAO.deletar(itemTipo.id);
    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaRelacionamentosItemTipo(
      {ItemTipo itemTipo, ItemTipoController itemTipoController}) async {
    ItemDAO itemDAO = ItemDAO();
    await itemDAO.verificaRelacionamentosItemTipo(
        itemTipo.id, itemTipoController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
