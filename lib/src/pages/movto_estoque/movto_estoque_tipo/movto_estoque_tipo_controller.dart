import 'package:bucks/src/DAO/item_dao.dart';
import 'package:bucks/src/DAO/movto_estoque_dao.dart';
import 'package:bucks/src/DAO/movto_estoque_tipo_dao.dart';
import 'package:bucks/src/classes/movto_estoque_tipo.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import 'movto_estoque_tipo_list/movto_estoque_tipo_list_controller.dart';

part 'movto_estoque_tipo_controller.g.dart';

class MovtoEstoqueTipoController = _MovtoEstoqueTipoControllerBase
    with _$MovtoEstoqueTipoController;

abstract class _MovtoEstoqueTipoControllerBase with Store {
  MovtoEstoqueTipoDAO movtoEstoqueTipoDAO;

  bool possuiRelacao;

  @observable
  TextEditingController tecId = TextEditingController();
  TextEditingController tecDescr = TextEditingController();
  TextEditingController tecCdTipoMovto = TextEditingController();

  _MovtoEstoqueTipoControllerBase() {
    movtoEstoqueTipoDAO = movtoEstoqueTipoDAO ?? MovtoEstoqueTipoDAO();
  }

  @action
  salvar(
      {@required
          MovtoEstoqueTipoController store,
      @required
          MovtoEstoqueTipoListController storeMovtoEstoqueTipoList}) async {
    MovtoEstoqueTipo movtoEstoqueTipo = MovtoEstoqueTipo();

    if (store.tecId.text != "") {
      movtoEstoqueTipo.id = int.parse(store.tecId.text);
    }

    movtoEstoqueTipo.descr = store.tecDescr.text;
    movtoEstoqueTipo.cdTipoMovto = store.tecCdTipoMovto.text;

    await movtoEstoqueTipoDAO.salvar(movtoEstoqueTipo);

    await storeMovtoEstoqueTipoList.listar();
  }

  @action
  deletarMovtoEstoqueTipo({
    MovtoEstoqueTipo movtoEstoqueTipo,
  }) {
    //await itemGrupoDAO.salvar(itemGrupo);
    movtoEstoqueTipoDAO.deletar(movtoEstoqueTipo.id);
    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaRelacionamentosMovtoEstoqueTipo(
      {MovtoEstoqueTipo movtoEstoqueTipo,
      MovtoEstoqueTipoController movtoEstoqueTipoController}) async {
    MovtoEstoqueDAO movtoEstoqueDAO = MovtoEstoqueDAO();

    await movtoEstoqueDAO.verificaRelacionamentosMovtoEstoqueTipo(
        movtoEstoqueTipo.id, movtoEstoqueTipoController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  @observable
  int value = 0;

  @action
  void increment() {
    value++;
  }
}
