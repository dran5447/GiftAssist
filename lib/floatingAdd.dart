import 'package:flutter/material.dart';
import 'sharedhelpers.dart';

class FABAdd extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Helpers.navigateToAddAndReturnResult(context);
      }, backgroundColor: Color.fromARGB(255, 76, 66, 74),
      tooltip: 'Quick Add Gift Idea',
      child: Icon(Icons.add),
    );
 }
}