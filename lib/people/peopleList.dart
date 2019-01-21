import 'package:flutter/material.dart';
import '../shared/sharedhelpers.dart';
import '../model/person.dart';
import 'personpage.dart';

class PeopleList extends StatelessWidget {
  final List<Person> people;

  PeopleList({Key key, this.people}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
              itemCount: people.length,
              gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemBuilder: (context, index) {
                return new GestureDetector(
                  child: new Card(
                    elevation: 5.0,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 10.0),
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).unselectedWidgetColor,
                            child: Text(Helpers.getInitials(people[index].name)),
                            minRadius: 60,
                          ),
                        ),
                Text
                (
                  people[index].name,
                  style: Theme.of(context).textTheme.subtitle,
                ),
              ],
            ),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonPage(personName: people[index].name,)),
            );
          },
        );
      },
    );

  }
}