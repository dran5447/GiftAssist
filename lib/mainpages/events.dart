import 'package:flutter/material.dart';
import '../objectmodel.dart';
import '../sharedhelpers.dart';
import '../events_ideas_treeview.dart';
import '../floatingAdd.dart';

class EventWidget extends StatefulWidget {
  @override
  EventState createState() => EventState();
}

class EventState extends State<EventWidget>{
  //TODO get events data for all people - may need refactor to the treeview
  //TODO get sorted list of events using two helper methods
  final List<Event> events = Helpers.getTempEventsList();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Column(
        children: <Widget>[
           EventIdeasTreeWidget(events: events),
        ],
      ),
      floatingActionButton: FABAdd(),
    );
  }
}