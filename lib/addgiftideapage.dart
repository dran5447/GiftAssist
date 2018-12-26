import 'package:flutter/material.dart';
import 'objectmodel.dart';
import 'giftideaform.dart';


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
          GiftIdeaForm()
        ],
      ),
    );
  }
}