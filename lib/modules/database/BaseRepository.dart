import 'package:biblioteca/modules/database/DBManager.dart';

class BaseRepository {

  BaseRepository();

  Future<int> insertDB(String sql) async {
    var db = await DBManager.instance.database;
    int vlr = await db.transaction((txn) async {
      return await txn.rawInsert(sql);
    });
    close();
    return vlr;
  }

  Future<int> updateDB(String sql) async {
    var db = await DBManager.instance.database;
    int vlr = await db.rawUpdate(sql);
    close();
    return vlr;
  }

  Future<int> deleteDB(String sql) async {
    var db = await DBManager.instance.database;
    int vlr = await db.rawDelete(sql);
    close();
    return vlr;
  }

  Future<List<Map>> selectDb(String sql) async{
    var db = await DBManager.instance.database;
    List<Map> list = await db.rawQuery(sql);
    close();
    return list;
  }

  Future close() async{
    //var db = await DBManager.instance.database;
    //await db.close();
  }

}