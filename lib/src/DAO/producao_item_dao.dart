import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/classes/producao_item.dart';
import 'package:bucks/src/pages/producao/producao_list/producao_list_controller.dart';
import 'package:bucks/src/shared/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';

class ProducaoItemDAO extends BaseDAO<ProducaoItem> {
  @override
  ProducaoItem fromJson(Map<String, dynamic> map) {
    return ProducaoItem.fromJson(map);
  }

  @override
  String get sqlComJoin =>
      'select pi.seq, ' +
      'pi.qt, ' +
      'pi.vl_unit, ' +
      'pi.cd_tipo, ' +
      'pi.cd_status, ' +
      'pi.fk_producao_id, ' +
      'pi.fk_item_id, ' +
      'it.descr       as descrItem, ' +
      'prod.descr     as descrProducao ' +
      'from $table_name_producao_item pi ' +
      'INNER JOIN $table_name_item it ON it.id = pi.fk_item_id ' +
      'INNER JOIN $table_name_producao prod ON prod.id = pi.fk_producao_id';

  @override
  String get tableName => 'producao_item';

  Future<List<ProducaoItem>> listarProducaoItemDaProducao(
      Producao producao) async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select pi.seq ' +
        ' ,pi.fk_producao_id ' +
        ' ,pi.fk_item_id ' +
        ' ,it.descr            as descrItem ' +
        ' ,pr.descr            as descrProducao ' +
        ' ,pi.qt ' +
        ' ,pi.vl_unit ' +
        ' ,pi.cd_tipo ' +
        ' ,pi.cd_status ' +
        'from $table_name_producao_item pi ' +
        ' INNER JOIN $table_name_producao pr ON pr.id = pi.fk_producao_id ' +
        ' INNER JOIN $table_name_item it ON it.id = pi.fk_item_id ' +
        ' where pr.id =  ifnull(${producao.id},0)' +
        ' order by pi.seq');

    var list = result
        .map<ProducaoItem>((json) => ProducaoItem.fromJson(json))
        .toList();
    return list;
  }

  Future<List<ProducaoItem>> listarProducaoItem2() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery(
        'select pi.seq, pr.id, pr.descr as descrItem, it.id, it.descr as descrProducao ' +
            ', pi.qt, pi.vl_unit, pi.cd_tipo, pi.cd_status ' +
            'from $table_name_producao_item pi INNER JOIN $table_name_producao pr ON pr.id = pi.fk_producao_id ' +
            'INNER JOIN $table_name_item it ON it.id = pi.fk_item_id' +
            'INNER JOIN $table_name_item_estoque ie ON ie.fk_item_id = it.id');

    final result2 = await dbClient.rawQuery(
        'select pi.seq, pr.id, pr.descr as descrItem, it.id, it.descr as descrProducao, ' +
            ', pi.qt, pi.vl_unit, pi.cd_tipo, pi.cd_status ' +
            'from $table_name_producao_item pi INNER JOIN $table_name_producao pr ON pr.id = pi.fk_producao_id ' +
            'INNER JOIN $table_name_item it ON it.id = pi.fk_item_id');

    if (result.length > 0) {
      var list = result
          .map<ProducaoItem>((json) => ProducaoItem.fromJson(json))
          .toList();
      return list;
    } else {
      var list = result2
          .map<ProducaoItem>((json) => ProducaoItem.fromJson(json))
          .toList();
      return list;
    }
  }

  Future<int> deletarProducaoItem(
      int seq, int fkProducaoId, int fkItemId) async {
    var dbClient = await db;

    return await dbClient.rawDelete(
        "delete from $table_name_producao_item " +
            "where seq = ? and fk_producao_id = ? and fk_item_id = ?",
        [seq, fkProducaoId, fkItemId]);
  }

  verificaQtdEstoque(int idItem, double qtdPedida,
      ProducaoListController producaoListController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql =
        'select * from $table_name_item_estoque where fk_item_id = ? and qt_saldo > ?';
    final list = await dbClient.rawQuery(sql, [idItem, qtdPedida]);

    if (list.length == 0) {
      producaoListController.possuiQtdEstoque = false;
    } else {
      producaoListController.possuiQtdEstoque = true;
    }
  }

  updProdItemBaixado(
      String cdStatus, int producaoId, int producaoSeq, int itemId) async {
    var dbClient = await db;

    return await dbClient.rawUpdate(
        "update $table_name_producao_item set cd_status = ? where fk_producao_id = ? and seq = ? and fk_item_id = ? ",
        [cdStatus, producaoId, producaoSeq, itemId]);
  }

  Future<int> updMovimentaEstoqueSaida(
      double vlUnit, double qtd, int itemId) async {
    var dbClient = await db;

    return await dbClient.rawUpdate(
        "update $table_name_item_estoque set vl_unit = (((qt_saldo * ifnull(vl_unit,1)) + ($qtd * $vlUnit)) / (qt_saldo + $qtd)), qt_saldo = qt_saldo - $qtd where fk_item_id = ? ",
        [itemId]);
  }

  Future<int> updMovimentaEstoqueEntrada(
      double vlUnit, double qtd, int itemId) async {
    var dbClient = await db;

    return await dbClient.rawUpdate(
        "update $table_name_item_estoque set vl_unit = (((qt_saldo * ifnull(vl_unit,1)) + ($qtd * $vlUnit)) / (qt_saldo + $qtd)), qt_saldo = qt_saldo + $qtd where fk_item_id = ? ",
        [itemId]);
  }

  @override
  String get orderByCols => null;
}
