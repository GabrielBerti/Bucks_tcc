import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/classes/movto_estoque.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_controller.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_list_controller.dart';
import 'package:bucks/src/pages/movto_estoque/movto_estoque_tipo/movto_estoque_tipo_controller.dart';
import 'package:bucks/src/shared/utils/constants.dart';
import 'package:sqflite/sqflite.dart';

import 'base_dao.dart';

class MovtoEstoqueDAO extends BaseDAO<MovtoEstoque> {
  @override
  MovtoEstoque fromJson(Map<String, dynamic> map) {
    return MovtoEstoque.fromJson(map);
  }

  @override
  ItemEstoque fromJsonItemEstoque(Map<String, dynamic> map) {
    return ItemEstoque.fromJson(map);
  }

  @override
  String get sqlComJoin =>
      'select mov.id, ' +
      'mov.dt, ' +
      'mov.qtd, ' +
      'mov.vl_unit, ' +
      'mov.qt_saldo_ant, ' +
      'mov.qt_saldo_pos, ' +
      'mov.vl_unit_ant, ' +
      'mov.vl_unit_pos, ' +
      'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
      'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
      'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
      'mov.fk_proditem_seq          as fk_proditem_seq, ' +
      'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
      'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
      'it.descr                     as fk_item_descr, ' +
      'it.descr                     as fk_prod_descr ' +
      'from $table_name_movto_estoque mov ' +
      'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
      'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
      ' where not exists(select 1 from $table_name_producao prod where prod.id = mov.fk_proditem_producao_id) ' +
      'union all ' +
      'select mov.id, ' +
      'mov.dt, ' +
      'mov.qtd, ' +
      'mov.vl_unit, ' +
      'mov.qt_saldo_ant, ' +
      'mov.qt_saldo_pos, ' +
      'mov.vl_unit_ant, ' +
      'mov.vl_unit_pos, ' +
      'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
      'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
      'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
      'mov.fk_proditem_seq          as fk_proditem_seq, ' +
      'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
      'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
      //'it.descr                     as fk_movto_estoque_tipo_descr, ' +
      //'it.descr                     as fk_movto_estoque_tipo_cd, ' +
      'it.descr                     as fk_item_descr, ' +
      'prod.descr                   as fk_prod_descr ' +
      'from $table_name_movto_estoque mov ' +
      'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
      'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
      'INNER JOIN $table_name_producao prod ON prod.id = mov.fk_proditem_producao_id';

  @override
  String get tableName => table_name_movto_estoque;

  @override
  String get orderByCols => null;

  verificaRelacionamentosMovtoEstoqueTipo(
      int id, MovtoEstoqueTipoController movtoEstoqueTipoController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql =
        'select * from $table_name_movto_estoque where fk_movto_estoque_tipo_id = ?';
    final list = await dbClient.rawQuery(sql, [id]);

    if (list.length == 0) {
      movtoEstoqueTipoController.possuiRelacao = false;
    } else {
      movtoEstoqueTipoController.possuiRelacao = true;
    }
  }

  verificaQtdEstoque(int idItem, double qtdPedida,
      MovtoEstoqueListController movtoEstoqueListController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql =
        'select * from $table_name_item_estoque where fk_item_id = ? and qt_saldo > ?';
    final list = await dbClient.rawQuery(sql, [idItem, qtdPedida]);

    if (list.length == 0) {
      movtoEstoqueListController.possuiQtdEstoque = false;
    } else {
      movtoEstoqueListController.possuiQtdEstoque = true;
    }
  }

  Future<int> updMovimentaEstoqueEntrada(
      double vlUnit, double qtd, int itemId) async {
    var dbClient = await db;

    return await dbClient.rawUpdate(
        "update $table_name_item_estoque set vl_unit = (((qt_saldo * ifnull(vl_unit,1)) + ($qtd * $vlUnit)) / (qt_saldo + $qtd)), qt_saldo = qt_saldo + $qtd where fk_item_id = ? ",
        [itemId]);
  }

  Future<int> updMovimentaEstoqueSaida(double qtd, int itemId) async {
    var dbClient = await db;

    return await dbClient.rawUpdate(
        "update $table_name_item_estoque set qt_saldo = qt_saldo - $qtd where fk_item_id = ? ",
        [itemId]);
  }

