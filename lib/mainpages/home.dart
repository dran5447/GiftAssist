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

  //TODO get a limited number of upcoming global events
  Future<List<Event>> getEvents() async{
    var result = await DBProvider.db.getAllEvents();
    return result;
  }

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
          new Expanded(
            child: FutureBuilder<List<Event>>(
              future: getEvents(),
              builder: (context, snapshot) {
                if (snapshot.hasError) print(snapshot.error);
            
                return snapshot.hasData && snapshot.data.length > 0
                    ?   ListView.builder(
                          physics: ClampingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data.length,
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

                                Event tempDismissedEvent =snapshot.data[j];
                                setState(() {
                                  snapshot.data.remove(tempDismissedEvent);
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
                                          snapshot.data.insert(j,tempDismissedEvent);
                                        });
                                    },
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackbar);
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.0),
                                child: EventSummaryCard(snapshot.data[j]),
                              ),
                            );
                          }
                        )
                    // ?  ListView.builder(
                    //       itemCount: snapshot.data.length,
                    //       itemBuilder: (context, index) {
                    //         var item = snapshot.data[index];
                    //         return new ExpansionTile(
                    //           initiallyExpanded: item.isExpanded==1,
                    //           key: PageStorageKey<Event>(item),
                    //           leading: Text(
                    //             item.title,
                    //             style: Theme.of(context).textTheme.title,
                    //           ),
                    //           title: Text(
                    //             '(' + Helpers.formatDate(Helpers.getEventDateTime(item)) + ')',
                    //             style: Theme.of(context).textTheme.subtitle,
                    //           ),
                    //         );          
                    //       },
                    //     )
                    : Padding(
                        padding: EdgeInsets.all(20.0),
                        child:Center(
                            child: Text("None addded. Create a Person and then add Events.")
                        )
                      );
              }
            )
          ),
        ],
      ),
      floatingActionButton: FABAddIdea(person: null),
    );
  }
}