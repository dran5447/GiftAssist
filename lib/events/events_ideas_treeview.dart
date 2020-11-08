import 'package:flutter/material.dart';
import '../model/event.dart';
import '../model/person.dart';
import '../shared/sharedhelpers.dart';
import '../shared/datastore.dart';
import 'eventSummaryCard.dart';

class EventIdeasTreeWidget extends StatelessWidget {
  final Person person;

  EventIdeasTreeWidget({Key key, this.person}) : super(key: key);

  Future<List<Event>> getEvents() async{
    var result = await DBProvider.db.getEventsForPerson(person);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: FutureBuilder<List<Event>>(
        future: getEvents(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
       
          return snapshot.hasData && snapshot.data.length > 0
              ?  ListView.builder(
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0),
                        child: EventSummaryCard(snapshot.data[index]),
                      );
                    },
                  )
              : Padding(
                  padding: EdgeInsets.all(20.0),
                  child:Center(
                      child: Text("No Events added. Click the Menu dial bottom right to add Events and Ideas.")
                  )
                );
        },
      ),
    );
  }
}