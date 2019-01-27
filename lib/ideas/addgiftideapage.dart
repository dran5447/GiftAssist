import 'package:flutter/material.dart';
import 'giftideaform.dart';
import '../shared/sharedhelpers.dart';
import '../model/person.dart';

class AddGiftIdeaScreen extends StatelessWidget {
  final Person person;

  AddGiftIdeaScreen({Key key, this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helpers.secondary,
        title: Text('New Gift Idea'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              "Let's get some details about your new gift idea!",
            ),
          ),    
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: GiftIdeaForm(person: person)
          ),
        ],
      ),
    );
  }
}