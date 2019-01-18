import 'package:flutter/material.dart';
import '../shared/sharedhelpers.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class FABAddIdea extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Helpers.navigateToAddIdeaAndReturnResult(context);
      }, backgroundColor: Helpers.secondary,
      tooltip: 'Quick Add Gift Idea',
      child: Align(
        child:Row(
          children: <Widget>[
            Padding(child: Icon(Icons.add,size:15.0), padding: EdgeInsets.only(left: 3),),            
            Icon(Icons.card_giftcard,size:30.0),
          ],
        ),
        alignment: Alignment.center,
      )
    );
 }
}

class FABAddPerson extends StatelessWidget {
 @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Helpers.navigateToAddPersonAndReturnResult(context);
      }, backgroundColor: Helpers.neutralLight,
      tooltip: 'Quick Add Person',
      child: Align(
        child:Row(
          children: <Widget>[
            Padding(child: Icon(Icons.add,size:15.0), padding: EdgeInsets.only(left: 3),),            
            Icon(Icons.person,size:30.0),
          ],
        ),
        alignment: Alignment.center,
      )
    );
 }
}

class FABSpeedDial extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return SpeedDial(
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 22.0),
          curve: Curves.bounceIn,
          tooltip: 'View Quick-Add Menu',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Helpers.primary,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
              child: Icon(Icons.card_giftcard),
              backgroundColor: Helpers.secondary,
              label: 'Add Gift Idea',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: () { 
                Helpers.navigateToAddIdeaAndReturnResult(context);
              }
            ),
            SpeedDialChild(
              child: Icon(Icons.calendar_today),
              backgroundColor: Helpers.neutralDark,
              label: 'Add Event',
              labelStyle: TextStyle(fontSize: 18.0),
              onTap: ()  { 
                //TODO add event tap
                print('SECOND CHILD');
              }
            ),
          ],
        );
  }
}