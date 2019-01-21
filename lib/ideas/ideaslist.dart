import 'package:flutter/material.dart';
import '../model/idea.dart';
import '../model/person.dart';


class UncategorizedIdeasList extends StatelessWidget {
  final List<Idea> ideas;

  UncategorizedIdeasList({Key key, this.ideas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(
              itemCount: ideas.length,
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
                            child: Text(ideas[index].title),
                            minRadius: 60,
                          ),
                        ),
              ],
            ),
          ),
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => PersonPage(personName: people[index].name,)),
            // );
          },
        );
      },
    );

  }
}