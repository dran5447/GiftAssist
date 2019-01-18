import 'package:flutter/material.dart';
import 'objectmodel.dart';
import 'sharedhelpers.dart';

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
            leading: Icon(event.icon, size:50.0),
            title: Text(event.title),
            subtitle: Text(Helpers.formatDate(event.date)),
            trailing: EventStatusSnippet(event),
            onTap: (){//TODO event pressed
              showDialog(
                context: context,
                builder: (context){
                  return new AlertDialog(
                    content: Text('event pressed'),
                  );
                }
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

    