import 'package:bucks/src/DAO/item_dao.dart';
import 'package:bucks/src/DAO/item_estoque_dao.dart';
import 'package:bucks/src/DAO/producao_dao.dart';
import 'package:bucks/src/DAO/producao_item_dao.dart';
import 'package:bucks/src/DAO/tipo_producao_dao.dart';
import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/classes/producao_item.dart';
import 'package:bucks/src/classes/tipo_producao.dart';
import 'package:bucks/src/pages/producao/producao_controller.dart';
import 'package:mobx/mobx.dart';

part 'producao_list_controller.g.dart';

class ProducaoListController = _ProducaoListControllerBase
    with _$ProducaoListController;

abstract class _ProducaoListControllerBase with Store {
  // DAO
  ItemEstoqueDAO itemEstoqueDAO;
  ItemDAO itemDAO;
  //TipoProducaoDAO tipoProducaoDAO;
  ProducaoItemDAO producaoItemDAO;
  ProducaoDAO producaoDAO;

  // Controller
  ProducaoController storeProducaoController;

  @observable
  List<Producao> producoes = [];

  @observable
  List<ProducaoItem> producaoItensDt = [];

  @observable
  List<ProducaoItem> producaoItensDtNovoEntrada = [];

  @observable
  List<ProducaoItem> producaoItensDtSaida = [];

  @observable
  List<ProducaoItem> producaoItensIndiretosDt = [];

  @observable
  List<ItemEstoque> itemsEstoqueEntrada = [];

  @observable
  List<ItemEstoque> itemsSaida = [];

  @observable
  List<TipoProducao> tiposProducao = [];

  @observable
  List<Item> itemsIndiretos = [];

  @observable
  List<Producao> ultProdInserida = [];

  @observable
  ItemEstoque itemEstoqueEntrada;

  @observable
  ItemEstoque itemSaida;

  @observable
  Item itemIndireto;

  @observable
  TipoProducao tipoProducao;

  @observable
  ProducaoItem producaoItem;

  @observable
  Producao producao;

  String tipoProducaoItem;
  bool possuiQtdEstoque;
  bool isAlteracao = false;
  bool qtdMinEstoqueUltrapassada;
  double custoTotalProd = 0;

  _ProducaoListControllerBase() {
    itemEstoqueDAO = itemEstoqueDAO ?? ItemEstoqueDAO();
    itemDAO = itemDAO ?? ItemDAO();
    producaoItemDAO = producaoItemDAO ?? ProducaoItemDAO();
    producaoDAO = producaoDAO ?? ProducaoDAO();
  }

  void init() async {
    //print('entrou');
    await listar();
    await listarItemEstoque();
    await listarItemSaida();
    await listarItemIndireto();
    await listarTipoProducao();

    //await listarProducaoItem(producao);
    //await listarProducaoItemSemEst(producao);
  }

  calculaCustoDaProducao(Producao producao) async {
    custoTotalProd = 0;
    producaoItensDt = [];

    var future = producaoItemDAO.listarProducaoItemDaProducao(producao);
    // var future = itemEstoqueDAO.listarItemEstoque();
    producaoItemList = ObservableFuture<List<ProducaoItem>>(future);
    producaoItensDt = await future;

    for (var prod in producaoItensDt) {
      if (prod.vlUnit != 0 && prod.cdTipo == 'E') {
        custoTotalProd = custoTotalProd + (prod.qt * prod.vlUnit);
      }
    }

    if (producao.vlMo != null) {
      custoTotalProd = custoTotalProd + producao.vlMo;
    }

    if (producao.vlCustosInd != null) {
      custoTotalProd = custoTotalProd + producao.vlCustosInd;
    }
  }

  @action
  Future<List<ItemEstoque>> listarItemEstoque() async {
    itemsEstoqueEntrada = [];
    var future = itemEstoqueDAO.listarTodos();
    // var future = itemEstoqueDAO.listarItemEstoque();
    itemEstoqueEntradaList = ObservableFuture<List<ItemEstoque>>(future);
    itemsEstoqueEntrada = await future;
    return itemsEstoqueEntrada;
  }

