import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../model/person.dart';
import '../model/event.dart';
import '../model/idea.dart';

//https://medium.com/flutter-community/using-sqlite-in-flutter-187c1a82e8b


class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null)
    return _database;

    // if _database is null, instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    var docPath = documentsDirectory.path;
    String path = "$docPath/TestDB4.db";
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {

      //Create people table
      await db.execute("CREATE TABLE Person ("
          "id TEXT PRIMARY KEY,"
          "name TEXT NOT NULL"
          ")");

      //Create ideas table
      await db.execute("CREATE TABLE Idea ("
          "id TEXT PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "website TEXT,"
          "done BIT"
          ")");

      //Create events table
      await db.execute("CREATE TABLE Event ("
          "id TEXT PRIMARY KEY,"
          "date DATE,"
          "title TEXT,"
          "description TEXT,"
          "recurring BIT,"
          "isExpanded BIT"
          ")");


      //List tables
      listTables();

    });
  }

  listTables() async{
    final db = await database;
    print(await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'" ));
  }

  savePerson(Person newPerson) async {
    final db = await database;
    var res = await db.insert("Person", newPerson.toJson());
    return res;
  }

  getAllPeople() async {
    final db = await database;
    var res = await db.query("Person");
    List<Person> list =
        res.isNotEmpty ? res.map((c) => Person.fromJson(c)).toList() : [];
    return list;
  }

  deleteAllPeople() async {
    final db = await database;
    db.rawDelete("DELETE FROM Person");
  }

  deletePerson(int id) async {
    final db = await database;
    db.delete("Person", where: "id = ?", whereArgs: [id]);
  }


}