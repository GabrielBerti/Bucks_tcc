import 'package:bucks/src/classes/item_tipo.dart';
import 'package:bucks/src/classes/tipo_producao.dart';
import 'package:bucks/src/pages/tipo_producao/tipo_producao_controller.dart';
import 'package:bucks/src/shared/utils/constants.dart';

import 'base_dao.dart';

class TipoProducaoDAO extends BaseDAO<TipoProducao> {
  @override
  TipoProducao fromJson(Map<String, dynamic> map) {
    return TipoProducao.fromJson(map);
  }

  @override
  String get sqlComJoin => null;

  @override
  String get tableName => table_name_tipo_producao;

  Future<String> listarDescrTipoProducao() async {
    final dbClient = await db;

    final sql = 'select descr from $table_name_tipo_producao where id = ?';

    final result = await dbClient.rawQuery(sql, [1]);

    print(result);

    return result.toString();
  }

  verificaRelacionamentosProducao(
      int id, TipoProducaoController tipoProducaoController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql =
        'select * from $table_name_producao where fk_producao_tipo_id = ?';
    final list = await dbClient.rawQuery(sql, [id]);

    if (list.length == 0) {
      tipoProducaoController.possuiRelacao = false;
    } else {
      tipoProducaoController.possuiRelacao = true;
    }
  }

  Future<List<TipoProducao>> recuperaTipoProdById(int idProd) async {
    final dbClient = await db;

    final sql = 'select tp.id, tp.descr from $table_name_tipo_producao tp ' +
        'INNER JOIN $table_name_producao pr ON pr.fk_producao_tipo_id = tp.id and pr.id = ? ';

    final result = await dbClient.rawQuery(sql, [idProd]);

    return result.map<TipoProducao>((json) => fromJson(json)).toList();
  }

  @override
  String get orderByCols => null;
}
