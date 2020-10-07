import 'package:bucks/src/classes/item_estoque.dart';
import 'package:bucks/src/classes/producao.dart';
import 'package:bucks/src/pages/producao/producao_controller.dart';
import 'package:bucks/src/shared/utils/constants.dart';
import 'package:flutter/material.dart';

import 'base_dao.dart';

class ProducaoDAO extends BaseDAO<Producao> {
  @override
  Producao fromJson(Map<String, dynamic> map) {
    return Producao.fromJson(map);
  }

  @override
  ItemEstoque fromJsonItemEstoque(Map<String, dynamic> map) {
    return ItemEstoque.fromJson(map);
  }

  @override
  String get sqlComJoin =>
      'select pr.id, ' +
      'pr.descr, ' +
      'pr.vl_mo, '
          'pr.vl_custos_ind, ' +
      'pr.dt_producao_ini, ' +
      'pr.dt_producao_fim, ' +
      'pr.cd_status, ' +
      'pr.fk_producao_tipo_id, ' +
      'tp.descr         as fk_producao_tipo_descr ' +
      'from $table_name_producao pr ' +
      'INNER JOIN $table_name_tipo_producao tp ON tp.id = pr.fk_producao_tipo_id';

  @override
  String get tableName => 'producao';

  Future<List<Producao>> listarProducaoById({@required int id}) async {
    final dbClient = await db;
    final result = await dbClient
        .rawQuery('select * from $table_name_producao where id = ?', [id]);
    var list = result.map<Producao>((json) => Producao.fromJson(json)).toList();
    return list;
    // where not exists (select 1 from $table_name_transacao tra where tra.receituarioInstNum = rec.receituarioInstNum and tra.receituarioNum = rec.receituarioNum and tra.tpmovtoNum = 802)
  }

  @override
  String get orderByCols => null;

  Future<int> update(Producao producao) async {
    var dbClient = await db;
    String producaoDescr = producao.descr;
    return await dbClient.rawUpdate(
        "update $tableName set descr = $producaoDescr where id = ? ",
        [producao.id]);
  }

  verificaItemEstoque(int id, ProducaoController producaoController) async {
    final dbClient = await db;

    //List<Item> list2;
    //await consultar('select * from $tableName where id = ? ', null, [id]);
    final sql = 'select * from $table_name_item_estoque where fk_item_id = ?';
    final list = await dbClient.rawQuery(sql, [id]);

    if (list.length == 0) {
      producaoController.isItemEstoque = false;
    } else {
      producaoController.isItemEstoque = true;
    }
  }

  Future<List<ItemEstoque>> recuperaItemEstoqueById(int idItem) async {
    final dbClient = await db;

    final sql = 'select * from $table_name_item_estoque where fk_item_id = ? ';

    final result = await dbClient.rawQuery(sql, [idItem]);

    return result
        .map<ItemEstoque>((json) => fromJsonItemEstoque(json))
        .toList();
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
}
