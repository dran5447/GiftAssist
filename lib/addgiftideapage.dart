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
            'Add Gift Idea for ___PERSON____',
            style: Theme.of(context).textTheme.title,
          ),
          RaisedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Go back!'),
          ),
        ],
      ),
    );
  }
}