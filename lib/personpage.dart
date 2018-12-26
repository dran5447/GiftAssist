import 'package:flutter/material.dart';
import 'objectmodel.dart';
import 'sharedhelpers.dart';


class PersonPage extends StatefulWidget {
  final String personName;
  
  PersonPage({Key key, this.personName}) : super(key: key);

  @override
  _IdeasState createState() => _IdeasState(personName: personName);
}

class _IdeasState extends State<PersonPage> {
  final String personName;
  
  _IdeasState({Key key, this.personName});

  final List<Idea> todos = List<Idea>.generate(
    20,
    (i) => Idea(
          'Idea $i',
          'A description for $i',
        ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About ' + personName),
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
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          Divider(),
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              'Gift Ideas',
              style: Theme.of(context).textTheme.headline,
            ),
          ),
          new Expanded(
            child: ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Icon
                  (
                    Icons.card_giftcard, 
                    size:40,
                  ),
                  title: Text(todos[index].title),
                  subtitle: Text(todos[index].description),
                  isThreeLine: true,
                  onTap: () { /* react to the tile being tapped */ },
                );
              },
            ),
          ),
        ]
      ),
    );
  }
}