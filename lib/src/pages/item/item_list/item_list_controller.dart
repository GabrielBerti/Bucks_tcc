import 'package:bucks/src/DAO/item_dao.dart';
import 'package:bucks/src/DAO/item_grupo_dao.dart';
import 'package:bucks/src/DAO/item_tipo_dao.dart';
import 'package:bucks/src/DAO/item_unmed_dao.dart';
import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/classes/item_grupo.dart';
import 'package:bucks/src/classes/item_tipo.dart';
import 'package:bucks/src/classes/item_unmed.dart';
import 'package:mobx/mobx.dart';

part 'item_list_controller.g.dart';

class ItemListController = _ItemListControllerBase with _$ItemListController;

abstract class _ItemListControllerBase with Store {
  ItemTipoDAO itemTipoDAO;
  ItemGrupoDAO itemGrupoDAO;
  ItemUnmedDAO itemUnmedDAO;
  ItemDAO itemDAO;

  bool isAlteracao = false;

  @observable
  List<Item> itens = [];

  List<ItemTipo> itensTipo = [];
  List<ItemGrupo> itensGrupo = [];
  List<ItemUnmed> itensUnMed = [];

  @observable
  Item item;

  @observable
  ItemTipo itemTipo;

  @observable
  ItemGrupo itemGrupo;

  @observable
  ItemUnmed itemUnmed;

  _ItemListControllerBase() {
    itemTipoDAO = itemTipoDAO ?? ItemTipoDAO();
    itemGrupoDAO = itemGrupoDAO ?? ItemGrupoDAO();
    itemUnmedDAO = itemUnmedDAO ?? ItemUnmedDAO();
    itemDAO = itemDAO ?? ItemDAO();
  }

  void init() async {
    await listarItens();

    await fetchItemTipo();
    await fetchItemGrupo();
    await fetchItemUnMed();
  }

  @action
  Future<List<ItemTipo>> fetchItemTipo() async {
    itensTipo = [];
    var future = itemTipoDAO.listarTodos();
    itemTipoList = ObservableFuture<List<ItemTipo>>(future);
    return itensTipo = await future;
  }

  Future<List<ItemTipo>> fetchItemTipoAlteracao(int itemId) async {
    List<ItemTipo> listItensTipoAlt = [];

    var future = itemTipoDAO.recuperaItemTipoById(itemId);
    itemsTipoListAlteracao = ObservableFuture<List<ItemTipo>>(future);
    listItensTipoAlt = await future;

    await setItemTipo(listItensTipoAlt.first);
  }

  Future<List<ItemGrupo>> fetchItemGrupoAlteracao(int itemId) async {
    List<ItemGrupo> listItensGrupoAlt = [];

    var future = itemGrupoDAO.recuperaItemGrupoById(itemId);
    itemsGrupoListAlteracao = ObservableFuture<List<ItemGrupo>>(future);
    listItensGrupoAlt = await future;

    await setItemGrupo(listItensGrupoAlt.first);
  }

  Future<List<ItemUnmed>> fetchItemUnMedAlteracao(int itemId) async {
    List<ItemUnmed> listItensUnMedAlt = [];

    var future = itemUnmedDAO.recuperaItemUnMedById(itemId);
    itemsUnMedListAlteracao = ObservableFuture<List<ItemUnmed>>(future);
    listItensUnMedAlt = await future;

    await setItemUnMed(listItensUnMedAlt.first);
  }

  @action
  Future<List<ItemGrupo>> fetchItemGrupo() async {
    itensGrupo = [];
    var future = itemGrupoDAO.listarTodos();
    itemGrupoList = ObservableFuture<List<ItemGrupo>>(future);
    return itensGrupo = await future;
  }

  @action
  Future<List<ItemUnmed>> fetchItemUnMed() async {
    itensUnMed = [];
    var future = itemUnmedDAO.listarTodos();
    itemUnMedList = ObservableFuture<List<ItemUnmed>>(future);
    return itensUnMed = await future;
  }

