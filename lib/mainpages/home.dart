import 'package:flutter/material.dart';
import '../objectmodel.dart';
import '../sharedhelpers.dart';

class HomeWidget extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<HomeWidget>{
  //TODO pass in a limited number of upcoming global events
  final List<EventDateGroup> eventGroups = Helpers.getEventGroupingsByDate(Helpers.filterPastEvents(Helpers.getTempEventsList()));
  

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
              itemCount: eventGroups.length,
              shrinkWrap: true,
              itemBuilder: (context, i) {
                return Column(
                      children: <Widget>[
                        Text(eventGroups[i].formattedDate),
                        ListView.builder(
                          physics: ClampingScrollPhysics(),
                           shrinkWrap: true,
                            itemCount: eventGroups[i].events.length,
                            itemBuilder: (context, j) {
                              var events = eventGroups[i].events;
                              return GestureDetector(
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
                                onHorizontalDragEnd: (DragEndDetails details){
                                  var velocity = details.primaryVelocity;
                                  //TODO add swipe commanding
                                  showDialog(
                                    context: context,
                                    builder: (context){
                                      return new AlertDialog(
                                        content: Text('dragged, velocity = ' + velocity.toString()),
                                      );
                                    }
                                  );
                                },
                              );
                            }
                          ),
                        
                      ],
                    );
              
              },
            ),
          ),
        ],
      ),
    );
  }
}