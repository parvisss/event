import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app_forudevs/logic/data/models/event.dart';

class EventMake {
  static String id = "id";
  static String name = "name";
  static String description = "description";
  static String day = "day";
  static String isFinished = "isFinished";
  static String location = "location";
  static String color = "color";
}

class LocalDatabase {
  static String tableName = "todos";
  static LocalDatabase getInstance = LocalDatabase._init();
  Database? _database;
  

  LocalDatabase._init();

  Future<Database> getDb() async {
    if (_database == null) {
      _database = await _initDB("todo.db");
      return _database!;
    }
    return _database!;
  }

  Future<Database> _initDB(String fileName) async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, fileName);

    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String idType = "INTEGER PRIMARY KEY AUTOINCREMENT";
        String textType = "TEXT";
        String intType = "INTEGER";
        String boolType = "INTEGER";

        await db.execute('''
        CREATE TABLE $tableName (
            ${EventMake.id} $idType,
            ${EventMake.name} $textType, 
            ${EventMake.description} $textType, 
            ${EventMake.color} $intType,
            ${EventMake.day} $textType,
            ${EventMake.isFinished} $boolType,
            ${EventMake.location} $textType
            )
            ''');
      },
    );
    return database;
  }

  static Future<EventModel> insertToDatabase(EventModel event) async {
    var database = await getInstance.getDb();
    int id = await database.insert(tableName, event.toJson());
    return event.copyWith(id: id);
  }

  static Future<EventModel> updateTaskById(EventModel updatedTask) async {
    var database = await getInstance.getDb();
    int id = await database.update(
      tableName,
      updatedTask.toJson(),
      where: 'id = ?',
      whereArgs: [updatedTask.id],
    );
    return updatedTask.copyWith(id: id);
  }

  static Future<List<EventModel>> getList() async {
    var database = await getInstance.getDb();
    var listOfEvents = await database.query(tableName, columns: [
      EventMake.id,
      EventMake.name,
      EventMake.description,
      EventMake.color,
      EventMake.day,
      EventMake.isFinished,
      EventMake.location
    ]);

    List<EventModel> list =
        listOfEvents.map((e) => EventModel.fromJson(e)).toList();

    return list;
  }


  static Future<int> deleteTaskById(int id) async {
    var database = await getInstance.getDb();
    return await database.delete(
      tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
