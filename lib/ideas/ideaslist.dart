import 'package:flutter/material.dart';
import '../model/idea.dart';


class UncategorizedIdeasList extends StatelessWidget {
  final List<Idea> ideas;
  bool isCompact = false;

  UncategorizedIdeasList({Key key, this.ideas, this.isCompact = false}) : super(key: key);

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: Colors.blue[500],
    ),
  );

  @override
  Widget build(BuildContext context) {

    return ListView.builder(
        shrinkWrap: true,
        itemCount: ideas.length,
        itemBuilder: (context, index) {
          return Card(
              elevation: 3.0,
            child: ListTile(
              tileColor: Colors.white,
                isThreeLine: !isCompact && (ideas[index].description != "") && (ideas[index].website != "") ? true : false,
                dense: isCompact? true : false,
                title: Text(ideas[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                    )),
                subtitle: !isCompact ? Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (ideas[index].description != "")
                      Text("Description: " + ideas[index].description, maxLines: 1, overflow: TextOverflow.ellipsis,),
                    if (ideas[index].website != "")
                      Text("Website: " + ideas[index].website, maxLines: 1, overflow: TextOverflow.clip, softWrap: false,),
                  ],
                ) : null ,
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  showDialog(
                    context: context,
                      builder: (context){
                        return AlertDialog(
                          title: Text('TODO show item details page w updating options'),
                        );
                      });
                },
            )
          );}
    );
  }
}