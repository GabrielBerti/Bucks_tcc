import 'package:bucks/src/DAO/movto_estoque_tipo_dao.dart';
import 'package:bucks/src/classes/movto_estoque_tipo.dart';
import 'package:mobx/mobx.dart';

part 'movto_estoque_tipo_list_controller.g.dart';

class MovtoEstoqueTipoListController = _MovtoEstoqueTipoListControllerBase
    with _$MovtoEstoqueTipoListController;

abstract class _MovtoEstoqueTipoListControllerBase with Store {
  MovtoEstoqueTipoDAO movtoEstoqueTipoDAO;

  @observable
  List<MovtoEstoqueTipo> movtosEstoqueTipo = [];

  _MovtoEstoqueTipoListControllerBase() {
    movtoEstoqueTipoDAO = movtoEstoqueTipoDAO ?? MovtoEstoqueTipoDAO();
  }

  void init() async {
    await listar();
  }

  @action
  Future<List<MovtoEstoqueTipo>> listar() async {
    var qtdLinhas = await movtoEstoqueTipoDAO.count();
    print('qtdLinhas => $qtdLinhas');
    movtosEstoqueTipo = [];
    var future = movtoEstoqueTipoDAO.listarTodos();
    movtosEstoqueTipoList = ObservableFuture<List<MovtoEstoqueTipo>>(future);
    return movtosEstoqueTipo = await future;
  }

  @computed
  bool get hasResultsItensUnMed =>
      movtosEstoqueTipoList != emptyResponseItensUnMed &&
      movtosEstoqueTipoList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<MovtoEstoqueTipo>> emptyResponseItensUnMed =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<MovtoEstoqueTipo>> movtosEstoqueTipoList =
      emptyResponseItensUnMed;
}
