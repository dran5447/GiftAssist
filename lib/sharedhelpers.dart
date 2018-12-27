import 'package:intl/intl.dart';
import 'objectmodel.dart';
import 'addgiftideapage.dart';
import 'package:flutter/material.dart';

class Helpers{

  // TEMPORARY HELPERS
  static List<Event> getTempEventsList(){
    final List<Event> events = [
      new Event(new DateTime(2018, 12, 25), 'Christmas', 'ho ho ho', getTempIdeasList2(), true),
      new Event(new DateTime(2018, 12, 26), 'Boxing Day', 'monies', getTempIdeasList1()),
      new Event(new DateTime(2018, 12, 27), 'Someones bday maybe', 'n/a', getTempIdeasList2()),
      new Event(new DateTime(2018, 12, 28), 'Someones bday????', 'n/a', getTempIdeasList2()),
      new Event(new DateTime(2018, 12, 31), 'New Years Eve', '3-2-1', getTempIdeasList2()),
      new Event(new DateTime(2019, 1, 1), 'New Years Day', 'new year new you, dont fuck oop', getTempIdeasList1()),
      new Event(new DateTime(2019, 1, 3), 'Mike bday', 'woop woop', getTempIdeasList1()),
    ];
    return events;
  }

  static List<Idea> getTempIdeasList1(){
    final List<Idea> ideas = [
      new Idea('Gift Idea 1', 'something cool', 'www.amazon.com'),
    ];
    return ideas;
  }

  static List<Idea> getTempIdeasList2(){
    final List<Idea> ideas = [
      new Idea('Gift Idea 1', 'something cool', 'www.amazon.com'),
      new Idea('Gift Idea 2', 'asdf', ''),
    ];
    return ideas;
  }

  static List<Person> getTempPeopleList(){
    final List<Person> people = [
      new Person('Mike', getTempEventsList(), getTempIdeasList1()),
    ];
    return people;
  }

  // END TEMP HELPERS

  static NavigateToAddAndReturnResult(BuildContext context) async{
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