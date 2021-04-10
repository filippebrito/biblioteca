import 'package:async/async.dart';
import 'package:sqflite/sqflite.dart';

class DBManager {

  static const String DB_NAME = 'librarys.db';
  static const int dbVersion = 1;

  // Singleton pattern
  static final DBManager _dbManager = new DBManager._internal();
  DBManager._internal();
  static DBManager get instance => _dbManager;

  Database _db;
  final _initDBMemoizer = AsyncMemoizer<Database>();
  String path;

  Future<Database> get database async {

    if (_db == null) {
      _db = await _initDBMemoizer.runOnce(() async {
        return await _initDB();
      });

      if(!_db.isOpen){

      }
    }
    return _db;
  }

  Future<Database> _initDB() async {
    path = await getDatabasesPath() + "/" + DB_NAME ;

    return await openDatabase(path, version: dbVersion,
        onCreate: (Database db, int version) async {
          await db.execute(_getCreateTable());
        });
  }

  String _getCreateTable(){
    return "CREATE TABLE book (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT)";
  }

}