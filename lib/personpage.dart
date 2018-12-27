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

  final List<Idea> ideas = Helpers.getTempIdeasList1();
  final List<Event> events = Helpers.getTempEventsList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About'),
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
              style: Theme.of(context).textTheme.subhead,
              textAlign: TextAlign.left,
            ),
          ),
          new Expanded(
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
                    '(' + Helpers.informalDate(item.date) + ', ' + Helpers.simplifyDate(item.date) + ')',
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
                          //TODO idea tapped
                        },
                      ),
                    );
                  }).toList(),
                );          
              },
            ),
          ),
        ]
      ),
    );
  }
}