  @action
  Future<List<ItemEstoque>> listarItemSaida() async {
    itemsSaida = [];
    //var future = itemDAO.listarItensSemEstoque();
    var future = itemEstoqueDAO.listarTodos();
    // var future = itemEstoqueDAO.listarItemEstoque();
    itemSaidaList = ObservableFuture<List<ItemEstoque>>(future);
    itemsSaida = await future;
    return itemsSaida;
  }

  @action
  Future<List<Item>> listarItemIndireto() async {
    itemsIndiretos = [];
    var future = itemDAO.listarItensSemEstoque();
    // var future = itemEstoqueDAO.listarItemEstoque();
    itemIndiretoList = ObservableFuture<List<Item>>(future);
    itemsIndiretos = await future;
    return itemsIndiretos;
  }

  @action
  Future<List<TipoProducao>> listarTipoProducao() async {
    tiposProducao = [];
    TipoProducaoDAO tipoProducaoDAO = TipoProducaoDAO();

    var future = tipoProducaoDAO.listarTodos();
    tipoProducaoList = ObservableFuture<List<TipoProducao>>(future);
    tiposProducao = await future;
    return tiposProducao;
  }

  Future<List<TipoProducao>> fetchTipoProducaoAlteracao(int idProd) async {
    List<TipoProducao> listTipoProdAlt = [];
    TipoProducaoDAO tipoProducaoDAO = TipoProducaoDAO();

    var future = tipoProducaoDAO.recuperaTipoProdById(idProd);
    tipoProducaoListAlteracao = ObservableFuture<List<TipoProducao>>(future);
    listTipoProdAlt = await future;

    await setTipoProducao(listTipoProdAlt.first);
  }

  @action
  Future<List<ProducaoItem>> listarProducaoItem(Producao producao) async {
    producaoItensDt = [];

    var future = producaoItemDAO.listarProducaoItemDaProducao(producao);
    // var future = itemEstoqueDAO.listarItemEstoque();
    producaoItemList = ObservableFuture<List<ProducaoItem>>(future);
    producaoItensDt = await future;

    //await calculaCustoDaProducao(producao);
    return producaoItensDt;
  }

  @action
  Future<List<Producao>> listarProducaoById(int id) async {
    ultProdInserida = [];
    var future = producaoDAO.listarProducaoById(id: id);
    //itemEstoqueList = ObservableFuture<List<Producao>>(future);
    ultProdInserida = await future;
    return ultProdInserida;
  }

  @action
  Future setLixo() async {
    null;
  }

  @action
  Future setTipoProducao(TipoProducao model) async {
    tipoProducao = model;
  }

  @action
  salvarProducaoItem({ProducaoItem producaoItem, Producao producao}) async {
    await producaoItemDAO.salvar(producaoItem);

    await listar();
    await listarProducaoItem(producao);

    producaoItensDtNovoEntrada.clear();
    producaoItensDtSaida.clear();
    producaoItensIndiretosDt.clear();
  }

  @action
  Future setProducaoItemEstoqueEntrada(
      ItemEstoque model, Producao producao) async {
    //print(id);

    //await listarProducaoById(int.parse(id));

    var idProd;
    var nomeProd;
    /*for (var prod in ultProdInserida) {
      print(ultProdInserida.last.id);
      print(ultProdInserida.last.descr);
      idProd = ultProdInserida.last.id;
      nomeProd = ultProdInserida.last.descr;
    }*/

    idProd = producao.id;
    nomeProd = producao.descr;

    var seqProdItem;
    for (var prodItens in producaoItensDtNovoEntrada) {
      seqProdItem = prodItens.seq + 1;
    }

    if (seqProdItem == null) {
      seqProdItem = 1;
    }

    ProducaoItem pi = new ProducaoItem();
    pi.fkProducaoId = idProd;
    pi.seq = seqProdItem;
    pi.fkItemId = model.fkItemId;
    //pi.vlUnit = model.vlUnit;
    pi.cdTipo = tipoProducaoItem;
    pi.descrItem = model.fkItemDescr;
    pi.descrProducao = nomeProd;

    producaoItensDtNovoEntrada = producaoItensDtNovoEntrada;
    producaoItensDtNovoEntrada.add(pi);
  }

