import 'package:intl/intl.dart';
import '../model/idea.dart';
import '../model/event.dart';
import '../model/person.dart';
import '../ideas/addgiftideapage.dart';
import '../people/addpersonpage.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class Helpers{

  static Color primary = Color.fromARGB(255, 5, 32, 74);
  static Color secondary = Color.fromARGB(255, 31, 122, 140);
  static Color complement = Color.fromARGB(255, 43, 25, 61);
  static Color neutralDark = Color.fromARGB(255, 56, 63, 81);
  static Color neutralLight = Color.fromARGB(255, 196, 125, 135);


  // TEMPORARY HELPERS
  static List<Event> getTempEventsList(){
    final List<Event> events = [
      new Event(new DateTime(2018, 12, 25), 'Christmas', 'ho ho ho', EventType.WINTER_HOLIDAY, getTempIdeasList2(), true),
      new Event(new DateTime(2018, 12, 26), 'Boxing Day', 'monies', EventType.FOOD_OUTING, getTempIdeasList1()),
      new Event(new DateTime(2018, 12, 31), 'New Years Eve', '3-2-1',EventType.OTHER, getTempIdeasList2()),
      new Event(new DateTime(2019, 1, 1), 'New Years Day', 'new year new you, dont fuck oop',EventType.OTHER, getTempIdeasList1()),
      new Event(new DateTime(2019, 1, 3), 'Mike bday', 'woop woop',EventType.BIRTHDAY, getTempIdeasList1()),
      new Event(new DateTime(2019, 2, 4), 'Valentines Day', '',EventType.VALENTINES, getTempIdeasList1()),
    ];
    return events;
  }

  static List<Idea> getTempIdeasList1(){
    final List<Idea> ideas = [
      new Idea('adsfadsf','Something Cool', 'something cool', 'www.amazon.com', true),
    ];
    return ideas;
  }

  static List<Idea> getTempIdeasList2(){
    final List<Idea> ideas = [
      new Idea('adsfadsf','Water', '', 'www.amazon.com'),
      new Idea('adsfadsf','Baseball', '', ''),
    ];
    return ideas;
  }

  // END TEMP HELPERS

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
      if(events[i].date != events[i-1].date){
        List<Event>  temp = new List.from(currentDateEventList);
        // currentDateEventList;
        eventGroups.add(new EventDateGroup(Helpers.formatDate(currentDateEventList[0].date), temp));
        currentDateEventList.clear();
        currentDateEventList.add(events[i]);
      }
      else{
        currentDateEventList.add(events[i]);
      }
      if(i == events.length-1){
        var temp = currentDateEventList;
        eventGroups.add(new EventDateGroup(Helpers.formatDate(events[i].date), temp));
      }
    }
    return eventGroups;
  }

  static navigateToAddIdeaAndReturnResult(BuildContext context) async{
    // Navigator.push returns a Future that will complete after we call
    // Navigator.pop on the following screen to feedback success or failure
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddGiftIdeaScreen()),
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


    //TODO add quick add person page
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


  static List<Event> filterPastEvents(List<Event> events){
    List<Event> updated = new List<Event>();

    for(Event e in events){
      if(e.date.difference(DateTime.now()).inDays >= 0){
        updated.add(e);
      }
      else if(e.recurring){
        //TODO add logic for recurring events
      }
    }
    return updated;
  }

  static List<Event> sortEvents(List<Event> events){
    //TODO event sorting
    // var previous = null;
    // for(int i=1; i<events.length; i++){

    //   if(previous != null){

    //   }
    // }
  }

  static String getInitials(String name){
    var nameList = name.split(" ");
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