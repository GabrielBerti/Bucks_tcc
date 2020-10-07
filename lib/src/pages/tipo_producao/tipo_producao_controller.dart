import 'package:bucks/src/DAO/tipo_producao_dao.dart';
import 'package:bucks/src/classes/tipo_producao.dart';
import 'package:bucks/src/pages/tipo_producao/tipo_producao_list/tipo_producao_list_controller.dart';
import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';

part 'tipo_producao_controller.g.dart';

class TipoProducaoController = _TipoProducaoControllerBase
    with _$TipoProducaoController;

abstract class _TipoProducaoControllerBase with Store {
  TipoProducaoDAO tipoProducaoDAO;
  bool possuiRelacao;

  @observable
  TextEditingController id = TextEditingController();

  @observable
  TextEditingController descr = TextEditingController();

  _TipoProducaoControllerBase() {
    tipoProducaoDAO = tipoProducaoDAO ?? TipoProducaoDAO();
  }

  @action
  salvarTipoProducao(
      {@required TipoProducaoController store,
      @required TipoProducaoListController storeTipoProducaoList}) async {
    TipoProducao tipoProducao = TipoProducao();
    if (store.id.text != "") {
      tipoProducao.id = int.parse(store.id.text);
    }

    tipoProducao.descr = store.descr.text;
    print('itemTipo.descr: $tipoProducao.descr');
    await tipoProducaoDAO.salvar(tipoProducao);

    await storeTipoProducaoList.listarTiposProducao();
  }

  @action
  deletarTipoProducao({
    TipoProducao tipoProducao,
  }) {
    //await itemGrupoDAO.salvar(itemGrupo);
    tipoProducaoDAO.deletar(tipoProducao.id);
    //await storeItemGrupoList.listarItensGrupo();
  }

  verificaRelacionamentosTipoProducao(
      {TipoProducao tipoProducao,
      TipoProducaoController tipoProducaoController}) async {
    TipoProducaoDAO tipoProducaoDAO = TipoProducaoDAO();
    await tipoProducaoDAO.verificaRelacionamentosProducao(
        tipoProducao.id, tipoProducaoController);

    //await storeItemGrupoList.listarItensGrupo();
  }
}
