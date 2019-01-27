import 'package:flutter/material.dart';
import '../model/event.dart';
import '../shared/sharedhelpers.dart';
import 'dart:math';
import '../shared/floatingAdd.dart';
import '../events/eventSummaryCard.dart';
import '../shared/datastore.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget({Key key}) : super(key: key);
 
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeWidget>{
  static Random random = new Random();

  HomeState({Key key});

  //TODO pass in a limited number of upcoming global events
  var events = Helpers.getTempEventsList();

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10.0),
            child: Text
            (
              'Upcoming Events',
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.left,
            ),
          ),
          //TODO notification/announcements area
          new Expanded(
            child: ListView.builder(
              physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                itemCount: events.length,
                itemBuilder: (context, j) {
                  return new Dismissible(
                    key: new Key(Helpers.generateUUID()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.green.shade300, 
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end, 
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(right: 30.0),
                            child:Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Icon(Icons.check),
                                Text('Mark Done')
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    onDismissed: (DismissDirection dismissDir){
                      //TODO handle event data changes

                      Event tempDismissedEvent =events[j];
                      setState(() {
                        events.remove(tempDismissedEvent);
                      });

                      //Show Undo snackbar option
                      Scaffold.of(context).removeCurrentSnackBar();
                      var snackbar = SnackBar(
                        content: Text("Marked as done."),
                        action: SnackBarAction(
                          textColor: Colors.redAccent,
                          label: 'Undo',
                          onPressed: () {
                              setState(() {
                                events.insert(j,tempDismissedEvent);
                              });
                          },
                        ),
                      );
                      Scaffold.of(context).showSnackBar(snackbar);
                    },
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: EventSummaryCard(events[j]),
                    ),
                  );
                }
              ),
          ),
        ],
      ),
      floatingActionButton: FABAddIdea(person: null),
    );
  }
}