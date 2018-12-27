import 'package:flutter/material.dart';
import '../objectmodel.dart';
import '../sharedhelpers.dart';

class EventWidget extends StatefulWidget {
  @override
  EventState createState() => EventState();
}

class EventState extends State<EventWidget>{
  final List<Event> events = Helpers.getTempEventsList();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events'),
      ),
      body: Column(
        children: <Widget>[
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
        ],
      ),
    );
  }
}