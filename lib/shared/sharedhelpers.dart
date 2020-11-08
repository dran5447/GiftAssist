import 'package:intl/intl.dart';
import '../model/event.dart';
import '../model/person.dart';
import '../ideas/addgiftideapage.dart';
import '../people/addpersonpage.dart';
import '../events/addeventpage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Helpers{

  static Color primary = Color.fromARGB(255, 5, 32, 74);
  static Color secondary = Color.fromARGB(255, 31, 122, 140);
  static Color complement = Color.fromARGB(255, 43, 25, 61);
  static Color neutralDark = Color.fromARGB(255, 56, 63, 81);
  static Color neutralLight = Color.fromARGB(255, 196, 125, 135);

  static final Map<String,IconData> iconStringMap  = 
  {
    'Birthday' : Icons.cake,
    'Graduation' : Icons.school,
    'Winter Holiday' : Icons.ac_unit,
    'Housewarming' : Icons.home,
    'Baby Shower' : Icons.child_friendly,
    'Valentines' : Icons.favorite_border,
    'Party' : Icons.people,
    'Food' : Icons.restaurant,
    'Promotion' : Icons.work,
    'Wedding' : Icons.all_inclusive,
    'Anniversary' : Icons.favorite,
    'Other' : Icons.card_giftcard
  };

  static DateTime getEventDateTime(Event e){
    DateTime date = new DateTime.fromMillisecondsSinceEpoch(e.dateInMilli);
    return date;
  }

  static String generateUUID(){
    var length = 20;
    var str = '';

    for(int i=0; i< length; i++){
      str += new Random().nextInt(9).toString();
    }
    return str;
  }

  static List<EventDateGroup> getEventGroupingsByDate(List<Event> events){
    List<EventDateGroup> eventGroups = [];

    //Assume for now they are sorted at this point
    //TODO sort

    List<Event> currentDateEventList = [];
    currentDateEventList.add(events[0]);
    for(int i=1; i<events.length; i++){
      if(events[i].dateInMilli != events[i-1].dateInMilli){
        List<Event>  temp = new List.from(currentDateEventList);
        // currentDateEventList;
        eventGroups.add(new EventDateGroup(Helpers.formatDate(getEventDateTime(currentDateEventList[0])), temp));
        currentDateEventList.clear();
        currentDateEventList.add(events[i]);
      }
      else{
        currentDateEventList.add(events[i]);
      }
      if(i == events.length-1){
        var temp = currentDateEventList;
        eventGroups.add(new EventDateGroup(Helpers.formatDate(getEventDateTime(events[i])), temp));
      }
    }
    return eventGroups;
  }

  static navigateToAddIdeaAndReturnResult(BuildContext context, Person p) async{
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the following screen to feedback success or failure
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddGiftIdeaScreen(person: p)),
    );

    if (result != null){
      // After result returned hide any previous snackbars and show result
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
    }
    
  }

  static navigateToAddEventAndReturnResult(BuildContext context, Person p) async{
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the following screen to feedback success or failure
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEventScreen(person: p)),
    );

    if (result != null){
      // After result returned hide any previous snackbars and show result
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
    }
    
  }


  static navigateToAddPersonAndReturnResult(BuildContext context) async{
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the following screen to feedback success or failure
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddPersonScreen()),
    );

    if (result != null){
      // After result returned hide any previous snackbars and show result
      Scaffold.of(context).removeCurrentSnackBar();
      Scaffold.of(context).showSnackBar(SnackBar(content: Text("$result")));
    }
    
  }

  static String getInitials(String name){
    var nameList = name.trim().split(" ");
    String initials = '';
    nameList.forEach(
      (element) => initials+=element.substring(0,1)
    );
    return initials;
  }

  static String formatDate(DateTime date){
    var now = DateTime.now();
    var today = new DateTime(now.year, now.month, now.day);

    Duration difference = today.difference(date);

    if (difference.inDays == 0) {
      return "Today";
    } else if (difference.inDays > 0) {
      return "Past";
    } else if (difference.inDays == -1) {
      return "Tomorrow";
    } else if (difference.inDays > -7) {
      switch (date.weekday) {
        case 1:
          return "Monday";
        case 2:
          return "Tuesday";
        case 3:
          return "Wednesday";
        case 4:
          return "Thursday";
        case 5:
          return "Friday";
        case 6:
          return "Saturday";
        case 7:
          return "Sunday";
      }
    } 
    return new DateFormat('MM/dd/yyy').format(date);
  }
}