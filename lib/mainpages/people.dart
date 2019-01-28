import 'package:flutter/material.dart';
import '../model/person.dart';
import '../shared/floatingAdd.dart';
import '../shared/datastore.dart';
import '../people/peopleList.dart';

class PeopleWidget extends StatefulWidget {
  PeopleWidget({Key key}) : super(key: key);

  @override
  PeopleState createState() => PeopleState();
}

class PeopleState extends State<PeopleWidget>{
  PeopleState({Key key});

  static List<Person> people;

  Future<List<Person>> getPeople() async{
    var result = await DBProvider.db.getAllPeople();
    return result;
  }

  void tempDelete() async{
    setState(() {
      DBProvider.db.deleteAllData();
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          FlatButton(
            color: Colors.red,
            textColor: Colors.white,
            child: Text("TEMP DELETE ALL DATA"),
            onPressed: tempDelete,
          ),  //TODO delete later
          new Expanded(
            child: FutureBuilder<List<Person>>(
              future: getPeople(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);

                return snapshot.hasData
                    ? PeopleList(people: snapshot.data)
                    : Padding(
                        padding: EdgeInsets.all(20.0),
                        child:Center(
                            child: Text("None addded. Click the Plus sign in the bottom right to add a Person.")
                        )
                      );
              },
            ),
          ),
        ]
       ),
       floatingActionButton: FABAddPerson(),
    );
  }
}