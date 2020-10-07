import 'package:bucks/src/DAO/item_dao.dart';
import 'package:bucks/src/DAO/item_estoque_dao.dart';
import 'package:bucks/src/DAO/movto_estoque_dao.dart';
import 'package:bucks/src/DAO/movto_estoque_tipo_dao.dart';
import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/classes/movto_estoque.dart';
import 'package:bucks/src/classes/movto_estoque_tipo.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

part 'movto_estoque_list_controller.g.dart';

class MovtoEstoqueListController = _MovtoEstoqueListControllerBase
    with _$MovtoEstoqueListController;

abstract class _MovtoEstoqueListControllerBase with Store {
  MovtoEstoqueDAO movtoEstoqueDAO;

  //listas = LOV
  ItemDAO itemDAO;
  ItemEstoqueDAO itemEstoqueDAO;
  MovtoEstoqueTipoDAO movtoEstoqueTipoDAO;

  @observable
  List<MovtoEstoque> movtosEstoque = [];

  @observable
  ItemEstoque lovItemEstoqueSelected;

  @observable
  MovtoEstoqueTipo lovMovtoEstoqueTipoSelected;

  @observable
  TextEditingController idItemCons = TextEditingController();
  @observable
  TextEditingController descrItemCons = TextEditingController();
  @observable
  TextEditingController cdTipoMovtoCons = TextEditingController();
  //@observable
  //TextEditingController descrTipoMovtoCons = TextEditingController();

  // listas = LOV
  List<Item> lovItens = [];
  List<ItemEstoque> lovItensEstoque = [];
  List<MovtoEstoqueTipo> lovMovtoTipo = [];

  bool possuiQtdEstoque;

  _MovtoEstoqueListControllerBase() {
    movtoEstoqueDAO = movtoEstoqueDAO ?? MovtoEstoqueDAO();
    itemDAO = itemDAO ?? ItemDAO();
    itemEstoqueDAO = itemEstoqueDAO ?? ItemEstoqueDAO();
    movtoEstoqueTipoDAO = movtoEstoqueTipoDAO ?? MovtoEstoqueTipoDAO();
  }

  @action
  Future<String> validateDropDowns() async {
    if (lovMovtoEstoqueTipoSelected == null || lovItemEstoqueSelected == null) {
      return "Existem campos que faltam ser preenchidos !";
    }

    return "";
  }

  void init() async {
    await listar();
    await fetchMovtoTipo();
    await fetchItemEstoque();
  }

  @action
  Future<List<MovtoEstoque>> filtraMovtos() async {
    /*items = [];
    var future = db.listarItens(
        almox: almoxarifadoOrigem, itemCd: itemCd, itemNome: itemNome);
    itemList = ObservableFuture<List<Item>>(future);
    items = await future;
    return items;*/

    movtosEstoque = [];

    if (idItemCons.text == "") {
      idItemCons.text = "0";
    }

    var future = movtoEstoqueDAO.filtrarMovtos(
        idItem: int.parse(idItemCons.text),
        descrItem: descrItemCons.text,
        cdTipoMovto: cdTipoMovtoCons.text);
    movtosEstoqueList = ObservableFuture<List<MovtoEstoque>>(future);

    if (idItemCons.text == "0") {
      idItemCons.text = "";
    }

    return movtosEstoque = await future;
  }

