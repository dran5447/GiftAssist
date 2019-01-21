import 'dart:io';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';

import '../model/person.dart';
import '../model/event.dart';
import '../model/idea.dart';

class DataStore{
  Map<String, Person> peopleCache = new Map<String, Person>();
  Map<String, Idea> ideaCache = new Map<String, Idea>();
  //Map<String, Event> eventCache;


  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localPersonFile async {
    final path = await _localPath;
    return File('$path/person.json'); 
  }
  Future<File> get _localIdeaFile async {
    final path = await _localPath;
    return File('$path/idea.json'); 
  }

  Future<bool> tempDeletePersonFileContents() async{
    final file = await _localPersonFile;
    try{
      file.writeAsStringSync(""); 
      return true;
    }
    catch(e){
      print('$e');
      return false;
    }
  }

  //START: IDEA PERSISTANCE

  Future<List<Idea>> retrieveIdeas() async{
    try {
      final file = await _localIdeaFile;

      //TODO delete TEMP ideas
      var tempjson = '[ {"id":"adsf324rfsdv", "title":"Temp Idea 1", "description":"desc 1"},{"id":"adsf345tg24rfsdv", "title":"Temp Idea 2", "description":"desc 2"}  ]';
      file.writeAsStringSync(tempjson);


      // Read the file
      String contents = await file.readAsString();

      print(contents);

      var parsedJson = json.decode(contents); 
      var result = parsedJson.map<Idea>((item) => (new Idea.fromJson(item))).toList();

      //Update cached list
      for(Idea i in result){
        ideaCache[i.id] = i;
      }

      return result;
    } catch (e) {
        print('$e');
        return null;
    }
  }



  //START: PERSON PERSISTANCE

  Future<bool> persistPerson(Person person) async{
    final file = await _localPersonFile;

     //Encode person to JSON format
    String json = jsonEncode(person);

    //Add to cached person list
    peopleCache[person.id] = person;

    //Get contents of file
    try {
      var contents = file.readAsStringSync();

      //if first entry, add [ ] and content, else add data
      if(contents == ""){
        await file.writeAsString('[$json]');        
      }
      else{
        var updated = contents.replaceFirst(']', ',$json]');
        await file.writeAsString(updated);
      }
      return true;
    }
    catch(e){
      print("$e");
      return false;
    }
    return false;
  }

  Future<List<Person>> retrievePeople() async{
    try {
      final file = await _localPersonFile;

      // Read the file
      String contents = await file.readAsString();

      print(contents);

      var parsedJson = json.decode(contents); 
      var result = parsedJson.map<Person>((item) => (new Person.fromJson(item))).toList();

      //Update cached list
      for(Person p in result){
        peopleCache[p.id] = p;
      }

      return result;
    } catch (e) {
        print('$e');
        return null;
    }
  }

  //END PERSON PERSISTANCE

}