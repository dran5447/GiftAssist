import 'package:flutter/material.dart';
import '../model/event.dart';
import '../shared/sharedhelpers.dart';
import 'eventdetailspage.dart';
import '../shared/datastore.dart';

class EventSummaryCard extends StatelessWidget {

  final Event event;

  EventSummaryCard(this.event);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(20.0),
            leading: Icon(Helpers.IconStringMap[event.eventTypeStrId], size:50.0), //TODO fix
            title: Text(event.title),
            subtitle: Text(Helpers.formatDate(Helpers.getEventDateTime(event))),
            trailing: EventStatusSnippet(event),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventDetailPage(event: event)),
              );
            },
          ),
        ],
      ),
    );
  }
}

class EventStatusSnippet extends StatelessWidget {
  final Event event;

  EventStatusSnippet(this.event);

  @override
  Widget build(BuildContext context) {
    if(event.ideasCompleted()){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.check, color:Colors.green),
          Text('Complete', style: new TextStyle(color: Colors.green))
        ],
      );
    }else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Incomplete', style: new TextStyle(color: Colors.red))
        ],
      ); 
    }
  }
}

    