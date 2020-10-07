import 'package:bucks/src/DAO/movto_estoque_dao.dart';
import 'package:bucks/src/DAO/producao_dao.dart';
import 'package:bucks/src/DAO/producao_item_dao.dart';
import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/classes/movto_estoque.dart';
import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/classes/producao_item.dart';
import 'package:bucks/src/classes/tipo_producao.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/shared/utils/date.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'producao_controller.g.dart';

class ProducaoController = _ProducaoControllerBase with _$ProducaoController;

abstract class _ProducaoControllerBase with Store {
  ProducaoDAO producaoDAO;

  @observable
  List<Producao> ultProdInserida = [];

  @observable
  TextEditingController id = TextEditingController();
  @observable
  TextEditingController descr = TextEditingController();
  @observable
  TextEditingController vlMo = TextEditingController();
  @observable
  TextEditingController vlCustosInd = TextEditingController();
  @observable
  TextEditingController dtProducaoIni = TextEditingController();
  @observable
  TextEditingController dtProducaoFim = TextEditingController();
  @observable
  TextEditingController cdStatus = TextEditingController();

  bool isItemEstoque = false;

  _ProducaoControllerBase() {
    producaoDAO = producaoDAO ?? ProducaoDAO();
  }

  @action
  Future init() async {}

  @action
  baixarProducao(
      {@required ProducaoController store,
      @required ProducaoListController storeProducaoList}) async {
    for (var prodItem in storeProducaoList.producaoItensDt) {
      await producaoDAO.verificaItemEstoque(prodItem.fkItemId, store);

      if (store.isItemEstoque == true && prodItem.cdStatus == null) {
        MovtoEstoque movtoEstoque = MovtoEstoque();
        MovtoEstoqueDAO movtoEstoqueDAO = MovtoEstoqueDAO();

        movtoEstoque.fkItemEstoqueItemId = prodItem.fkItemId;

        movtoEstoque.dt = dateFormat("dd/MM/yyyy", DateTime.now());
        movtoEstoque.qtd = prodItem.qt;

        if (prodItem.vlUnit != null) {
          movtoEstoque.vlUnit = prodItem.vlUnit;
        }

        //aqui recuperar o valor anterior
        List<ItemEstoque> listItensEstoqueAnt = [];

        var future = producaoDAO
            .recuperaItemEstoqueById(movtoEstoque.fkItemEstoqueItemId);
        itemsEstoqueList = ObservableFuture<List<ItemEstoque>>(future);
        listItensEstoqueAnt = await future;
        ProducaoItemDAO producaoItemDAO = ProducaoItemDAO();

        movtoEstoque.vlUnitAnt = listItensEstoqueAnt.first.vlUnit;

        //aqui recuperar a qtd anterior
        movtoEstoque.qtSaldoAnt = listItensEstoqueAnt.first.qtSaldo;

        if (prodItem.cdTipo == 'S') {
          movtoEstoque.fkMovtoEstoqueTipoId = 1;
          await producaoItemDAO.updMovimentaEstoqueEntrada(movtoEstoque.vlUnit,
              movtoEstoque.qtd, movtoEstoque.fkItemEstoqueItemId);
        } else {
          movtoEstoque.fkMovtoEstoqueTipoId = 2;
          await producaoItemDAO.updMovimentaEstoqueSaida(movtoEstoque.vlUnit,
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

        movtoEstoque.fkProditemProducaoId = prodItem.fkProducaoId;
        movtoEstoque.fkProditemSeq = prodItem.seq;

        await movtoEstoqueDAO.salvar(movtoEstoque);

        prodItem.cdStatus = "S";

        await updProdItemBaixado(producaoItem: prodItem);

        Producao producao = Producao();
        producao.id = prodItem.fkProducaoId;
        await storeProducaoList.listarProducaoItem(producao);

        /*await storeProducaoList.listar();
        await storeProducaoList.listarItemEstoque();
        await storeProducaoList.listarItemSaida();
        await storeProducaoList.listarItemIndireto();*/
      }
    }
  }

  @action
  salvar(
      {@required ProducaoController store,
      @required ProducaoListController storeProducaoList}) async {
    Producao producao = Producao();

    if (store.id.text != "") {
      producao.id = int.parse(store.id.text);
    }

    if (store.vlMo.text != "") {
      producao.vlMo = double.parse(store.vlMo.text);
    }

    if (store.vlCustosInd.text != "") {
      producao.vlCustosInd = double.parse(store.vlCustosInd.text);
    }

    producao.descr = store.descr.text;

    producao.dtProducaoIni = store.dtProducaoIni.text;
    producao.dtProducaoFim = store.dtProducaoFim.text;
    producao.cdStatus = store.cdStatus.text;
    producao.fkProducaoTipoId = storeProducaoList.tipoProducao.id;

    producao.id = await producaoDAO.salvar(producao);

    await storeProducaoList.listar();

    ultProdInserida = await producaoDAO.listarProducaoById(id: producao.id);

    store.id.text = id.toString();
  }

  @action
  updProdItemBaixado({@required ProducaoItem producaoItem}) async {
    ProducaoItemDAO producaoItemDAO = ProducaoItemDAO();

    await producaoItemDAO.updProdItemBaixado(producaoItem.cdStatus,
        producaoItem.fkProducaoId, producaoItem.seq, producaoItem.fkItemId);
  }

  static ObservableFuture<List<ItemEstoque>> emptyResponseItemEstoque =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemEstoque>> itemsEstoqueList =
      emptyResponseItemEstoque;
}
