import 'package:flutter/material.dart';
import '../shared/sharedhelpers.dart';
import '../model/person.dart';
import 'eventform.dart';

class AddEventScreen extends StatelessWidget {
  final Person person;

  AddEventScreen({Key key, this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding:false,
      appBar: AppBar(
        backgroundColor: Helpers.neutralDark,
        title: Text('New Event'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, bottom: 10, left: 20),
            child: Text(
              "Fill in some event information below.",
            ),
          ),    
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: EventForm(person: person)
          ),
        ],
      ),
    );
  }
}