import 'package:bucks/src/DAO/item_unmed_dao.dart';
import 'package:bucks/src/classes/item_unmed.dart';
import 'package:mobx/mobx.dart';

part 'item_unmed_list_controller.g.dart';

class ItemUnmedListController = _ItemUnmedListControllerBase
    with _$ItemUnmedListController;

abstract class _ItemUnmedListControllerBase with Store {
  ItemUnmedDAO itemUnmedDAO;

  @observable
  List<ItemUnmed> itensUnmed = [];

  _ItemUnmedListControllerBase() {
    itemUnmedDAO = itemUnmedDAO ?? ItemUnmedDAO();
  }

  void init() async {
    await listar();
  }

  @action
  Future<List<ItemUnmed>> listar() async {
    var qtdLinhas = await itemUnmedDAO.count();
    print('qtdLinhas => $qtdLinhas');
    itensUnmed = [];
    // var future = itemUnmedDAO.listarItemUnMed();
    // var future = itemUnmedDAO.consultar('select * from item_unmed');
    var future = itemUnmedDAO.listarTodos();
    itensUnmedList = ObservableFuture<List<ItemUnmed>>(future);
    return itensUnmed = await future;
  }

  @computed
  bool get hasResultsItensUnmed =>
      itensUnmedList != emptyResponseItensUnmed &&
      itensUnmedList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemUnmed>> emptyResponseItensUnmed =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemUnmed>> itensUnmedList = emptyResponseItensUnmed;
}
