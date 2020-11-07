import 'package:flutter/material.dart';
import '../model/idea.dart';


class UncategorizedIdeasList extends StatelessWidget {
  final List<Idea> ideas;

  UncategorizedIdeasList({Key key, this.ideas}) : super(key: key);

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
          return Container(
            color: (index % 2 == 0) ? Colors.grey.shade200 : Colors.white10,
            child: ListTile(
                isThreeLine: true,
                title: Text(ideas[index].title,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 20,
                    )),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Description: " + ideas[index].description, maxLines: 1, overflow: TextOverflow.ellipsis,),
                    if (ideas[index].website != "")
                      Text("Website: " + ideas[index].website, maxLines: 1, overflow: TextOverflow.clip, softWrap: false,),
                  ],
                ),
                trailing: Icon(Icons.keyboard_arrow_right),
                onTap: () {
                  print('test');
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