  Future<List<ItemEstoque>> recuperaItemEstoqueById(
      int idItem, MovtoEstoqueController movtoEstoqueController) async {
    final dbClient = await db;

    final sql = 'select * from $table_name_item_estoque where fk_item_id = ? ';

    final result = await dbClient.rawQuery(sql, [idItem]);

    return result
        .map<ItemEstoque>((json) => fromJsonItemEstoque(json))
        .toList();
  }

  Future<List<MovtoEstoque>> filtrarMovtos(
      {int idItem, String descrItem, String cdTipoMovto}) async {
    final dbClient = await db;
    var result;

    if ((idItem == 0) &&
        (descrItem == "" || descrItem.isEmpty) &&
        (cdTipoMovto == "" || cdTipoMovto.isEmpty)) {
      result = await dbClient.rawQuery(
          'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'it.descr                     as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              ' where not exists(select 1 from $table_name_producao prod where prod.id = mov.fk_proditem_producao_id) ' +
              'union all ' +
              'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              //'it.descr                     as fk_movto_estoque_tipo_descr, ' +
              //'it.descr                     as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'prod.descr                   as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              'INNER JOIN $table_name_producao prod ON prod.id = mov.fk_proditem_producao_id',
          []);
    } else if (idItem != 0 && descrItem != "" && cdTipoMovto != "") {
      result = await dbClient.rawQuery(
          'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'it.descr                     as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              ' where not exists(select 1 from $table_name_producao prod where prod.id = mov.fk_proditem_producao_id) ' +
              ' and it.id = $idItem ' +
              " and it.descr LIKE '%$descrItem%'" +
              " and movtp.cd_tipo_movto LIKE '%$cdTipoMovto%'" +
              'union all ' +
              'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              //'it.descr                     as fk_movto_estoque_tipo_descr, ' +
              //'it.descr                     as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'prod.descr                   as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              'INNER JOIN $table_name_producao prod ON prod.id = mov.fk_proditem_producao_id ' +
              ' where it.id = $idItem ' +
              " and it.descr LIKE '%$descrItem%'" +
              " and movtp.cd_tipo_movto LIKE '%$cdTipoMovto%'",
          []);
    } else if (idItem != 0 && descrItem == "" && cdTipoMovto == "") {
      result = await dbClient.rawQuery(
          'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'it.descr                     as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              ' where not exists(select 1 from $table_name_producao prod where prod.id = mov.fk_proditem_producao_id) ' +
              ' and it.id = $idItem ' +
              'union all ' +
              'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              //'it.descr                     as fk_movto_estoque_tipo_descr, ' +
              //'it.descr                     as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'prod.descr                   as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              'INNER JOIN $table_name_producao prod ON prod.id = mov.fk_proditem_producao_id ' +
              ' where it.id = $idItem',
          []);
    } else if (idItem != 0 && descrItem != "" && cdTipoMovto == "") {
      result = await dbClient.rawQuery(
          'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'it.descr                     as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              ' where not exists(select 1 from $table_name_producao prod where prod.id = mov.fk_proditem_producao_id) ' +
              ' and it.id = $idItem ' +
              " and it.descr LIKE '%$descrItem%'" +
              'union all ' +
              'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              //'it.descr                     as fk_movto_estoque_tipo_descr, ' +
              //'it.descr                     as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'prod.descr                   as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              ' INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              'INNER JOIN $table_name_producao prod ON prod.id = mov.fk_proditem_producao_id' +
              ' where it.id = $idItem ' +
              " and it.descr LIKE '%$descrItem%'",
          []);
    } else if (idItem != 0 && descrItem == "" && cdTipoMovto != "") {
      result = await dbClient.rawQuery(
          'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'it.descr                     as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              ' where not exists(select 1 from $table_name_producao prod where prod.id = mov.fk_proditem_producao_id) ' +
              ' and it.id = $idItem ' +
              " and movtp.cd_tipo_movto LIKE '%$cdTipoMovto%'" +
              'union all ' +
              'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              //'it.descr                     as fk_movto_estoque_tipo_descr, ' +
              //'it.descr                     as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'prod.descr                   as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              'INNER JOIN $table_name_producao prod ON prod.id = mov.fk_proditem_producao_id ' +
              ' where it.id = $idItem ' +
              " and movtp.cd_tipo_movto LIKE '%$cdTipoMovto%'",
          []);
    } else if (idItem == 0 && descrItem != "" && cdTipoMovto != "") {
      result = await dbClient.rawQuery(
          'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'it.descr                     as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              ' where not exists(select 1 from $table_name_producao prod where prod.id = mov.fk_proditem_producao_id) ' +
              " and it.descr LIKE '%$descrItem%'" +
              " and movtp.cd_tipo_movto LIKE '%$cdTipoMovto%'" +
              'union all ' +
              'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              //'it.descr                     as fk_movto_estoque_tipo_descr, ' +
              //'it.descr                     as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'prod.descr                   as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              'INNER JOIN $table_name_producao prod ON prod.id = mov.fk_proditem_producao_id ' +
              " where it.descr LIKE '%$descrItem%'" +
              " and movtp.cd_tipo_movto LIKE '%$cdTipoMovto%'",
          []);
    } else if (idItem == 0 && descrItem != "" && cdTipoMovto == "") {
      result = await dbClient.rawQuery(
          'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'it.descr                     as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              ' where not exists(select 1 from $table_name_producao prod where prod.id = mov.fk_proditem_producao_id) ' +
              " and it.descr LIKE '%$descrItem%'" +
              'union all ' +
              'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              //'it.descr                     as fk_movto_estoque_tipo_descr, ' +
              //'it.descr                     as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'prod.descr                   as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              'INNER JOIN $table_name_producao prod ON prod.id = mov.fk_proditem_producao_id ' +
              " where it.descr LIKE '%$descrItem%'",
          []);
    } else if (idItem == 0 && descrItem == "" && cdTipoMovto != "") {
      result = await dbClient.rawQuery(
          'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'it.descr                     as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              ' where not exists(select 1 from $table_name_producao prod where prod.id = mov.fk_proditem_producao_id) ' +
              " and movtp.cd_tipo_movto LIKE '%$cdTipoMovto%'" +
              'union all ' +
              'select mov.id, ' +
              'mov.dt, ' +
              'mov.qtd, ' +
              'mov.vl_unit, ' +
              'mov.qt_saldo_ant, ' +
              'mov.qt_saldo_pos, ' +
              'mov.vl_unit_ant, ' +
              'mov.vl_unit_pos, ' +
              'mov.fk_item_estoque_item_id  as fk_item_estoque_item_id, ' +
              'mov.fk_movto_estoque_tipo_id as fk_movto_estoque_tipo_id, ' +
              'mov.fk_proditem_producao_id  as fk_proditem_producao_id, ' +
              'mov.fk_proditem_seq          as fk_proditem_seq, ' +
              'movtp.descr                  as fk_movto_estoque_tipo_descr, ' +
              'movtp.cd_tipo_movto          as fk_movto_estoque_tipo_cd, ' +
              //'it.descr                     as fk_movto_estoque_tipo_descr, ' +
              //'it.descr                     as fk_movto_estoque_tipo_cd, ' +
              'it.descr                     as fk_item_descr, ' +
              'prod.descr                   as fk_prod_descr ' +
              'from $table_name_movto_estoque mov ' +
              'INNER JOIN $table_name_movto_estoque_tipo movtp ON movtp.id = mov.fk_movto_estoque_tipo_id ' +
              'INNER JOIN $table_name_item it ON it.id = mov.fk_item_estoque_item_id ' +
              'INNER JOIN $table_name_producao prod ON prod.id = mov.fk_proditem_producao_id ' +
              " and movtp.cd_tipo_movto LIKE '%$cdTipoMovto%'",
          []);
    }

    var list = result
        .map<MovtoEstoque>((json) => MovtoEstoque.fromJson(json))
        .toList();
    return list;
  }
}

//saida no estoque
//SALDO VL_UNIT   total
//26    5.86      152.3
//16    5.86      93,76

//entrada no estoque
//SALDO VL_UNIT
//24      6.18
//2       2
//(24 * 6.18) + (2 * 2) / 24 + 2
//26     3,83

//SALDO VL_UNIT
//6      5
//4      4
//(6 * 5) + (4 * 4) / 5 + 4
//9     4.6
