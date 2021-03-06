import 'package:flutter/material.dart';
import '../model/idea.dart';
import '../model/person.dart';
import 'ideaslist.dart';
import '../shared/datastore.dart';

class IdeasListBuilder extends StatelessWidget {
  final Person person;

  IdeasListBuilder({Key key, this.person}) : super(key: key);

  Future<List<Idea>> getIdeas() async{
    var result = await DBProvider.db.getIdeasForPerson(person);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return new Expanded(
      child: FutureBuilder<List<Idea>>(
        future: getIdeas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);

          return snapshot.hasData && snapshot.data.length > 0
              ? UncategorizedIdeasList(ideas: snapshot.data)
              : Padding(
                  padding: EdgeInsets.all(20.0),
                  child:Center(
                      child: Text("None addded. Click the Plus sign in the bottom right to add an Idea.")
                  )
                );
        },
      ),
    );
  }
}