import 'package:flutter/material.dart';
import 'addgiftideapage.dart';
import 'objectmodel.dart';


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
        title: Text('Gift Assist for ' + widget.personName),
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
                    backgroundColor: Colors.tealAccent.shade700,
                    child: Text(getInitials(widget.personName)),
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
          //TODO add key dates section here
          Divider(),
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

  String getInitials(String name){
    var nameList = name.split(" ");
    String initials = '';
    nameList.forEach(
      (element) => initials+=element.substring(0,1)
    );
    return initials;
  }
}