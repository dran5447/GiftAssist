import 'dart:io';
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
    String path = "$docPath/TestDB2.db";   //TODO later fix this
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
          "eventTypeStrId TEXT,"
          "recurring BIT,"
          "isExpanded BIT,"
          "personId TEXT,"
          "completed INTEGER"
          ")");

      //List tables
      listTables();

    });
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
    print(idea.eventId);
    return res;
  }

  getIdeasForPerson(Person p) async{
    final db = await database;
    var res = await  db.query("Idea", where: "uncategorizedPersonId = ?", whereArgs: [p.id]);
    List<Idea> list =
        res.isNotEmpty ? res.map<Idea>((c) => Idea.fromJson(c)).toList() : [];
    return list;
  }

  getIdeasForEvent(Event e) async{
    final db = await database;
    var res = await  db.query("Idea", where: "eventId = ?", whereArgs: [e.id]);
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

  getAllEvents() async{
    final db = await database;
    var res = await db.query("Event");
    List<Event> list =
        res.isNotEmpty ? res.map<Event>((c) => Event.fromJson(c)).toList() : [];
    return list;
  }

  getUpcomingEventsWithinXDays(int daysRange) async {
    var now = DateTime.now();
    var futureDate = now.add(new Duration(days: daysRange));
    var nowMS = now.millisecondsSinceEpoch;    
    var futureDateMS = futureDate.millisecondsSinceEpoch;
    
    final db = await database;
    var res = await db.query("Event", where: "dateInMilli > ? AND dateInMilli < ?", 
                            whereArgs: [nowMS, futureDateMS], orderBy: "dateInMilli");
    List<Event> list =
        res.isNotEmpty ? res.map<Event>((c) => Event.fromJson(c)).toList() : [];
    return list;
  }

  updateEvent(Event e) async {
    final db = await database;
    var res = await db.update("Event", e.toMap(),  where: " id = ? ", whereArgs: [e.id]);
    return res;
  }
  ///END EVENT QUERIES
}