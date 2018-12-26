import 'package:flutter/material.dart';
import 'personpage.dart';
import 'addgiftideapage.dart';
import 'objectmodel.dart';
import 'sharedhelpers.dart';

import 'dart:math';

//void main() => runApp(MyApp());

void main() {
  runApp(MaterialApp(
  //  title: 'Gift Assist',
    theme: ThemeData(
        primarySwatch: Colors.indigo,
        primaryColor: Colors.indigo.shade900,
        unselectedWidgetColor: Colors.grey.shade200,
        accentColor: Colors.cyanAccent.shade400, // or Colors.pinkAccent.shade200, //TODO add option
      ),
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gift Assist'),
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
                  onTap: () { /* react to the tile being tapped */ },
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
                          padding: EdgeInsets.only(bottom: 30.0),
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).unselectedWidgetColor,
                            child: Text(Helpers.getInitials(people[index].name)),
                            minRadius: 50,
                          ),
                        ),
                        Text
                        (
                          people[index].name,
                          style: Theme.of(context).textTheme.headline,
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
