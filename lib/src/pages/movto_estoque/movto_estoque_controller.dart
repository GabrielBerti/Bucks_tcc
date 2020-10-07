import 'package:bucks/src/classes/item_estoque.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../../DAO/movto_estoque_dao.dart';
import '../../classes/movto_estoque.dart';
import 'movto_estoque_list_controller.dart';

part 'movto_estoque_controller.g.dart';

class MovtoEstoqueController = _MovtoEstoqueControllerBase
    with _$MovtoEstoqueController;

abstract class _MovtoEstoqueControllerBase with Store {
  MovtoEstoqueDAO movtoEstoqueDAO;

  //@observable
  //List<ItemTipo> itensTipo = [];

  // @observable
  // TextEditingController fkItem = TextEditingController();
  // @observable
  // TextEditingController fkMovtoEstoqueTipoS = TextEditingController();
  @observable
  TextEditingController dt = TextEditingController();
  @observable
  TextEditingController qtd = TextEditingController();
  @observable
  TextEditingController vlTotal = TextEditingController();
  @observable
  TextEditingController vlUnit = TextEditingController();

  double qtSaldoAnt;
  double qtSaldoPos;
  double vlUnitAnt;
  double vlUnitPos;

  _MovtoEstoqueControllerBase() {
    movtoEstoqueDAO = movtoEstoqueDAO ?? MovtoEstoqueDAO();
  }

  Future init() async {
    print('init');
  }

  @action
  salvar(
      {@required MovtoEstoqueController store,
      @required MovtoEstoqueListController storeMovtoEstoqueList}) async {
    MovtoEstoque movtoEstoque = MovtoEstoque();
    movtoEstoque.fkItemEstoqueItemId =
        storeMovtoEstoqueList.lovItemEstoqueSelected.fkItemId;
    movtoEstoque.fkMovtoEstoqueTipoId =
        storeMovtoEstoqueList.lovMovtoEstoqueTipoSelected.id;
    movtoEstoque.dt = store.dt.text;
    movtoEstoque.qtd = double.parse(store.qtd.text);

    if (store.vlUnit.text.toString() != '') {
      movtoEstoque.vlUnit = double.parse(store.vlUnit.text);
    }

    //aqui recuperar o valor anterior
    List<ItemEstoque> listItensEstoqueAnt = [];

    var future = movtoEstoqueDAO.recuperaItemEstoqueById(
        movtoEstoque.fkItemEstoqueItemId, null);
    itemsEstoqueList = ObservableFuture<List<ItemEstoque>>(future);
    listItensEstoqueAnt = await future;

    movtoEstoque.vlUnitAnt = listItensEstoqueAnt.first.vlUnit;

    //aqui recuperar a qtd anterior
    movtoEstoque.qtSaldoAnt = listItensEstoqueAnt.first.qtSaldo;

    if (storeMovtoEstoqueList.lovMovtoEstoqueTipoSelected.cdTipoMovto == 'S') {
      movtoEstoqueDAO.updMovimentaEstoqueSaida(
          movtoEstoque.qtd, movtoEstoque.fkItemEstoqueItemId);
    } else {
      movtoEstoqueDAO.updMovimentaEstoqueEntrada(movtoEstoque.vlUnit,
          movtoEstoque.qtd, movtoEstoque.fkItemEstoqueItemId);
    }

    //aqui recuperar o valor posterior
    List<ItemEstoque> listItensEstoquePos = [];

    var futureVlUnitPos = movtoEstoqueDAO.recuperaItemEstoqueById(
        movtoEstoque.fkItemEstoqueItemId, null);
    itemsEstoqueList = ObservableFuture<List<ItemEstoque>>(futureVlUnitPos);
    listItensEstoquePos = await futureVlUnitPos;

    movtoEstoque.vlUnitPos = listItensEstoquePos.first.vlUnit;

    //aqui recuperar a qtd posterior
    movtoEstoque.qtSaldoPos = listItensEstoquePos.first.qtSaldo;

    await movtoEstoqueDAO.salvar(movtoEstoque);

    await storeMovtoEstoqueList.listar();
    await storeMovtoEstoqueList.fetchItemEstoque();
  }

  static ObservableFuture<List<ItemEstoque>> emptyResponseItemEstoque =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemEstoque>> itemsEstoqueList =
      emptyResponseItemEstoque;
}
