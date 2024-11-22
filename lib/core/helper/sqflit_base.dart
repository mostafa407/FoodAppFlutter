import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoappn/data/model/task_model.dart';

class SqfliteHelper{
  SqfliteHelper._();
 static final SqfliteHelper instance=SqfliteHelper._();
 late Database _datebase;
 //initialize
Future<Database>initDataBase() async{
  var databasepah=await getDatabasesPath();
  String pathDataBase=databasepah+ "tod.db";
  _datebase =await openDatabase(pathDataBase, version: 3,onCreate: _oncreate);
  return _datebase;
}
_oncreate(Database db, int version)async{

  await db.execute("""
    CREATE TABLE tasks(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT,
      description TEXT,
      date TEXT,
      status TEXT
      )
""");
  // await db.execute('''
  // CREATE TABLE tasks(
  // id INTEGER PRIMARY KEY AUTOINCREMENT,
  // title Text,
  // description Text,
  // date Text,
  // status Text,)
  // ''');
}
Future <List<TasksModel>>getDataFromDatabase()async{
  List<Map<String,dynamic>> data=await _datebase.query("tasks");
  List<TasksModel>tasks=data.map((e)=>TasksModel.formJson(e)).toList();
  return tasks;
  }

Future<void>insertData(TasksModel tasks)async{
  await _datebase.insert("tasks", tasks.toMap());
}
// Upbate
Future<void>updateData(TasksModel tasks)async{
  await _datebase.update("tasks", tasks.toMap(),where:"id=?", whereArgs: [tasks.id]);
}
//Update status
  Future<void>updateStatus(int id , String status)async{
    await _datebase.rawUpdate('UPDATE tasks SET status=? WHERE id=?', [status,id]);

  }
//Delete task
Future<void> deleteData(int id) async
{
  await _datebase.rawDelete("DELETE FROM tasks WHERE id =?",[id]);
}

}

