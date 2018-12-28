import 'package:flutter/material.dart';
import 'objectmodel.dart';
import 'sharedhelpers.dart';
import 'events_ideas_treeview.dart';

import 'package:flutter_speed_dial/flutter_speed_dial.dart';

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

      floatingActionButton: SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          curve: Curves.bounceIn,
          tooltip: 'View Quick-Add Menu',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Color.fromARGB(255, 126, 71, 98),
          foregroundColor: Colors.white,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.card_giftcard),
              backgroundColor: Color.fromARGB(255, 76, 66, 74),
              label: 'Add Gift Idea',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () { 
                Helpers.navigateToAddAndReturnResult(context);
              }
            ),
            SpeedDialChild(
              child: Icon(Icons.calendar_today),
              backgroundColor: Color.fromARGB(255, 83, 116, 127),
              label: 'Add Event',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: ()  { 
                //TODO add event tap
                print('SECOND CHILD');
              }
            ),
          ],
        ),
    );
  }
}