import 'package:bucks/src/classes/item_grupo.dart';
import 'package:bucks/src/classes/item_tipo.dart';
import 'package:bucks/src/pages/item/item_list/item_list_controller.dart';
import 'package:bucks/src/shared/utils/constants.dart';

import 'base_dao.dart';

class ItemTipoDAO extends BaseDAO<ItemTipo> {
  @override
  ItemTipo fromJson(Map<String, dynamic> map) {
    return ItemTipo.fromJson(map);
  }

  @override
  String get sqlComJoin => null;

  @override
  String get tableName => table_name_item_tipo;

  Future<String> listarDescrItemTipo() async {
    final dbClient = await db;

    final sql = 'select descr from $table_name_item_tipo where id = ?';

    final result = await dbClient.rawQuery(sql, [1]);

    print(result);

    return result.toString();
  }

  Future<List<ItemTipo>> recuperaItemTipoById(int idItem) async {
    final dbClient = await db;

    final sql = 'select it.id, it.descr from $table_name_item_tipo it ' +
        'INNER JOIN $table_name_item item ON item.fk_item_tipo_id = it.id and item.id = ? ';

    final result = await dbClient.rawQuery(sql, [idItem]);

    return result.map<ItemTipo>((json) => fromJson(json)).toList();
  }

  @override
  String get orderByCols => null;
}
