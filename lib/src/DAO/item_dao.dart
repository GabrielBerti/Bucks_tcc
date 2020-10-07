import 'package:bucks/src/classes/item.dart';
import 'package:bucks/src/pages/item/item_controller.dart';
import 'package:bucks/src/pages/item_grupo/item_grupo_controller.dart';
import 'package:bucks/src/pages/item_tipo/item_tipo_controller.dart';
import 'package:bucks/src/pages/item_unmed/item_unmed_controller.dart';
import 'package:bucks/src/shared/utils/constants.dart';

import 'base_dao.dart';

class ItemDAO extends BaseDAO<Item> {
  @override
  String get tableName => table_name_item;

  @override
  Item fromJson(Map<String, dynamic> map) {
    return Item.fromJson(map);
  }

  @override
  String get sqlComJoin =>
      'select it.id, ' +
      'it.descr, ' +
      'it.cd, ' +
      'it.qtd_min_estoque, ' +
      'it.cdControlaEstoque, ' +
      'it.fk_item_tipo_id as fk_item_tipo_id, ' +
      'it.fk_item_grupo_id as fk_item_grupo_id, ' +
      'it.fk_item_unmed_id as fk_item_unmed_id ' +
      ' , itp.descr as fk_item_tipo_descr ' +
      ' , ig.descr as fk_item_grupo_descr ' +
      ' , iu.descr as fk_item_unmed_descr ' +
      'from $table_name_item it ' +
      'INNER JOIN $table_name_item_tipo itp ON itp.id = it.fk_item_tipo_id ' +
      'INNER JOIN $table_name_item_grupo ig ON ig.id = it.fk_item_grupo_id ' +
      'INNER JOIN $table_name_item_unmed iu ON iu.id = it.fk_item_unmed_id';

  @override
  String get orderByCols => null;

  Future<List<Item>> listarItensSemEstoque() async {
    final dbClient = await db;

    String sql = 'select it.id, ' +
        'it.descr, ' +
        'it.qtd_min_estoque, ' +
        'it.cd, ' +
        'it.cdControlaEstoque, ' +
        'it.fk_item_tipo_id as fk_item_tipo_id, ' +
        'it.fk_item_grupo_id as fk_item_grupo_id, ' +
        'it.fk_item_unmed_id as fk_item_unmed_id ' +
        ' , itp.descr as fk_item_tipo_descr ' +
        ' , ig.descr as fk_item_grupo_descr ' +
        ' , iu.descr as fk_item_unmed_descr ' +
        'from $table_name_item it ' +
        'INNER JOIN $table_name_item_tipo itp ON itp.id = it.fk_item_tipo_id ' +
        'INNER JOIN $table_name_item_grupo ig ON ig.id = it.fk_item_grupo_id ' +
        'INNER JOIN $table_name_item_unmed iu ON iu.id = it.fk_item_unmed_id ' +
        ' where not exists(select 1 from $table_name_item_estoque ie where ie.fk_item_id = it.id) ';

    final list = await dbClient.rawQuery(sql);
    return list.map<Item>((json) => fromJson(json)).toList();
  }

  verificaRelacionamentosItemGrupo(
      int id, ItemGrupoController itemGrupoController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql = 'select * from $table_name_item where fk_item_grupo_id = ?';
    final list = await dbClient.rawQuery(sql, [id]);

    if (list.length == 0) {
      itemGrupoController.possuiRelacao = false;
    } else {
      itemGrupoController.possuiRelacao = true;
    }
  }

  verificaRelacionamentosItemTipo(
      int id, ItemTipoController itemTipoController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql = 'select * from $table_name_item where fk_item_tipo_id = ?';
    final list = await dbClient.rawQuery(sql, [id]);

    if (list.length == 0) {
      itemTipoController.possuiRelacao = false;
    } else {
      itemTipoController.possuiRelacao = true;
    }
  }

  verificaRelacionamentosItemUnmed(
      String id, ItemUnmedController itemUnmedController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql = 'select * from $table_name_item where fk_item_unmed_id = ?';
    final list = await dbClient.rawQuery(sql, [id]);

    if (list.length == 0) {
      itemUnmedController.possuiRelacao = false;
    } else {
      itemUnmedController.possuiRelacao = true;
    }
  }

  verificaRelacionamentosItemEstoque(
      int id, ItemController itemController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql = 'select * from $table_name_item_estoque where fk_item_id = ?';
    final list = await dbClient.rawQuery(sql, [id]);

    if (list.length == 0) {
      itemController.possuiRelacaoItemEstoque = false;
    } else {
      itemController.possuiRelacaoItemEstoque = true;
    }
  }

  verificaRelacionamentosMovtoEstoque(
      int id, ItemController itemController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql =
        'select * from $table_name_movto_estoque where fk_item_estoque_item_id = ?';
    final list = await dbClient.rawQuery(sql, [id]);

    if (list.length == 0) {
      itemController.possuiRelacaoMovtoEstoque = false;
    } else {
      itemController.possuiRelacaoMovtoEstoque = true;
    }
  }

  verificaRelacionamentosProdItem(int id, ItemController itemController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql = 'select * from $table_name_producao_item where fk_item_id = ?';
    final list = await dbClient.rawQuery(sql, [id]);

    if (list.length == 0) {
      itemController.possuiRelacaoProdItem = false;
    } else {
      itemController.possuiRelacaoProdItem = true;
    }
  }

  Future<List<Item>> retornaItemById(int itemId) async {
    final dbClient = await db;
    String sql = 'select * from $table_name_item where id = ?';
    final list = await dbClient.rawQuery(sql, [itemId]);

    return list.map<Item>((json) => fromJson(json)).toList();
  }
}
