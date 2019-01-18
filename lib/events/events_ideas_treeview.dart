import 'package:flutter/material.dart';
import '../shared/objectmodel.dart';
import '../shared/sharedhelpers.dart';

class EventIdeasTreeWidget extends StatelessWidget {
  final List<Event> events;

  EventIdeasTreeWidget({this.events});
  
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
      child: ListView.builder(
        itemCount: events.length,
        itemBuilder: (context, index) {
          var item = events[index];
          return new ExpansionTile(
            initiallyExpanded: item.isExpanded,
            key: PageStorageKey<Event>(item),
            leading: Text(
              item.title,
              style: Theme.of(context).textTheme.title,
            ),
            title: Text(
              '(' + Helpers.formatDate(item.date) + ')',
              style: Theme.of(context).textTheme.subtitle,
            ),
            children: item.ideas.map((Idea idea) {
              return Padding(
                padding: EdgeInsets.only(left:50.0, right: 30.0),
                child: GestureDetector(
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
                          child: Text(
                              idea.title,
                              style: Theme.of(context).textTheme.body1,
                          ),
                        ),
                        //TODO indicators or actions
                      ],
                    ),
                  ),
                  onTap: () {
                    //TODO do something meaningful with tapped idea
                    showDialog(
                      context: context,
                      builder: (context){
                        return new AlertDialog(
                          content: Text('tapped idea'),
                        );
                      }
                    );
                  },
                ),
              );
            }).toList(),
          );          
        },
      ),
    );
  }
}