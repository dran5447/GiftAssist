import 'package:flutter/material.dart';
import '../objectmodel.dart';
import '../personpage.dart';
import '../sharedhelpers.dart';
import '../floatingAdd.dart';

class PeopleWidget extends StatefulWidget {
  @override
  PeopleState createState() => PeopleState();
}

class PeopleState extends State<PeopleWidget>{
  final List<Person> people = Helpers.getTempPeopleList();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('People'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
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
        ]
       ),
       floatingActionButton: FABAdd(),
    );
  }
}