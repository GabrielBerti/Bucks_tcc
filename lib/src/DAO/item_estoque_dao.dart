import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/pages/item_estoque/item_estoque_list_controller.dart';
import 'package:bucks/src/shared/utils/constants.dart';

import 'base_dao.dart';

class ItemEstoqueDAO extends BaseDAO<ItemEstoque> {
  @override
  String get tableName => table_name_item_estoque;

  @override
  ItemEstoque fromJson(Map<String, dynamic> map) {
    return ItemEstoque.fromJson(map);
  }

  @override
  String get sqlComJoin =>
      'select i.id      as fk_item_id ' +
      ' , i.descr       as fk_item_descr ' +
      ' , gr.id     as fk_item_grupo_id ' +
      ' , gr.descr  as fk_item_grupo_descr ' +
      ' , un.id         as fk_item_unmed_id ' +
      ' , un.descr      as fk_item_unmed_descr ' +
      ' , tp.id     as fk_item_tipo_id ' +
      ' , tp.descr  as fk_item_tipo_descr ' +
      ' , ie.qt_saldo' +
      ' , ie.vl_unit' +
      //' , ie.qt_reservado'
      ' from $table_name_item i ' +
      ' , $table_name_item_grupo gr ' +
      ' , $table_name_item_unmed un ' +
      ' , $table_name_item_tipo  tp ' +
      ' , $table_name_item_estoque ie ' +
      'where ie.fk_item_id   = i.id ' +
      ' and i.fk_item_unmed_id  = un.id ' +
      '  and i.fk_item_grupo_id = gr.id ' +
      '  and i.fk_item_tipo_id  = tp.id ';

  // passar a PK - se for composta tem que implementar as colunas
  Future<ItemEstoque> findPorPkk(int fkItemId) async {
    final dbClient = await db;
    final list = await dbClient.rawQuery(
        "select * from $tableName " + "where fk_item_id = ? ", [fkItemId]);
    if (list.length > 0) {
      return fromJson(list.first);
    }
    return null;
  }

  Future<List<ItemEstoque>> lovItemEstoque() async {
    return await super.consultar(null, ' ie.qt_saldo != -1000 ', []);
  }

  // Future<List<ItemEstoque>> listarItemEstoque() async {
  //   final dbClient = await db;
  //   final result = await dbClient.rawQuery(
  //       //await dbClient.rawQuery('select  * from $table_name_item_estoque');
  //       'select ie.fk_item_id, ie.lote, ie.qt_saldo, ie.vl_unit, ie.qt_reservado, it.descr as descrItem from $table_name_item_estoque ie INNER JOIN $table_name_item it ON it.id = ie.fk_item_id');
  //   var list =
  //       result.map<ItemEstoque>((json) => ItemEstoque.fromJson(json)).toList();
  //   return list;
  // }

  // Future<List<ItemEstoque>> findPorItem(int itemId) async {
  //   final dbClient = await db;
  //   final list = await dbClient.rawQuery("select * from $tableName where id = ? ", [id]);
  //   return list.map<T>((json) => fromJson(json)).toList();
  // }
  @override
  String get orderByCols => null;

  Future<int> deletarItemEstoque(int itemId) async {
    var dbClient = await db;
    return await dbClient.rawDelete(
        "delete from $table_name_item_estoque " + "where fk_item_id = ?",
        [itemId]);
  }

  verificaRelacionamentosMovtoEstoque(
      int itemId, ItemEstoqueListController itemEstoqueListController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);

    final sql =
        'select * from $table_name_movto_estoque where fk_item_estoque_item_id = ?';
    final list = await dbClient.rawQuery(sql, [itemId]);

