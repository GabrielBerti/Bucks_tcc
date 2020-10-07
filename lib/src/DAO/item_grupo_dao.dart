import 'package:bucks/src/classes/item_grupo.dart';
import 'package:bucks/src/shared/utils/constants.dart';

import 'base_dao.dart';

class ItemGrupoDAO extends BaseDAO<ItemGrupo> {
  @override
  ItemGrupo fromJson(Map<String, dynamic> map) {
    return ItemGrupo.fromJson(map);
  }

  @override
  String get sqlComJoin => null;

  @override
  String get tableName => table_name_item_grupo;

  @override
  String get orderByCols => null;

  Future<List<ItemGrupo>> recuperaItemGrupoById(int idItem) async {
    final dbClient = await db;

    final sql = 'select ig.id, ig.descr from $table_name_item_grupo ig ' +
        'INNER JOIN $table_name_item item ON item.fk_item_grupo_id = ig.id and item.id = ? ';

    final result = await dbClient.rawQuery(sql, [idItem]);

    return result.map<ItemGrupo>((json) => fromJson(json)).toList();
  }

  /*Future<List<ItemGrupo>> listarProducaoItemDaProducao( 
      Producao producao) async {
    final dbClient = await db;
    final result = await dbClient.rawQuery(
        'select pi.seq, pi.fk_producao_id, pi.fk_item_id, it.descr as descrItem, pr.descr as descrProducao' +
            ', pi.qt, pi.vl_unit, pi.cd_tipo, pi.cd_status ' +
            'from $table_name_producao_item pi INNER JOIN $table_name_producao pr ON pr.id = pi.fk_producao_id ' +
            'INNER JOIN $table_name_item it ON it.id = pi.fk_item_id ' +
            'where pr.id =  ifnull(${producao.id},0)' +
            'order by pi.cd_tipo');

    var list = result
        .map<ProducaoItem>((json) => ProducaoItem.fromJson(json))
        .toList();
    return list;
  }*/
}
