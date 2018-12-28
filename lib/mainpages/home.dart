import 'package:flutter/material.dart';
import '../objectmodel.dart';
import '../sharedhelpers.dart';
import 'dart:math';
import '../floatingAdd.dart';

class HomeWidget extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeWidget>{
  static Random random = new Random();

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
                itemCount: events.length, //eventGroups[i].events.length,
                itemBuilder: (context, j) {
              //    var events = eventGroups[i].events;
                  return new Dismissible(
                    key: new Key(Helpers.generateUUID()),
                    direction: DismissDirection.endToStart,
                    background: Container(
                      color: Colors.green, 
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
                    child: Card(
                      child: Column(
                        children: <Widget>[
                          ListTile(
                            leading: Icon(events[j].icon, size:50.0),
                            title: Text(events[j].title),
                            subtitle: Text(Helpers.formatDate(events[j].date)),
                          ),
                          Text(
                            'Ideas Completed = ' + events[j].ideasCompleted().toString()
                          ), 
                          ButtonBar(
                            children: <Widget>[
                              FlatButton(
                                textColor: Color.fromARGB(255, 126, 71, 98),
                                child: Text('View Details', style: Theme.of(context).textTheme.subhead),
                                onPressed: (){
                                  //TODO event pressed
                                  showDialog(
                                    context: context,
                                    builder: (context){
                                      return new AlertDialog(
                                        content: Text('event pressed'),
                                      );
                                    }
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                }
              ),
          ),
        ],
      ),
      floatingActionButton: FABAdd(),
    );
  }
}