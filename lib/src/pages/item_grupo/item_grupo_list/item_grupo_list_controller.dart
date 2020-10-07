import 'package:bucks/src/DAO/item_grupo_dao.dart';
import 'package:bucks/src/classes/item_grupo.dart';
import 'package:mobx/mobx.dart';

part 'item_grupo_list_controller.g.dart';

class ItemGrupoListController = _ItemGrupoListControllerBase
    with _$ItemGrupoListController;

abstract class _ItemGrupoListControllerBase with Store {
  ItemGrupoDAO itemGrupoDAO;

  @observable
  List<ItemGrupo> itensGrupo = [];

  _ItemGrupoListControllerBase() {
    itemGrupoDAO = itemGrupoDAO ?? ItemGrupoDAO();
  }

  void init() async {
    await listarItensGrupo();
  }

  @action
  Future<List<ItemGrupo>> listarItensGrupo() async {
    var qtdLinhas = await itemGrupoDAO.count();
    print('qtdLinhas => $qtdLinhas');
    itensGrupo = [];
    var future = itemGrupoDAO.listarTodos();
    itensGrupoList = ObservableFuture<List<ItemGrupo>>(future);
    return itensGrupo = await future;
  }

  @computed
  bool get hasResultsItensGrupo =>
      itensGrupoList != emptyResponseItensGrupo &&
      itensGrupoList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<ItemGrupo>> emptyResponseItensGrupo =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<ItemGrupo>> itensGrupoList = emptyResponseItensGrupo;
}
