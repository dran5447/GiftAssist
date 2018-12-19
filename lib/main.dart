import 'package:flutter/material.dart';
import 'personpage.dart';
import 'addgiftideapage.dart';
import 'objectmodel.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gift Assist',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: Colors.tealAccent
      ),
      home: HomePage(title: 'Gift Assist'),
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;
  
  HomePage({Key key, this.title}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<HomePage>{
  final List<Event> events = List<Event>.generate(
    15,
    (i) => Event(
      new DateTime.now(),
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

  String getInitials(String name){
    var nameList = name.split(" ");
    String initials = '';
    nameList.forEach(
      (element) => initials+=element.substring(0,1)
    );
    return initials;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          new Expanded(
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Text(events[index].date.toString()),
                  title: Text(events[index].title),
                  onTap: () { /* react to the tile being tapped */ },
                );
              },
            ),
          ),
          Divider(),
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
                            backgroundColor: Colors.tealAccent.shade700,
                            child: Text(getInitials(people[index].name)),
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

                    // showDialog(
                    //   barrierDismissible: false,
                    //   context: context,
                    //   child: new SimpleDialog(
                    //     title: new Column(
                    //       children: <Widget>[
                    //         new Text("GridView"),
                    //         new Icon(
                    //           Icons.favorite,
                    //           color: Colors.green,
                    //         ),
                    //       ],
                    //     ),
                    //     children: <Widget>[
                    //         SimpleDialogOption(
                    //           onPressed: () 
                    //           {  
                    //             //TODO navigate away
                    //             //Navigator.pop(context, Department.treasury); 
                    //           },
                    //           child: const Text('Confirm'),
                    //         ),
                    //         SimpleDialogOption(
                    //           onPressed: () { Navigator.pop(context); },
                    //           child: const Text('Cancel'),
                    //         ),
                    //       ],
                    //   ),
                    // );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddGiftIdeaScreen()),
          );
        },
        tooltip: 'Quick Add Gift Idea',
        child: Icon(Icons.add),
      ),
    );
  }
}
