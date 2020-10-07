import 'package:bucks/src/DAO/tipo_producao_dao.dart';
import 'package:bucks/src/classes/tipo_producao.dart';
import 'package:mobx/mobx.dart';

part 'tipo_producao_list_controller.g.dart';

class TipoProducaoListController = _TipoProducaoListControllerBase
    with _$TipoProducaoListController;

abstract class _TipoProducaoListControllerBase with Store {
  TipoProducaoDAO tipoProducaoDAO;

  @observable
  List<TipoProducao> tiposProducao = [];

  _TipoProducaoListControllerBase() {
    tipoProducaoDAO = tipoProducaoDAO ?? TipoProducaoDAO();
  }

  void init() async {
    await listarTiposProducao();
  }

  @action
  Future<List<TipoProducao>> listarTiposProducao() async {
    var qtdLinhas = await tipoProducaoDAO.count();
    print('qtdLinhas => $qtdLinhas');
    tiposProducao = [];
    var future = tipoProducaoDAO.listarTodos();
    tiposProducaoList = ObservableFuture<List<TipoProducao>>(future);
    return tiposProducao = await future;
  }

  @computed
  bool get hasResultsTiposProducao =>
      tiposProducaoList != emptyResponseTiposProducao &&
      tiposProducaoList.status == FutureStatus.fulfilled;

  static ObservableFuture<List<TipoProducao>> emptyResponseTiposProducao =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<TipoProducao>> tiposProducaoList =
      emptyResponseTiposProducao;
}
