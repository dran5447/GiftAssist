import 'package:flutter/material.dart';
import '../ideas/giftideaform.dart';
import '../shared/sharedhelpers.dart';

class AddPersonScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Helpers.neutralLight,
        title: Text('Add Person'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10),
            child: Text(
              "TODO info",
            ),
          ),    
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 20),
          //   child: GiftIdeaForm()
          // ),
        ],
      ),
    );
  }
}