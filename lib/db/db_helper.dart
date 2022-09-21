import 'package:medicine_reminder_app2022/models/pill_model.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper{
  static Database? _db;
  static final int _versoin = 1;
  static final String _tableName = "pills";

  static Future<void> initDb()async{
    if(_db !=null) {
      return;
    }
    try{
      String _path = await getDatabasesPath() + 'pills.db';
      _db = await openDatabase(
        _path,
        version: _versoin,
        onCreate: (db, version) {
          print("==========================================================================");
          print("creating a new one ");
          return db.execute(
            "CREATE TABLE $_tableName("
                "id INTEGER PRIMARY KEY AUTOINCREMENT, "
                "title STRING, note TEXT, date STRING, "
                "startTime STRING, endTime STRING, "
                "remind INTEGER, repeat STRING, "
                "color INTEGER, "
                "isCompleted INTEGER, image STRING)",
          );
        },
      );
    }catch(e){
      print(e);
    }
  }

  static Future<int> insert(PillModel? pill)async {
    print("Insert function called");
    return await _db?.insert(_tableName, pill!.toJson())??1;
  }

  static Future<List<Map<String,dynamic>>> query() async {
    print("query function called");
    return await _db!.query(_tableName);
  }

  static deleteHelper(PillModel pill) async {

  return await _db!.delete(
      _tableName,
      where: 'id=?',
      whereArgs: [pill.id],
    );
  }

  static update(int id) async {
    return await _db!.rawUpdate('''
      UPDATE pills
      SET isCompleted = ?
      WHERE id =?
    ''',[1,id]);
  }


}