import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../model/dosage_model.dart';
class DbHelper
{
  Database? _db;
  Future<Database?> get db
  async {
    if(_db!=null)
    {
      return _db;
    }
    var directory=await getExternalStorageDirectory();
    String path=join(directory!.path,'db');
    var db=await openDatabase(path,version: 1,onCreate: (db, version) {
      db.execute("CREATE TABLE alarm(key TEXT PRIMARY KEY,hour TEXT,min TEXT,title TEXT,period TEXT,day TEXT,isEnabled TEXT,alarmId TEXT)");
    },);
    return db;
  }

  Future<DosageModel> insert(DosageModel model) async
  {
    var dbclient=await db;
    dbclient!.insert('alarm',model.toMap()).then((value) {
      print('inserted');
    },).onError((error, stackTrace) {
      print(error.toString());
    },);
    return model;
  }




  Future<int> delete (String id)
  async {
    var dbClient=await db;
    return await dbClient!.delete(
        'alarm',
        where: 'key = ?',
        whereArgs: [id]);
  }

  Future<List<DosageModel>> getData() async {
    var dbClient = await db;
    final List<Map<String, Object?>> queryResult = await dbClient!.query('alarm');
    return queryResult.map((e) => DosageModel.fromMap(e)).toList();
  }

}