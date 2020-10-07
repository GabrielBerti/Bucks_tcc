import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class BucksDBRepository extends Disposable {
  static final BucksDBRepository _instance = BucksDBRepository.getInstance();

  factory BucksDBRepository() => _instance;

  BucksDBRepository.getInstance();

  static Database _db;

  Future<Database> get db async {
    if (_db != null) return _db;

    _db = await initDb();
    return _db;
  }

  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'bucks.db');
    var db = await openDatabase(path, readOnly: false);
    return db;
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
