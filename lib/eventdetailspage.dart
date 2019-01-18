import 'package:flutter/material.dart';
import 'objectmodel.dart';
import 'sharedhelpers.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;
  
  EventDetailPage({Key key, this.event}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState(event: event);
}

class _EventDetailState extends State<EventDetailPage> {
  final Event event;
  
  _EventDetailState({Key key, this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
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
                  child: Text('TODO add event details here'),
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}