  @action
  Future setProducaoItemSaida(ItemEstoque model, Producao producao) async {
    //print(id);
    //await listarProducaoById(int.parse(id));

    var idProd;
    var nomeProd;
    /*for (var prod in ultProdInserida) {
      print(ultProdInserida.last.id);
      print(ultProdInserida.last.descr);
      idProd = ultProdInserida.last.id;
      nomeProd = ultProdInserida.last.descr;
    }*/

    idProd = producao.id;
    nomeProd = producao.descr;

    var seqProdItem;
    for (var prodItens in producaoItensDtSaida) {
      seqProdItem = prodItens.seq + 1;
    }

    if (seqProdItem == null) {
      seqProdItem = 1;
    }

    ProducaoItem pi = new ProducaoItem();
    pi.fkProducaoId = idProd;
    pi.seq = seqProdItem;
    pi.fkItemId = model.fkItemId;
    pi.cdTipo = tipoProducaoItem;
    //pi.vlUnit = model.;
    pi.descrItem = model.fkItemDescr;
    pi.descrProducao = nomeProd;

    producaoItensDtSaida = producaoItensDtSaida;
    producaoItensDtSaida.add(pi);
  }

  @action
  Future setProducaoItemIndireto(Item model, Producao producao) async {
    //print(id);
    //await listarProducaoById(int.parse(id));

    var idProd;
    var nomeProd;
    /*for (var prod in ultProdInserida) {
      print(ultProdInserida.last.id);
      print(ultProdInserida.last.descr);
      idProd = ultProdInserida.last.id;
      nomeProd = ultProdInserida.last.descr;
    }*/

    idProd = producao.id;
    nomeProd = producao.descr;

    var seqProdItem;
    for (var prodItens in producaoItensIndiretosDt) {
      seqProdItem = prodItens.seq + 1;
    }

    if (seqProdItem == null) {
      seqProdItem = 1;
    }

    ProducaoItem pi = new ProducaoItem();
    pi.fkProducaoId = idProd;
    pi.seq = seqProdItem;
    pi.fkItemId = model.id;
    pi.cdTipo = tipoProducaoItem;
    //pi.vlUnit = model.vlUnit;
    pi.descrItem = model.descr;
    pi.descrProducao = nomeProd;

    producaoItensIndiretosDt = producaoItensIndiretosDt;
    producaoItensIndiretosDt.add(pi);
  }

  @action
  Future<List<Producao>> listar() async {
    var qtdLinhas = await producaoDAO.count();
    print('qtdLinhas => $qtdLinhas');
    producoes = [];
    var future = producaoDAO.listarTodos();
    producoesList = ObservableFuture<List<Producao>>(future);
    return producoes = await future;
  }

