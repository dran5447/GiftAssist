import 'package:flutter/material.dart';
import '../model/event.dart';
import '../shared/sharedhelpers.dart';
import 'eventdetailspage.dart';
import '../shared/datastore.dart';
import '../model/eventtype.dart';

class EventSummaryCard extends StatelessWidget {

  final Event event;

  EventType eventType;

  Future<EventType> getEventType() async{
    var res = DBProvider.db.getEventTypeForEvent(event);
    eventType = res;
    return res;
  }

  EventSummaryCard(this.event);

  @override
  Widget build(BuildContext context) {
 //   var x =  this.getEventType();

    return Card(
      elevation: 4.0,
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.all(20.0),
      //      leading: Icon(IconData(eventType.iconDataCodePoint), size:50.0), //TODO fix
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

    