    if (list.length == 0) {
      itemEstoqueListController.possuiRelacao = false;
    } else {
      itemEstoqueListController.possuiRelacao = true;
    }
  }

  Future<List<ItemEstoque>> retornaItemById(int itemId) async {
    final dbClient = await db;
    String sql = 'select * from $table_name_item_estoque where fk_item_id = ?';
    final list = await dbClient.rawQuery(sql, [itemId]);

    return list.map<ItemEstoque>((json) => fromJson(json)).toList();
  }

  Future<List<ItemEstoque>> filtrarItensEstoque(
      {int idItem, String descrItem}) async {
    final dbClient = await db;
    var result;
    if ((idItem == 0) && (descrItem == "" || descrItem.isEmpty)) {
      result = await dbClient.rawQuery(
          'select i.id      as fk_item_id ' +
              ' , i.descr       as fk_item_descr ' +
              ' , gr.id     as fk_item_grupo_id ' +
              ' , gr.descr  as fk_item_grupo_descr ' +
              ' , un.id         as fk_item_unmed_id ' +
              ' , un.descr      as fk_item_unmed_descr ' +
              ' , tp.id     as fk_item_tipo_id ' +
              ' , tp.descr  as fk_item_tipo_descr ' +
              ' , ie.qt_saldo' +
              ' , ie.vl_unit' +
              //' , ie.qt_reservado'
              ' from $table_name_item i ' +
              ' , $table_name_item_grupo gr ' +
              ' , $table_name_item_unmed un ' +
              ' , $table_name_item_tipo  tp ' +
              ' , $table_name_item_estoque ie ' +
              'where ie.fk_item_id   = i.id ' +
              ' and i.fk_item_unmed_id  = un.id ' +
              '  and i.fk_item_grupo_id = gr.id ' +
              '  and i.fk_item_tipo_id  = tp.id ',
          []);
    } else if (idItem != 0 && descrItem != "") {
      result = await dbClient.rawQuery(
          'select i.id      as fk_item_id ' +
              ' , i.descr       as fk_item_descr ' +
              ' , gr.id     as fk_item_grupo_id ' +
              ' , gr.descr  as fk_item_grupo_descr ' +
              ' , un.id         as fk_item_unmed_id ' +
              ' , un.descr      as fk_item_unmed_descr ' +
              ' , tp.id     as fk_item_tipo_id ' +
              ' , tp.descr  as fk_item_tipo_descr ' +
              ' , ie.qt_saldo' +
              ' , ie.vl_unit' +
              //' , ie.qt_reservado'
              ' from $table_name_item i ' +
              ' , $table_name_item_grupo gr ' +
              ' , $table_name_item_unmed un ' +
              ' , $table_name_item_tipo  tp ' +
              ' , $table_name_item_estoque ie ' +
              'where ie.fk_item_id   = i.id ' +
              ' and i.fk_item_unmed_id  = un.id ' +
              '  and i.fk_item_grupo_id = gr.id ' +
              '  and i.fk_item_tipo_id  = tp.id '
                  ' and i.id = $idItem ' +
              " and i.descr LIKE '%$descrItem%'",
          []);
    } else if (idItem != 0 && descrItem == "") {
      result = await dbClient.rawQuery(
          'select i.id      as fk_item_id ' +
              ' , i.descr       as fk_item_descr ' +
              ' , gr.id     as fk_item_grupo_id ' +
              ' , gr.descr  as fk_item_grupo_descr ' +
              ' , un.id         as fk_item_unmed_id ' +
              ' , un.descr      as fk_item_unmed_descr ' +
              ' , tp.id     as fk_item_tipo_id ' +
              ' , tp.descr  as fk_item_tipo_descr ' +
              ' , ie.qt_saldo' +
              ' , ie.vl_unit' +
              //' , ie.qt_reservado'
              ' from $table_name_item i ' +
              ' , $table_name_item_grupo gr ' +
              ' , $table_name_item_unmed un ' +
              ' , $table_name_item_tipo  tp ' +
              ' , $table_name_item_estoque ie ' +
              'where ie.fk_item_id   = i.id ' +
              ' and i.fk_item_unmed_id  = un.id ' +
              '  and i.fk_item_grupo_id = gr.id ' +
              '  and i.fk_item_tipo_id  = tp.id '
                  ' and i.id = $idItem ',
          []);
    } else if (idItem == 0 && descrItem != "") {
      result = await dbClient.rawQuery(
          'select i.id      as fk_item_id ' +
              ' , i.descr       as fk_item_descr ' +
              ' , gr.id     as fk_item_grupo_id ' +
              ' , gr.descr  as fk_item_grupo_descr ' +
              ' , un.id         as fk_item_unmed_id ' +
              ' , un.descr      as fk_item_unmed_descr ' +
              ' , tp.id     as fk_item_tipo_id ' +
              ' , tp.descr  as fk_item_tipo_descr ' +
              ' , ie.qt_saldo' +
              ' , ie.vl_unit' +
              //' , ie.qt_reservado'
              ' from $table_name_item i ' +
              ' , $table_name_item_grupo gr ' +
              ' , $table_name_item_unmed un ' +
              ' , $table_name_item_tipo  tp ' +
              ' , $table_name_item_estoque ie ' +
              'where ie.fk_item_id   = i.id ' +
              ' and i.fk_item_unmed_id  = un.id ' +
              '  and i.fk_item_grupo_id = gr.id ' +
              '  and i.fk_item_tipo_id  = tp.id '
                  " and i.descr LIKE '%$descrItem%'",
          []);
    }

    var list =
        result.map<ItemEstoque>((json) => ItemEstoque.fromJson(json)).toList();
    return list;
  }
}