  verificaQtdEstoque(
      {int idItem,
      double qtdPedida,
      MovtoEstoqueListController movtoEstoqueListController}) async {
    MovtoEstoqueDAO movtoEstoqueDAO = MovtoEstoqueDAO();

    await movtoEstoqueDAO.verificaQtdEstoque(
        idItem, qtdPedida, movtoEstoqueListController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  @action
  Future<List<MovtoEstoque>> listar() async {
    var qtdLinhas = await movtoEstoqueDAO.count();
    print('qtdLinhas => $qtdLinhas');

    movtosEstoque = [];
    var future = movtoEstoqueDAO.listarTodos();
    movtosEstoqueList = ObservableFuture<List<MovtoEstoque>>(future);
    return movtosEstoque = await future;
  }

  Future<List<MovtoEstoque>> filteredListMovtoEstoque(String item) async {
    List<MovtoEstoque> listAux = [];

    if (item != "") {
      movtosEstoque.forEach((v) {
        if (v.id.toString().contains(item.toUpperCase())) listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return movtosEstoque;
    else
      return listAux;
  }

  Future<List<Item>> filteredListItens(String item) async {
    List<Item> listAux = [];

    if (item != "") {
      lovItens.forEach((v) {
        if (v.id.toString().toUpperCase().contains(item.toUpperCase()))
          listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return lovItens;
    else
      return listAux;
  }

  Future<List<ItemEstoque>> filteredListItensEstoque(String item) async {
    List<ItemEstoque> listAux = [];

    if (item != "") {
      lovItensEstoque.forEach((v) {
        if (v.fkItemId.toString().toUpperCase().contains(item.toUpperCase()))
          listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return lovItensEstoque;
    else
      return listAux;
  }

  Future<List<MovtoEstoqueTipo>> filteredListMovtoEstoqueTipo(
      String item) async {
    List<MovtoEstoqueTipo> listAux = [];

    if (item != "") {
      lovMovtoTipo.forEach((v) {
        if (v.id.toString().toUpperCase().contains(item.toUpperCase()))
          listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return lovMovtoTipo;
    else
      return listAux;
  }

  /////////////////////
  @computed
  bool get hasResults =>
      movtosEstoqueList != emptyResponseMovtoEstoque &&
      movtosEstoqueList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<MovtoEstoque>> emptyResponseMovtoEstoque =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<MovtoEstoque>> movtosEstoqueList =
      emptyResponseMovtoEstoque;

  ///////////////////// Item //////////////
  @computed
  bool get hasResultsItem =>
      itensList != emptyResponseItens &&
      itensList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<Item>> emptyResponseItens =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Item>> itensList = emptyResponseItens;

  ///////////////////// ItemEstoque //////////////
  @computed
  bool get hasResultsItemEstoque =>
      itensEstoqueList != emptyResponseItensEstoque &&
      itensEstoqueList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemEstoque>> emptyResponseItensEstoque =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemEstoque>> itensEstoqueList =
      emptyResponseItensEstoque;

  // listas = LOV
  @action
  Future<List<Item>> fetchItem() async {
    lovItens = [];
    var future = itemDAO.listarTodos();
    itensList = ObservableFuture<List<Item>>(future);
    return lovItens = await future;
  }

  // listas = LOV
  @action
  Future<List<ItemEstoque>> fetchItemEstoque() async {
    lovItensEstoque = [];
    var future = itemEstoqueDAO.listarTodos();
    // var future = itemEstoqueDAO.listarTodos();
    itensEstoqueList = ObservableFuture<List<ItemEstoque>>(future);
    return lovItensEstoque = await future;
  }

  // listas = LOV
  @action
  Future<List<MovtoEstoqueTipo>> fetchMovtoTipo() async {
    lovMovtoTipo = [];
    var future = movtoEstoqueTipoDAO.listarTodos();
    movtoTipoList = ObservableFuture<List<MovtoEstoqueTipo>>(future);
    return lovMovtoTipo = await future;
  }

  /////////////////////
  @action
  Future setItemEstoque(ItemEstoque model) async {
    lovItemEstoqueSelected = model;
  }

  /////////////////////
  @computed
  bool get hasResultsMovtoTipo =>
      movtoTipoList != emptyResponseMovtoTipo &&
      movtoTipoList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<MovtoEstoqueTipo>> emptyResponseMovtoTipo =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<MovtoEstoqueTipo>> movtoTipoList =
      emptyResponseMovtoTipo;

  /////////////////////
  @action
  Future setMovtoEstoqueTipo(MovtoEstoqueTipo model) async {
    lovMovtoEstoqueTipoSelected = model;
  }
}
