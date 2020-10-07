import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:bucks/src/DAO/item_estoque_dao.dart';
import 'package:bucks/src/DAO/movto_estoque_dao.dart';
import 'package:bucks/src/classes/user.dart';
import 'package:bucks/src/shared/utils/constants.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;

class UserDb extends Disposable {
  static final UserDb _instance = UserDb.getInstance();

  factory UserDb() => _instance;

  UserDb.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) {
      print("teste");
      //criar tabelas
      _onCreate(_db, 0);
      return _db;
    }
    // _onCreate(_db, 0);

    // deletarTabelasManualmente();

    _db = await initDb();

    //criar tabelas
    //_onCreate(_db, 0);

    return _db;
  }

  Future<bool> dbExists;

  initDb() async {
    var version = 1;

    String databasePath = await getDatabasesPath();

    String path = join(databasePath, 'bucks.db');
    print('db $path');

    dbExists = io.File(path).exists();

    var db = await openDatabase(path,
        version: version,
        onCreate: _onCreate,
        onUpgrade: _onUpgrade,
        readOnly: false);
    return db;
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion == 1) {
      await updateVersion2(db);
    }
  }

  void _dropTable(Database db, int newVersion, String pTableName) async {
    try {
      await db.execute('DROP TABLE $pTableName');
      print('TABELA $pTableName DROPADA COM SUCESSO!');
    } catch (e) {
      print("***ERRO AO DROPAR TABELA $pTableName ! => " + e.toString());
    }
  }

  void deletarTabelasManualmente() async {
    MovtoEstoqueDAO movtoEstoqueDAO = MovtoEstoqueDAO();
    movtoEstoqueDAO.deletarTodos();

    ItemEstoqueDAO itemEstoqueDAO = ItemEstoqueDAO();
    itemEstoqueDAO.deletarTodos();
  }

  void _onCreate(Database db, int newVersion) async {
    //_dropTable(db, newVersion, table_name_movto_estoque);

    /*try {
      await db.execute(
          'CREATE TABLE $table_name_cg_ref_codes(id INTEGER PRIMARY KEY AUTOINCREMENT, rv_dommain TEXT, rv_low_value TEXT, rv_high_value TEXT, rv_descr TEXT, rv_abrev TEXT)');
    } catch (e) {
      print("***ERRO AO CRIAR TABELA $table_name_cg_ref_codes ! => " +
          e.toString());
    }*/

    try {
      await db.execute(
          'CREATE TABLE $table_name_item_tipo(id INTEGER PRIMARY KEY AUTOINCREMENT, descr TEXT)');
    } catch (e) {
      print(
          "***ERRO AO CRIAR TABELA $table_name_item_tipo ! => " + e.toString());
    }

    try {
      await db.execute(
          'CREATE TABLE $table_name_item_grupo(id INTEGER PRIMARY KEY AUTOINCREMENT, descr TEXT)');
    } catch (e) {
      print("***ERRO AO CRIAR TABELA $table_name_item_grupo ! => " +
          e.toString());
    }

    try {
      await db.execute(
          'CREATE TABLE $table_name_item_unmed(id TEXT PRIMARY KEY, descr TEXT)');
    } catch (e) {
      print("***ERRO AO CRIAR TABELA $table_name_item_unmed ! => " +
          e.toString());
    }

    try {
      await db.execute(
          'CREATE TABLE $table_name_item(id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
              'descr TEXT, ' +
              'cd TEXT, ' +
              'cdControlaEstoque TEXT, ' +
              'qtd_min_estoque REAL, ' +
              'fk_item_tipo_id REFERENCES $table_name_item_tipo(id), ' +
              'fk_item_grupo_id REFERENCES $table_name_item_grupo(id), ' +
              'fk_item_unmed_id REFERENCES $table_name_item_unmed(id))');
      print('Tabela criada com sucesso! TABLE ($table_name_item)');
    } catch (e) {
      print("***ERRO AO CRIAR TABELA $table_name_item ! => " + e.toString());
    }

    try {
      await db.execute(
          'CREATE TABLE $table_name_tipo_producao(id INTEGER PRIMARY KEY AUTOINCREMENT, descr TEXT)');
    } catch (e) {
      print("***ERRO AO CRIAR TABELA $table_name_tipo_producao ! => " +
          e.toString());
    }

    try {
      await db.execute(
          'CREATE TABLE $table_name_producao(id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
              'fk_producao_tipo_id REFERENCES $table_name_tipo_producao(id), ' +
              //' fk_producao_tipo_id TEXT, ' +
              ' descr TEXT, ' +
              ' vl_mo REAL, ' +
              ' vl_custos_ind REAL, ' +
              ' dt_producao_ini TEXT, ' +
              ' dt_producao_fim TEXT, ' +
              ' cd_status TEXT )');
    } catch (e) {
      print(
          "***ERRO AO CRIAR TABELA $table_name_producao ! => " + e.toString());
    }

    try {
      await db.execute(
          'CREATE TABLE $table_name_producao_item(seq INTEGER PRIMARY KEY AUTOINCREMENT , ' +
              'fk_producao_id REFERENCES $table_name_tipo_producao(id) , ' +
              'fk_item_id REFERENCES $table_name_item(id), ' +
              'qt REAL, ' +
              'vl_unit REAL, ' +
              'cd_tipo TEXT, ' +
              'cd_status TEXT )');
    } catch (e) {
      print("***ERRO AO CRIAR TABELA $table_name_producao_item ! => " +
          e.toString());
    }

    try {
      await db.execute(
          'CREATE TABLE $table_name_item_estoque(fk_item_id INTEGER PRIMARY KEY REFERENCES $table_name_item(id)' +
              ', qt_saldo REAL' +
              ', vl_unit REAL' +
              //', qt_reservado REAL
              ' ) ');
      print('Tabela criada com sucesso! TABLE ($table_name_item_estoque)');
    } catch (e) {
      print("***ERRO AO CRIAR TABELA $table_name_item_estoque ! => " +
          e.toString());
    }

    try {
      await db.execute(
          'CREATE TABLE $table_name_movto_estoque_tipo(id INTEGER PRIMARY KEY AUTOINCREMENT, descr TEXT, cd_tipo_movto TEXT)');
    } catch (e) {
      print("***ERRO AO CRIAR TABELA $table_name_movto_estoque_tipo ! => " +
          e.toString());
    }

    try {
      await db.execute(
          'CREATE TABLE $table_name_movto_estoque(id INTEGER PRIMARY KEY AUTOINCREMENT, ' +
              'fk_item_estoque_item_id REFERENCES $table_name_item_estoque(fk_item_id), ' +
              'fk_movto_estoque_tipo_id REFERENCES $table_name_movto_estoque_tipo(id), ' +
              'dt TEXT, ' +
              'qtd REAL, ' +
              'vl_unit REAL, ' +
              'qt_saldo_ant REAL, ' +
              'qt_saldo_pos REAL, ' +
              'vl_unit_ant REAL, ' +
              'vl_unit_pos REAL, ' +
              'fk_proditem_producao_id REFERENCES $table_name_producao_item(fk_producao_id), ' +
              'fk_proditem_seq REFERENCES $table_name_producao_item(seq) ' +
              ')');
    } catch (e) {
      print("***ERRO AO CRIAR TABELA $table_name_movto_estoque ! => " +
          e.toString());
    }

    var dbClient = await db;

    final sql =
        'insert into $table_name_movto_estoque_tipo(descr, cd_tipo_movto) VALUES (?,?)';
    print(sql);
    var id = await dbClient.rawInsert(sql, ['Entrada por Produção', 'E']);

    final sql2 =
        'insert into $table_name_movto_estoque_tipo(descr, cd_tipo_movto) VALUES (?,?)';
    print(sql);
    var id2 = await dbClient.rawInsert(sql, ['Saída por Produção', 'S']);
  }

  updateVersion2(Database db) async {
    List<String> updateVersion2 = [
      'CREATE TABLE ITEM(id INTEGER PRIMARY KEY, descr TEXT)',
      // 'CREATE TABLE $table_name_almoxarifado(instNum INTEGER PRIMARY KEY, instNome TEXT, upfjPfjNum REFERENCES $table_name_unidade(upfjPfjNum), upfjNum REFERENCES $table_name_unidade(upfjNum))',
      // 'CREATE TABLE $table_name_receituario_item(receituarioNum INTEGER, receituarioDescr TEXT, itemNum INTEGER, itemNome TEXT, itemCd TEXT, itemUnidmedCd TEXT, itemDtVcto TEXT, itemLote TEXT, itemQtEstoque REAL, itemQtReceituario REAL, PRIMARY KEY (receituarioNum, itemNum))',
      // 'CREATE TABLE $table_name_item(itemNum INTEGER PRIMARY KEY, itemNome TEXT, itemCd TEXT, itemUnidmedCd TEXT, itemDtVcto TEXT, itemLote TEXT, itemQtEstoque REAL, itemQtReceituario REAL)'
    ];

    await db.execute(updateVersion2[0]);
    // await db.execute(updateVersion2[1]);
    // await db.execute(updateVersion2[2]);
    // await db.execute(updateVersion2[3]);
  }

  Future existsTable(String tableName) async {
    var dbClient = await db;

    final sql =
        "SELECT name FROM sqlite_master WHERE type='table' AND name='$tableName'";

    final result = await dbClient.rawQuery(sql);
    print(result);
  }

  Future<int> saveUser(User user) async {
    var dbClient = await db;

    final sql =
        'insert or replace into users(username, name, password, email) VALUES (?,?,?,?)';
    print(sql);
    var id = await dbClient
        .rawInsert(sql, [user.username, user.name, user.password, user.email]);

    print('id: $id');
    return id;
  }

  Future<List<Map>> getAllUsers() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select * from users');
    return result.toList();
  }

  Future<int> getCountUsers() async {
    final dbClient = await db;
    final result = await dbClient.rawQuery('select count(*) from users');
    return Sqflite.firstIntValue(result);
  }

  Future<User> getUser(String username) async {
    var dbClient = await db;
    final result = await dbClient
        .rawQuery('select * from users where username = ?', [username]);

    if (result.length > 0) return User.fromJson(result.first);

    return null;
  }

  Future<bool> exists(User user) async {
    User rep = await getUser(user.username);
    var exists = rep != null;
    return exists;
  }

  Future<int> deleteUser(String username) async {
    var dbClient = await db;
    return await dbClient
        .rawDelete('delete from users where username = ?', [username]);
  }

  Future<int> deleteAllUsers() async {
    var dbClient = await db;
    return await dbClient.rawDelete('delete from users');
  }

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }

  @override
  void dispose() {
    close();
  }
}
