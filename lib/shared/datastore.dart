import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
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
    String path = "$docPath/TestDB.db";
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
          "done BIT,"
          "eventId TEXT,"
          "uncategorizedPersonId TEXT"
          ")");

      //Create events table
      await db.execute("CREATE TABLE Event ("
          "id TEXT PRIMARY KEY,"
          "dateInMilli INTEGER,"
          "title TEXT,"
          "description TEXT,"
          "eventTypeId INTEGER,"
          "recurring BIT,"
          "isExpanded BIT,"
          "personId TEXT"
          ")");

      //Create event type table
      await db.execute("CREATE TABLE EventType ("
          "id TEXT PRIMARY KEY,"
          "name TEXT,"
          "iconDataCodePoint INTEGER"
          ")");

      //Populate event types
      createEventTypes();

      //List tables
      listTables();

    });
  }

  createEventTypes() async{
    final db = await database;

    //Insert event types in batch
    var batch = db.batch();
    batch.insert('EventType', {'id': '0', 'name':'Birthday', 'iconDataCodePoint':Icons.cake.hashCode});
    batch.insert('EventType', {'id': '1', 'name':'Graduation', 'iconDataCodePoint':Icons.school.hashCode});
    batch.insert('EventType', {'id': '2', 'name':'Winter Holiday', 'iconDataCodePoint':Icons.ac_unit.hashCode});
    batch.insert('EventType', {'id': '3', 'name':'Housewarming', 'iconDataCodePoint':Icons.home.hashCode});
    batch.insert('EventType', {'id': '4', 'name':'Baby Shower', 'iconDataCodePoint':Icons.child_friendly.hashCode});
    batch.insert('EventType', {'id': '5', 'name':'Valentines', 'iconDataCodePoint':Icons.favorite_border.hashCode});
    batch.insert('EventType', {'id': '6', 'name':'Party', 'iconDataCodePoint':Icons.people.hashCode});
    batch.insert('EventType', {'id': '7', 'name':'Food', 'iconDataCodePoint':Icons.restaurant.hashCode});
    batch.insert('EventType', {'id': '8', 'name':'Promotion', 'iconDataCodePoint':Icons.work.hashCode});
    batch.insert('EventType', {'id': '9', 'name':'Wedding', 'iconDataCodePoint':Icons.all_inclusive.hashCode});
    batch.insert('EventType', {'id': '10', 'name':'Anniversary', 'iconDataCodePoint':Icons.favorite.hashCode});
    batch.insert('EventType', {'id': '11', 'name':'Other', 'iconDataCodePoint':Icons.card_giftcard.hashCode});
    var results = await batch.commit();
  }

  listTables() async{
    final db = await database;
    print(await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'" ));
  }

  deleteAllData() async {
    final db = await database;
    db.rawDelete("DELETE FROM Person");
    db.rawDelete("DELETE FROM Idea");
    db.rawDelete("DELETE FROM Event");

  }

  /// START PEOPLE QUERIES

  savePerson(Person newPerson) async {
    final db = await database;
    var res = await db.insert("Person", newPerson.toJson());
    return res;
  }

  getAllPeople() async {
    final db = await database;
    var res = await db.query("Person");
    List<Person> list =
        res.isNotEmpty ? res.map<Person>((c) => Person.fromJson(c)).toList() : [];
    return list;
  }

  deletePerson(int id) async {
    final db = await database;
    db.delete("Person", where: "id = ?", whereArgs: [id]);
  }

  ///END PEOPLE QUERIES

  ///START IDEA QUERIES

  saveIdea(Idea idea) async{
    final db = await database;
    var res = await db.insert("Idea", idea.toJson());
    return res;
  }

  getIdeasForPerson(Person p) async{
    final db = await database;
    var res =await  db.query("Idea", where: "uncategorizedPersonId = ?", whereArgs: [p.id]);
    List<Idea> list =
        res.isNotEmpty ? res.map<Idea>((c) => Idea.fromJson(c)).toList() : [];
    return list;
  }

  ///END IDEA QUERIES

  ///START EVENT QUERIES

  saveEvent(Event e) async{
    final db = await database;
    var res = await db.insert("Event", e.toJson());
    return res;
  }

  getEventsForPerson(Person p) async{
    final db = await database;
    var res =await  db.query("Event", where: "personId = ?", whereArgs: [p.id]);
    List<Event> list =
        res.isNotEmpty ? res.map<Event>((c) => Event.fromJson(c)).toList() : [];
    return list;
  }

  getEventTypeForEvent(Event e) async{
    final db = await database;
    var res = await  db.query("EventType", where: "id = ?", whereArgs: [e.eventTypeId]);
    return res;
  }

  ///END EVENT QUERIES
}