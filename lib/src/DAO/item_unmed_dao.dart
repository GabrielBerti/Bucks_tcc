import 'package:bucks/src/classes/item_unmed.dart';
import 'package:bucks/src/shared/utils/constants.dart';

import 'base_dao.dart';

class ItemUnmedDAO extends BaseDAO<ItemUnmed> {
  @override
  ItemUnmed fromJson(Map<String, dynamic> map) {
    return ItemUnmed.fromJson(map);
  }

  @override
  String get sqlComJoin => null;

  @override
  String get tableName => table_name_item_unmed;

  @override
  String get orderByCols => null;

  Future<List<ItemUnmed>> recuperaItemUnMedById(int idItem) async {
    final dbClient = await db;

    final sql = 'select iu.id, iu.descr from $table_name_item_unmed iu ' +
        'INNER JOIN $table_name_item item ON item.fk_item_unmed_id = iu.id and item.id = ? ';

    final result = await dbClient.rawQuery(sql, [idItem]);

    return result.map<ItemUnmed>((json) => fromJson(json)).toList();
  }
}
