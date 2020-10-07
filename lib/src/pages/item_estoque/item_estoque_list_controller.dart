import 'package:bucks/src/DAO/item_estoque_dao.dart';
import 'package:bucks/src/classes/item_estoque.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'item_estoque_list_controller.g.dart';

class ItemEstoqueListController = _ItemEstoqueListControllerBase
    with _$ItemEstoqueListController;

abstract class _ItemEstoqueListControllerBase with Store {
  ItemEstoqueDAO itemEstoqueDAO;
  bool possuiRelacao;

  @observable
  List<ItemEstoque> itemsEstoque = [];

  @observable
  TextEditingController idItemCons = TextEditingController();
  @observable
  TextEditingController descrItemCons = TextEditingController();

  _ItemEstoqueListControllerBase() {
    itemEstoqueDAO = itemEstoqueDAO ?? ItemEstoqueDAO();
  }

  void init() async {
    await findAll();
  }

  @action
  Future<List<ItemEstoque>> findAll() async {
    var qtdLinhas = await itemEstoqueDAO.count();
    print('qtdLinhas => $qtdLinhas');

    itemsEstoque = [];
    var future = itemEstoqueDAO.listarTodos();
    itemsEstoqueList = ObservableFuture<List<ItemEstoque>>(future);
    return itemsEstoque = await future;
  }

  @action
  Future<List<ItemEstoque>> filtraItemEstoque() async {
    itemsEstoque = [];

    if (idItemCons.text == "") {
      idItemCons.text = "0";
    }

    var future = itemEstoqueDAO.filtrarItensEstoque(
        idItem: int.parse(idItemCons.text), descrItem: descrItemCons.text);
    itemsEstoqueList = ObservableFuture<List<ItemEstoque>>(future);

    if (idItemCons.text == "0") {
      idItemCons.text = "";
    }

    return itemsEstoque = await future;
  }

  @action
  deletarItemEstoque({
    ItemEstoque itemEstoque,
  }) {
    //await itemGrupoDAO.salvar(itemGrupo);
    itemEstoqueDAO.deletarItemEstoque(itemEstoque.fkItemId);
    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaRelacionamentosMovtoEstoque(
      {ItemEstoque itemEstoque,
      ItemEstoqueListController itemEstoqueListController}) async {
    ItemEstoqueDAO itemEstoqueDAO = ItemEstoqueDAO();

    await itemEstoqueDAO.verificaRelacionamentosMovtoEstoque(
        itemEstoque.fkItemId, itemEstoqueListController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  @computed
  bool get hasResults =>
      itemsEstoqueList != emptyResponseItemEstoque &&
      itemsEstoqueList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemEstoque>> emptyResponseItemEstoque =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemEstoque>> itemsEstoqueList =
      emptyResponseItemEstoque;
}
