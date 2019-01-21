import 'package:flutter/material.dart';
import 'personform.dart';
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
              "Add some 'PERSONal' details ;)",
            ),
          ),    
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: PersonForm()
          ),
        ],
      ),
    );
  }
}