  verificaQtdEstoque(
      {int idItem,
      double qtdPedida,
      ProducaoListController producaoListController}) async {
    ProducaoItemDAO producaoItemDAO = ProducaoItemDAO();

    await producaoItemDAO.verificaQtdEstoque(
        idItem, qtdPedida, producaoListController);

    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaVlMinEstoque(
      {int idItem,
      ProducaoItem producaoItem,
      ProducaoListController producaoListController}) async {
    ItemDAO itemDAO = ItemDAO();
    ItemEstoqueDAO itemEstoqueDAO = ItemEstoqueDAO();
    qtdMinEstoqueUltrapassada = false;

    List<Item> itens = [];
    var future = itemDAO.retornaItemById(idItem);
    itensList = ObservableFuture<List<Item>>(future);

    itens = await future;

    double vlMinEstoque = itens.first.qtdMinEstoque;

    List<ItemEstoque> itensEstoque = [];
    var future2 = itemEstoqueDAO.retornaItemById(idItem);
    itensEstoqueList = ObservableFuture<List<ItemEstoque>>(future2);

    itensEstoque = await future2;

    double qtdRestanteEst = itensEstoque.first.qtSaldo - producaoItem.qt;

    if (qtdRestanteEst < vlMinEstoque) {
      producaoListController.qtdMinEstoqueUltrapassada = true;
    }
  }

  @action
  deletarProducaoItem({
    ProducaoItem producaoItem,
  }) {
    //await itemGrupoDAO.salvar(itemGrupo);
    producaoItemDAO.deletarProducaoItem(
        producaoItem.seq, producaoItem.fkProducaoId, producaoItem.fkItemId);

    removeProdItemDataTable(producaoItem);
    //await storeItemGrupoList.listarItensGrupo();
  }

  @action
  removeProdItemDataTable(ProducaoItem data) async {
    producaoItensDt = producaoItensDt;
    producaoItensDt.remove(data);
  }

  @action
  removeitemsDataTableEntrada(ProducaoItem data) async {
    producaoItensDtNovoEntrada = producaoItensDtNovoEntrada;
    producaoItensDtNovoEntrada.remove(data);
  }

  @action
  removeitemsDtSaida(ProducaoItem data) async {
    producaoItensDtSaida = producaoItensDtSaida;
    producaoItensDtSaida.remove(data);
  }

  @action
  removeitemsIndiretosDt(ProducaoItem data) async {
    producaoItensIndiretosDt = producaoItensIndiretosDt;
    producaoItensIndiretosDt.remove(data);
  }

  @action
  bool validaDataTableItemSaidaPossuiItem(ItemEstoque item) {
    bool possuiItemDataTable = false;

    producaoItensDtSaida.forEach((v1) {
      if (v1.fkItemId == item.fkItemId) {
        possuiItemDataTable = true;
      }
    });

    producaoItensDt.forEach((v1) {
      if (v1.fkItemId == item.fkItemId) {
        possuiItemDataTable = true;
      }
    });

    return possuiItemDataTable;
  }

  @action
  bool validaDataTableItemIndiretoPossuiItem(Item item) {
    bool possuiItemDataTable = false;

    producaoItensIndiretosDt.forEach((v1) {
      if (v1.fkItemId == item.id) {
        possuiItemDataTable = true;
      }
    });

    producaoItensDt.forEach((v1) {
      if (v1.fkItemId == item.id) {
        possuiItemDataTable = true;
      }
    });

    return possuiItemDataTable;
  }

  @action
  bool validaDataTableEntradaPossuiItem(ItemEstoque item) {
    bool possuiItemDataTable = false;

    producaoItensDtNovoEntrada.forEach((v1) {
      if (v1.fkItemId == item.fkItemId) {
        possuiItemDataTable = true;
      }
    });

    producaoItensDt.forEach((v1) {
      if (v1.fkItemId == item.fkItemId) {
        possuiItemDataTable = true;
      }
    });

    return possuiItemDataTable;
  }

  static ObservableFuture<List<TipoProducao>>
      emptyResponseTipoProducaoAlteracao = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<TipoProducao>> tipoProducaoListAlteracao =
      emptyResponseTipoProducaoAlteracao;

  //@computed
  //bool get hasResultsProducaoItensDt => itemProducaoDtList   != [];

  Future<List<ItemEstoque>> filteredListItemEstoqueEntrada(String item) async {
    List<ItemEstoque> listAux = [];

    if (item != "") {
      itemsEstoqueEntrada.forEach((v) {
        if (v.fkItemId.toString().toUpperCase().contains(item.toUpperCase()) ||
            v.fkItemDescr.toString().contains(item)) listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return itemsEstoqueEntrada;
    else
      return listAux;
  }

  Future<List<TipoProducao>> filteredListTipoProducao(String item) async {
    List<TipoProducao> listAux = [];

    if (item != "") {
      tiposProducao.forEach((v) {
        if (v.id.toString().toUpperCase().contains(item.toUpperCase()) ||
            v.descr.toString().contains(item)) listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return tiposProducao;
    else
      return listAux;
  }

  Future<List<ItemEstoque>> filteredListItemSaida(String item) async {
    List<ItemEstoque> listAux = [];

    if (item != "") {
      itemsSaida.forEach((v) {
        if (v.fkItemId.toString().toUpperCase().contains(item.toUpperCase()) ||
            v.fkItemDescr.toString().contains(item)) listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return itemsSaida;
    else
      return listAux;
  }

  Future<List<Item>> filteredListItemIndireto(String item) async {
    List<Item> listAux = [];

    if (item != "") {
      itemsIndiretos.forEach((v) {
        if (v.id.toString().toUpperCase().contains(item.toUpperCase()) ||
            v.descr.toString().contains(item)) listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return itemsIndiretos;
    else
      return listAux;
  }

  @computed
  bool get hasResultsItemEstoque =>
      itensEstoqueList != emptyResponseItensEstoque &&
      itensEstoqueList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemEstoque>> emptyResponseItensEstoque =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemEstoque>> itensEstoqueList =
      emptyResponseItensEstoque;

  @computed
  bool get hasResultsItem =>
      itensList != emptyResponseItens &&
      itensList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<Item>> emptyResponseItens =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Item>> itensList = emptyResponseItens;

  @computed
  bool get hasResultsProducao =>
      producoesList != emptyResponseProducao &&
      producoesList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<Producao>> emptyResponseProducao =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Producao>> producoesList = emptyResponseProducao;

  @observable
  ObservableFuture<List<ProducaoItem>> producaoItemListDt =
      emptyResponseProducaoItem;

  @computed
  bool get hasResultsProducaoItemDt =>
      producaoItemListDt != emptyResponseProducaoItemDt &&
      producaoItemListDt.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ProducaoItem>> emptyResponseProducaoItemDt =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ProducaoItem>> producaoItemList =
      emptyResponseProducaoItem;

  @computed
  bool get hasResultsProducaoItemDtNovoEntrada =>
      producaoItemNovoEntradaList != emptyResponseProducaoItemDtNovoEntrada &&
      producaoItemNovoEntradaList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ProducaoItem>>
      emptyResponseProducaoItemDtNovoEntrada = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ProducaoItem>> producaoItemNovoEntradaList =
      emptyResponseProducaoItemDtNovoEntrada;

  @computed
  bool get hasResultsProducaoItemDtSemEst =>
      producaoItemSemEstList != producaoItemSemEstList &&
      producaoItemSemEstList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ProducaoItem>>
      emptyResponseProducaoItemDtSemEst = ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ProducaoItem>> producaoItemSemEstList =
      emptyResponseProducaoItemDtSemEst;

  @computed
  bool get hasResultsProducaoItem =>
      producaoItemList != emptyResponseProducaoItem &&
      producaoItemList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ProducaoItem>> emptyResponseProducaoItem =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemEstoque>> itemEstoqueEntradaList =
      emptyResponseItemEstoqueEntrada;

  @computed
  bool get hasResultsItemEstoqueEntrada =>
      itemEstoqueEntradaList != emptyResponseItemEstoqueEntrada &&
      itemEstoqueEntradaList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemEstoque>> emptyResponseItemEstoqueEntrada =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemEstoque>> itemSaidaList = emptyResponseItemSaida;

  @computed
  bool get hasResultsItemSaida =>
      itemSaidaList != emptyResponseItemSaida &&
      itemSaidaList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemEstoque>> emptyResponseItemSaida =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<TipoProducao>> tipoProducaoList =
      emptyResponseTipoProducao;

  @computed
  bool get hasResultsTipoProducao =>
      tipoProducaoList != emptyResponseTipoProducao &&
      tipoProducaoList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<TipoProducao>> emptyResponseTipoProducao =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Item>> itemIndiretoList = emptyResponseItemIndireto;

  @computed
  bool get hasResultsItemIndireto =>
      itemIndiretoList != emptyResponseItemIndireto &&
      itemIndiretoList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<Item>> emptyResponseItemIndireto =
      ObservableFuture.value([]);
}
