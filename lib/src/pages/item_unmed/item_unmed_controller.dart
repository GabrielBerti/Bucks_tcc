import 'package:bucks/src/DAO/item_dao.dart';
import 'package:bucks/src/DAO/item_unmed_dao.dart';
import 'package:bucks/src/classes/item_unmed.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'item_unmed_list/item_unmed_list_controller.dart';

part 'item_unmed_controller.g.dart';

class ItemUnmedController = _ItemUnmedControllerBase with _$ItemUnmedController;

abstract class _ItemUnmedControllerBase with Store {
  ItemUnmedDAO itemUnmedDAO;
  bool possuiRelacao;

  @observable
  TextEditingController id = TextEditingController();
  TextEditingController descr = TextEditingController();

  _ItemUnmedControllerBase() {
    itemUnmedDAO = itemUnmedDAO ?? ItemUnmedDAO();
  }

  @action
  salvar(
      {@required ItemUnmedController store,
      @required ItemUnmedListController storeItemUnmedList}) async {
    ItemUnmed itemUnmed = ItemUnmed();

    if (store.id.text != "") {
      itemUnmed.id = store.id.text;
    }

    itemUnmed.descr = store.descr.text;

    await itemUnmedDAO.salvar(itemUnmed);

    await storeItemUnmedList.listar();
  }

  @action
  deletarItemUnmed({
    ItemUnmed itemUnmed,
  }) {
    //await itemGrupoDAO.salvar(itemGrupo);
    itemUnmedDAO.deletarIdString(itemUnmed.id);
    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaRelacionamentosItemUnmed(
      {ItemUnmed itemUnmed, ItemUnmedController itemUnmedController}) async {
    ItemDAO itemDAO = ItemDAO();

    await itemDAO.verificaRelacionamentosItemUnmed(
        itemUnmed.id, itemUnmedController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
