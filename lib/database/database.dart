import 'dart:async';
import 'dart:io';

import 'package:calcolapizza/models/dough.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider _instance = DBProvider._();

  factory DBProvider() => _instance;

  static Database _database;
  Future<Database> get database async {
    return _database ??= await initDB();
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final String path = join(documentsDirectory.path, "calcolapizza.db");
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE DOUGHS (" +
        "ID INTEGER PRIMARY KEY," +
        "NAME TEXT NOT NULL," +
        "DOUGHS_NUMBER INTEGER NOT NULL," +
        "DOUGHS_WEIGHT INTEGER NOT NULL," +
        "HYDRATION INTEGER NOT NULL," +
        "FLOUR INTEGER NOT NULL," +
        "WATER INTEGER NOT NULL," +
        "SALT INTEGER NOT NULL," +
        "FATS INTEGER NOT NULL," +
        "YEAST REAL NOT NULL," +
        "ROOM_TEMP INTEGER NOT NULL," +
        "RISING_TIME INTEGER NOT NULL," +
        "FRIDGE_RISING_TIME INTEGER NOT NULL," +
        "IS_GRANDMA_PIZZA INTEGER NOT NULL" +
        ")");
  }

  Future<int> saveDough(Dough dough) async {
    Database db = await database;
    return await db.insert("DOUGHS", dough.toMap());
  }

  Future<List> getDoughs() async {
    Database db = await database;
    return await db.rawQuery("SELECT * FROM DOUGHS ORDER BY NAME");
  }

  Future<int> getCount() async {
    Database db = await database;
    return Sqflite.firstIntValue(
        await db.rawQuery("SELECT COUNT(*) FROM DOUGHS"));
  }

  Future<int> deleteDough(int id) async {
    Database db = await database;
    return await db.rawDelete("DELETE FROM DOUGHS WHERE ID = $id");
  }
}
