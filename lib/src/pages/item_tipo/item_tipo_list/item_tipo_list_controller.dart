import 'package:bucks/src/DAO/item_tipo_dao.dart';
import 'package:bucks/src/classes/item_tipo.dart';
import 'package:mobx/mobx.dart';

part 'item_tipo_list_controller.g.dart';

class ItemTipoListController = _ItemTipoListControllerBase
    with _$ItemTipoListController;

abstract class _ItemTipoListControllerBase with Store {

  ItemTipoDAO itemTipoDAO;

  @observable
  List<ItemTipo> itensTipo = [];

  _ItemTipoListControllerBase() {
    itemTipoDAO = itemTipoDAO ?? ItemTipoDAO();
  }

  void init() async {
    await listarItensTipo();
  }

  @action
  Future<List<ItemTipo>> listarItensTipo() async {
    var qtdLinhas = await itemTipoDAO.count();
    print('qtdLinhas => $qtdLinhas');
    itensTipo = [];
    var future = itemTipoDAO.listarTodos();
    itensTipoList = ObservableFuture<List<ItemTipo>>(future);
    return itensTipo = await future;
  }

  @computed
  bool get hasResultsItensTipo =>
      itensTipoList != emptyResponseItensTipo &&
      itensTipoList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemTipo>> emptyResponseItensTipo =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemTipo>> itensTipoList = emptyResponseItensTipo;
}
