import 'package:bucks/src/DAO/cg_ref_codes_dao.dart';
import 'package:bucks/src/classes/cg_ref_codes.dart';
import 'package:mobx/mobx.dart';

part 'cg_ref_codes_list_controller.g.dart';

class CgRefCodesListController = _CgRefCodesListControllerBase
    with _$CgRefCodesListController;

abstract class _CgRefCodesListControllerBase with Store {
  CgRefCodesDAO cgRefCodesDAO;

  @observable
  List<CgRefCodes> regList = [];

  _CgRefCodesListControllerBase() {
    cgRefCodesDAO = cgRefCodesDAO ?? CgRefCodesDAO();
  }

  void init() async {
    await listar();
  }

  @action
  Future<List<CgRefCodes>> listar() async {
    var qtdLinhas = await cgRefCodesDAO.count();
    print('qtdLinhas => $qtdLinhas');
    regList = [];
    var future = cgRefCodesDAO.listarTodos();
    regListObs = ObservableFuture<List<CgRefCodes>>(future);
    return regList = await future;
  }

  @computed
  bool get hasResultsCgRefCodes =>
      regListObs != emptyResponseCgRefCodes &&
      regListObs.status == FutureStatus.fulfilled;

  static ObservableFuture<List<CgRefCodes>> emptyResponseCgRefCodes =
      ObservableFuture.value([]);

  @observable
  ObservableFuture<List<CgRefCodes>> regListObs = emptyResponseCgRefCodes;
}