  @action
  Future<List<Item>> listarItens() async {
    var qtdLinhas = await itemDAO.count();
    print('qtdLinhas => $qtdLinhas');
    itens = [];
    var future = itemDAO.listarTodos();
    itensList = ObservableFuture<List<Item>>(future);
    return itens = await future;
  }

  @action
  Future<String> listarDescrItemTipo() async {
    itens = [];
    final result = itemTipoDAO.listarDescrItemTipo();
    return result;
  }

  @action
  Future<String> validateDropDowns() async {
    if (itemTipo == null || itemGrupo == null || itemUnmed == null) {
      return "Existem campos que faltam ser preenchidos !";
    }

    return "";
  }

  Future<List<Item>> filteredListItens(String item) async {
    List<Item> listAux = [];

    if (item != "") {
      itens.forEach((v) {
        if (v.id.toString().toUpperCase().contains(item.toUpperCase()) ||
            v.descr.toString().contains(item)) listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return itens;
    else
      return listAux;
  }

  static ObservableFuture<List<ItemTipo>> emptyResponseItemTipoAlteracao =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemTipo>> itemsTipoListAlteracao =
      emptyResponseItemTipoAlteracao;

  static ObservableFuture<List<ItemGrupo>> emptyResponseItemGrupoAlteracao =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemGrupo>> itemsGrupoListAlteracao =
      emptyResponseItemGrupoAlteracao;

  static ObservableFuture<List<ItemUnmed>> emptyResponseItemUnMedAlteracao =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemUnmed>> itemsUnMedListAlteracao =
      emptyResponseItemUnMedAlteracao;

  @action
  setItemTipo(ItemTipo model) async {
    itemTipo = model;
  }

  @action
  Future setItemGrupo(ItemGrupo model) async {
    itemGrupo = model;
  }

  @action
  Future setItemUnMed(ItemUnmed model) async {
    itemUnmed = model;
  }

  Future<List<ItemTipo>> filteredListItensTipos(String item) async {
    List<ItemTipo> listAux = [];

    if (item != "") {
      itensTipo.forEach((v) {
        if (v.id.toString().toUpperCase().contains(item.toUpperCase()) ||
            v.descr.toString().contains(item)) listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return itensTipo;
    else
      return listAux;
  }

  Future<List<ItemGrupo>> filteredListItensGrupos(String item) async {
    List<ItemGrupo> listAux = [];

    if (item != "") {
      itensGrupo.forEach((v) {
        if (v.id.toString().toUpperCase().contains(item.toUpperCase()) ||
            v.descr.toString().contains(item)) listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return itensGrupo;
    else
      return listAux;
  }

  Future<List<ItemUnmed>> filteredListItensUnMed(String item) async {
    List<ItemUnmed> listAux = [];

    if (item != "") {
      itensUnMed.forEach((v) {
        if (v.id.toString().toUpperCase().contains(item.toUpperCase()) ||
            v.descr.toString().contains(item)) listAux.add(v);
      });
    }
    if (listAux.isEmpty)
      return itensUnMed;
    else
      return listAux;
  }

  @computed
  bool get hasResultsItens =>
      itensList != emptyResponseItens &&
      itensList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<Item>> emptyResponseItens =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<Item>> itensList = emptyResponseItens;

  @computed
  bool get hasResultsItemTipo =>
      itemTipoList != emptyResponseItemTipo &&
      itemTipoList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemTipo>> emptyResponseItemTipo =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemTipo>> itemTipoList = emptyResponseItemTipo;

  @computed
  bool get hasResultsItemGrupo =>
      itemGrupoList != emptyResponseItemGrupo &&
      itemGrupoList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemGrupo>> emptyResponseItemGrupo =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemGrupo>> itemGrupoList = emptyResponseItemGrupo;

  @computed
  bool get hasResultsItemUnMed =>
      itemUnMedList != emptyResponseItemUnMed &&
      itemUnMedList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemUnmed>> emptyResponseItemUnMed =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemUnmed>> itemUnMedList = emptyResponseItemUnMed;
}
