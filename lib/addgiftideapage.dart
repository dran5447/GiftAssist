import 'package:flutter/material.dart';
import 'objectmodel.dart';


class AddGiftIdeaScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Column(
        children: <Widget>[
          Text(
            'New Gift Idea',
            style: Theme.of(context).textTheme.headline,
          ),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  //Confirm changes lost
                    showDialog(
                      barrierDismissible: false,
                      context: context,
                      child: new SimpleDialog(
                        title: new Column(
                          children: <Widget>[
                            new Text("GridView"),
                            new Icon(
                              Icons.favorite,
                              color: Colors.green,
                            ),
                          ],
                        ),
                        children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () 
                              {  
                                //TODO navigate away
                                //Navigator.pop(context, Department.treasury); 
                              },
                              child: const Text('Confirm'),
                            ),
                            SimpleDialogOption(
                              onPressed: () { Navigator.pop(context); },
                              child: const Text('Cancel'),
                            ),
                          ],
                      ),
                    );
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Create'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}