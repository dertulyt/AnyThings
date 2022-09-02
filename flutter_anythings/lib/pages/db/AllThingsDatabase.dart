import 'package:flutter_anythings/pages/model/thing.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class AllMyThings {
  static final AllMyThings instance = AllMyThings._init();
  static Database? _database;

  AllMyThings._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('allThings.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''CREATE TABLE $tableThings (
      ${ThingFields.id} $idType,
      ${ThingFields.title} $textType,
      ${ThingFields.subtitle} $textType,
      ${ThingFields.count} $integerType,
      ${ThingFields.category} $textType,
      ${ThingFields.time} $textType
    )''');
  }

  Future<Thing> create(Thing thing) async {
    final db = await instance.database;
    final id = await db.insert(tableThings, thing.toJson());
    return thing.copy(id: id);
  }

  Future<Thing> readNote(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableThings,
      columns: ThingFields.values,
      where: '${ThingFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Thing.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<Thing>> readAllNotes() async {
    final db = await instance.database;

    final orderBy = '${ThingFields.time} ASC';

    final result = await db.query(tableThings, orderBy: orderBy);

    return result.map((json) => Thing.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableThings,
      where: '${ThingFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
