import 'package:bucks/src/classes/entity_base.dart';
import 'package:bucks/src/repository/bucks_db_repository.dart';
import 'package:sqflite/sqflite.dart';

abstract class BaseDAO<T extends EntityBase> {
  Future<Database> get db => BucksDBRepository.getInstance().db;

  String get tableName;

  String get sqlComJoin;
  String get orderByCols;
  String _sql;
  T fromJson(Map<String, dynamic> map);

  Future<int> salvar(T entity) async {
    var dbClient = await db;
    var id = await dbClient.insert(tableName, entity.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    print("id: $id");
    return id;
  }

  // passar a PK - se for composta tem que implementar as colunas
  Future<int> deletar(int id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete("delete from $tableName " + "where id = ? ", [id]);
  }

  Future<int> deletarIdString(String id) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete("delete from $tableName " + "where id = ? ", [id]);
  }

  // passar a PK - se for composta tem que implementar as colunas
  Future<int> deletarTodos() async {
    var dbClient = await db;
    return await dbClient.rawDelete("delete from $tableName ");
  }

  Future<List<T>> consultar(
      String pSql, // passar o sql com where
      String
          pSomenteWhere, // passar apenas where, utilizando ou nao o sqlComJoin
      [List<dynamic> arguments]) async {
    final dbClient = await db;

    _sql = pSql;

    if (_sql == null) {
      _sql = sqlComJoin;
    }

    if (pSomenteWhere != null) {
      _sql = _sql + ' and ' + pSomenteWhere;
    }

    if (orderByCols != null) {
      _sql = _sql + ' order by $orderByCols ';
    }
    final list = await dbClient.rawQuery(_sql, arguments);
    return list.map<T>((json) => fromJson(json)).toList();
  }

  Future<List<T>> listarTodos() async {
    if (sqlComJoin != null)
      return consultar('$sqlComJoin', null);
    else
      return consultar('select * from $tableName', null);
  }

  // passar a PK - se for composta tem que implementar as colunas
  Future<T> consultarPorPk(int id) async {
    List<T> list =
        await consultar('select * from $tableName where id = ? ', null, [id]);
    return list.length > 0 ? list.first : null;
  }

  Future<bool> exists(int id) async {
    T reg = await consultarPorPk(id);
    var exists = reg != null;
    return exists;
  }

  Future<int> count() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from $tableName');
    return Sqflite.firstIntValue(result);
  }
}
