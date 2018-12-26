import 'package:flutter/material.dart';
import 'personpage.dart';
import 'addgiftideapage.dart';
import 'objectmodel.dart';
import 'sharedhelpers.dart';

import 'dart:math';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
        primarySwatch: Colors.grey,
        primaryColor: Color.fromARGB(255, 126, 71, 98),
      //  primaryColor: Color.fromARGB(255, 83, 116, 127),
        unselectedWidgetColor: Colors.grey.shade200,
        accentColor: Color.fromARGB(255, 126, 71, 98),
      ),
      home: MyApp(),
  ));
}

//color scheme:
//burgundy - 7E4762
//grey - 272326
//dark teal -53747F
//light teal -B1C5BC
//old paper -F9F6E4

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {   
  HomePage({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage>{
  static Random random = new Random();
  final List<Event> events = List<Event>.generate(
    15,
    (i) => Event(
      new DateTime(2018, 12, random.nextInt(31)),//.now(),
          'title $i',
          'A description for $i',
        ),
  );

  final List<Person> people = List<Person>.generate(
    20,
    (i) => Person(
          'Person $i',
          new List<Event>.generate(
            5,
            (i) => Event(
              new DateTime.now(),
                  'title $i',
                  'A description for $i',
                ),
          ),
          List<Idea>.generate(
            20,
            (i) => Idea(
                  'Idea $i',
                  'A description for $i',
                ),
          )
        ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text
            (
              'Upcoming Events',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          new Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(Helpers.informalDate(events[index].date) + ":" + Helpers.simplifyDate(events[index].date)),
                  title: Text(events[index].title),
                  onTap: () { /* TODO react to the tile being tapped */ },
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text
            (
              'People',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          new Expanded(
            child: GridView.builder(
              itemCount: people.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return new GestureDetector(
                  child: new Card(
                    elevation: 5.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).unselectedWidgetColor,
                            child: Text(Helpers.getInitials(people[index].name)),
                            minRadius: 60,
                          ),
                        ),
                        Text
                        (
                          people[index].name,
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PersonPage(personName: people[index].name,)),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateToAddAndReturnResult(context);
        },
        tooltip: 'Quick Add Gift Idea',
        child: Icon(Icons.add),
      ),
    );
  }

  navigateToAddAndReturnResult(BuildContext context) async{
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the following screen to feedback success or failure
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddGiftIdeaScreen()),
    );

    if (result != null){
      // After result returned hide any previous snackbars and show result
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
    }
    
  }
}
