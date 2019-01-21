import 'package:flutter/material.dart';
import '../shared/sharedhelpers.dart';
import '../events/events_ideas_treeview.dart';
import '../shared/floatingAdd.dart';
import '../model/idea.dart';
import '../model/event.dart';

class PersonPage extends StatefulWidget {
  final String personName;
  
  PersonPage({Key key, this.personName}) : super(key: key);

  @override
  _IdeasState createState() => _IdeasState(personName: personName);
}

class _IdeasState extends State<PersonPage> {
  final String personName;
  
  _IdeasState({Key key, this.personName});

  final List<Idea> ideas = Helpers.getTempIdeasList1();
  final List<Event> events = Helpers.getTempEventsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 30.0),
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).unselectedWidgetColor,
                    child: Text(Helpers.getInitials(widget.personName)),
                    minRadius: 50,
                  ),
                ),
                Text
                (
                  widget.personName,
                  style: Theme.of(context).textTheme.headline,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              'Events',
              style: Theme.of(context).textTheme.subhead,
              textAlign: TextAlign.left,
            ),
          ),
          
          EventIdeasTreeWidget(events: events),

        ]
      ),

      floatingActionButton: FABSpeedDial(),
    );
  }
}