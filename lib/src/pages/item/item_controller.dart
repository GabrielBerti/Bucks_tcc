import 'package:bucks/src/DAO/item_dao.dart';
import 'package:bucks/src/DAO/item_estoque_dao.dart';
import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'item_controller.g.dart';

class ItemController = _ItemControllerBase with _$ItemController;

abstract class _ItemControllerBase with Store {
  ItemDAO itemDAO;
  bool possuiRelacaoItemEstoque;
  bool possuiRelacaoMovtoEstoque;
  bool possuiRelacaoProdItem;

  //@observable
  //List<ItemTipo> itensTipo = [];

  @observable
  TextEditingController id = TextEditingController();

  @observable
  TextEditingController descricao = TextEditingController();

  @observable
  TextEditingController qtdMinEstoque = TextEditingController();

  @observable
  TextEditingController cdControlaEstoque = TextEditingController();

  @observable
  TextEditingController fkItemGrupoId = TextEditingController();

  @observable
  TextEditingController fkItemTipoId = TextEditingController();

  @observable
  TextEditingController fkItemUnmedId = TextEditingController();

  _ItemControllerBase() {
    itemDAO = itemDAO ?? ItemDAO();
  }

  Future init() async {}

  @action
  salvarItem(
      {@required ItemController store,
      @required ItemListController storeItemList}) async {
    Item item = Item();

    if (store.id.text != "") {
      item.id = int.parse(store.id.text);
    }

    item.descr = store.descricao.text;
    item.cdControlaEstoque = store.cdControlaEstoque.text.toUpperCase();
    item.fkItemTipoId = storeItemList.itemTipo.id;
    item.fkItemGrupoId = storeItemList.itemGrupo.id;
    item.fkItemUnmedId = storeItemList.itemUnmed.id;

    if (item.cdControlaEstoque == "S") {
      if (store.qtdMinEstoque.text != "") {
        item.qtdMinEstoque = double.parse(store.qtdMinEstoque.text);
      }
    }

    int itemId = await itemDAO.salvar(item);

    if (item.cdControlaEstoque == "S") {
      if (store.qtdMinEstoque.text != "") {
        item.qtdMinEstoque = double.parse(store.qtdMinEstoque.text);
      }

      ItemEstoque itemEstoque = ItemEstoque();
      itemEstoque.fkItemId = itemId;
      itemEstoque.vlUnit = 0;
      //itemEstoque.qtReservado = 0;
      itemEstoque.qtSaldo = 0;

      ItemEstoqueDAO itemEstoqueDAO = ItemEstoqueDAO();

      await itemEstoqueDAO.salvar(itemEstoque);
    }

    await storeItemList.listarItens();
  }

  @action
  deletarItem({
    Item item,
  }) {
    //await itemGrupoDAO.salvar(itemGrupo);
    itemDAO.deletar(item.id);
    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaRelacionamentosItemEstoque(
      {Item item, ItemController itemController}) async {
    ItemDAO itemDAO = ItemDAO();

    await itemDAO.verificaRelacionamentosItemEstoque(item.id, itemController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaRelacionamentosMovtoEstoque(
      {Item item, ItemController itemController}) async {
    ItemDAO itemDAO = ItemDAO();

    await itemDAO.verificaRelacionamentosMovtoEstoque(item.id, itemController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaRelacionamentosProdItem(
      {Item item, ItemController itemController}) async {
    ItemDAO itemDAO = ItemDAO();

    await itemDAO.verificaRelacionamentosProdItem(item.id, itemController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
