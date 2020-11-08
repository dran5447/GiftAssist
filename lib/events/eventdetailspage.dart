import 'package:flutter/material.dart';
import 'package:gift_assist/ideas/ideaslist.dart';
import 'package:gift_assist/model/idea.dart';
import 'package:gift_assist/shared/datastore.dart';
import 'package:gift_assist/shared/sharedhelpers.dart';
import '../model/event.dart';

class EventDetailPage extends StatefulWidget {
  final Event event;
  
  EventDetailPage({Key key, this.event}) : super(key: key);

  @override
  _EventDetailState createState() => _EventDetailState(event: event);
}

class _EventDetailState extends State<EventDetailPage> {
  final Event event;
  
  _EventDetailState({Key key, this.event});

  Future<List<Idea>> getIdeas() async{
    var result = await DBProvider.db.getIdeasForEvent(event);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       //   leading:
          title: Row(
            children: [
              Icon(Helpers.iconStringMap[event.eventTypeStrId], size:30.0),
              new Padding(padding: EdgeInsets.only(left: 15), child: Text(event.title))
            ],
          ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 30.0, horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Date: " + Helpers.formatDate(Helpers.getEventDateTime(event))),
                if (event.description != "")
                  Text("Description: " + event.description),
                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        'Arrived',
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        ' (Ready to gift)',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: FutureBuilder<List<Idea>>(
                    future: getIdeas(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData && snapshot.data.length > 0
                          ? UncategorizedIdeasList(ideas: snapshot.data, isCompact: true)
                          : Padding(
                          padding: EdgeInsets.all(20.0),
                          child:Center(
                              child: Text("None added yet")
                          )
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    children: [
                      Text(
                        'Purchased',
                        style: TextStyle(
                          color: Colors.lightBlue,
                          fontWeight: FontWeight.w500,
                          fontSize: 20,),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        ' (Bought, awaiting arrival)',
                        style: Theme.of(context).textTheme.caption,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: FutureBuilder<List<Idea>>(
                    future: getIdeas(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) print(snapshot.error);
                      return snapshot.hasData && snapshot.data.length > 0
                          ? UncategorizedIdeasList(ideas: snapshot.data)
                          : Padding(
                          padding: EdgeInsets.all(20.0),
                          child:Center(
                              child: Text("None added yet")
                          )
                      );
                    },
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 20, bottom: 10.0),
                  child: Text(
                    'Ideas',
                    style: Theme.of(context).textTheme.title,
                    textAlign: TextAlign.left,
                  ),
                ),
                Flexible(
                  fit: FlexFit.loose,
                  child: FutureBuilder<List<Idea>>(
                      future: getIdeas(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) print(snapshot.error);
                        return snapshot.hasData && snapshot.data.length > 0
                            ? UncategorizedIdeasList(ideas: snapshot.data)
                            : Padding(
                              padding: EdgeInsets.all(20.0),
                              child:Center(
                                child: Text("None added yet")
                              )
                        );
                      },
                    ),
                  ),
                ],
              ), //padding: EdgeInsets.only(right: 30.0)
            ),
          ],
        ),
      );
  }
}