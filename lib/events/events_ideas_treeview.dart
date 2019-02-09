import 'package:flutter/material.dart';
import '../model/event.dart';
import '../model/person.dart';
import '../shared/sharedhelpers.dart';
import '../shared/datastore.dart';

class EventIdeasTreeWidget extends StatelessWidget {
  final Person person;

  EventIdeasTreeWidget({Key key, this.person}) : super(key: key);

  Future<List<Event>> getEvents() async{
    var result = await DBProvider.db.getEventsForPerson(person);
    return result;
  }
  
  //_IdeasState({Key key, this.personName});

  // Widget _buildTiles(Entry root) {
  //   if (root.children.isEmpty) return ListTile(title: Text(root.title));
  //   return ExpansionTile(
  //     key: PageStorageKey<Entry>(root),
  //     title: Text(root.title),
  //     children: root.children.map(_buildTiles).toList(),
  //   );
  // }


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
                      var item = snapshot.data[index];
                      return new ExpansionTile(
                        initiallyExpanded: item.isExpanded==1,
                        key: PageStorageKey<Event>(item),
                        leading: Text(
                          item.title,
                          style: Theme.of(context).textTheme.title,
                        ),
                        title: Text(
                          '(' + Helpers.formatDate(Helpers.getEventDateTime(item)) + ')',
                          style: Theme.of(context).textTheme.subtitle,
                        ),
                        // children: item.ideas.map((Idea idea) {
                        //   return Padding(
                        //     padding: EdgeInsets.only(left:50.0, right: 30.0),
                        //     child: GestureDetector(
                        //       child: Card(
                        //         child: Row(
                        //           mainAxisAlignment: MainAxisAlignment.start,
                        //           children: <Widget>[
                        //             Padding(
                        //               padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                        //               child: Text(
                        //                   idea.title,
                        //                   style: Theme.of(context).textTheme.body1,
                        //               ),
                        //             ),
                        //             // indicators or actions
                        //           ],
                        //         ),
                        //       ),
                        //       onTap: () {
                        //         // do something meaningful with tapped idea
                        //         showDialog(
                        //           context: context,
                        //           builder: (context){
                        //             return new AlertDialog(
                        //               content: Text('tapped idea'),
                        //             );
                        //           }
                        //         );
                        //       },
                        //     ),
                        //   );
                        // }).toList(),
                      );          
                    },
                  )   
              
              
         //     UncategorizedIdeasList(ideas: snapshot.data)
              : Padding(
                  padding: EdgeInsets.all(20.0),
                  child:Center(
                      child: Text("None addded. Click the Plus sign in the bottom right to add Events and Ideas.")
                  )
                );
        },
      ),
    );


    // return new Expanded(
    //   child: ListView.builder(
    //     itemCount: events.length,
    //     itemBuilder: (context, index) {
    //       var item = events[index];
    //       return new ExpansionTile(
    //         initiallyExpanded: item.isExpanded,
    //         key: PageStorageKey<Event>(item),
    //         leading: Text(
    //           item.title,
    //           style: Theme.of(context).textTheme.title,
    //         ),
    //         title: Text(
    //           '(' + Helpers.formatDate(Helpers.getEventDateTime(item)) + ')',
    //           style: Theme.of(context).textTheme.subtitle,
    //         ),
            // children: item.ideas.map((Idea idea) {
            //   return Padding(
            //     padding: EdgeInsets.only(left:50.0, right: 30.0),
            //     child: GestureDetector(
            //       child: Card(
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.start,
            //           children: <Widget>[
            //             Padding(
            //               padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            //               child: Text(
            //                   idea.title,
            //                   style: Theme.of(context).textTheme.body1,
            //               ),
            //             ),
            //             // indicators or actions
            //           ],
            //         ),
            //       ),
            //       onTap: () {
            //         // do something meaningful with tapped idea
            //         showDialog(
            //           context: context,
            //           builder: (context){
            //             return new AlertDialog(
            //               content: Text('tapped idea'),
            //             );
            //           }
            //         );
            //       },
            //     ),
            //   );
            // }).toList(),
    //       );          
    //     },
    //   ),
    // );
  }
}