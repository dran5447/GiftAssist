import 'package:intl/intl.dart';
import 'objectmodel.dart';

class Helpers{

  // TEMPORARY HELPERS
  static List<Event> getTempEventsList(){
    final List<Event> events = [
      new Event(new DateTime(2018, 12, 25), 'Christmas', 'ho ho ho', getTempIdeasList2(), true),
      new Event(new DateTime(2018, 12, 26), 'Boxing Day', 'monies', getTempIdeasList1()),
      new Event(new DateTime(2018, 12, 27), 'Someones bday maybe', 'n/a', getTempIdeasList2()),
      new Event(new DateTime(2018, 12, 31), 'New Years Eve', '3-2-1', getTempIdeasList2()),
      new Event(new DateTime(2019, 1, 1), 'New Years Day', 'new year new you, dont fuck oop', getTempIdeasList1()),
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

  static String getInitials(String name){
    var nameList = name.split(" ");
    String initials = '';
    nameList.forEach(
      (element) => initials+=element.substring(0,1)
    );
    return initials;
  }

  static String simplifyDate(DateTime date){
    return new DateFormat('MM/dd/yyy').format(date);
  }

  static String informalDate(DateTime date){
    var today = DateTime.now();

    String month;
      switch (date.month) {
        case 1:
          month = "January";
          break;
        case 2:
          month = "February";
          break;
        case 3:
          month = "March";
          break;
        case 4:
          month = "April";
          break;
        case 5:
          month = "May";
          break;
        case 6:
          month = "June";
          break;
        case 7:
          month = "July";
          break;
        case 8:
          month = "August";
          break;
        case 9:
          month = "September";
          break;
        case 10:
          month = "October";
          break;
        case 11:
          month = "November";
          break;
        case 12:
          month = "December";
          break;
      }

    Duration difference = today.difference(date);

    //TODO this may still be iffy..need to verify hours/days logic
    if (difference.inDays == 0 &&  difference.inHours < -24) {
      return "Today";
    } else if (difference.inDays > 0) {
      return "Past";
    } else if (difference.inDays < -2 && difference.inHours >= -48) {
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
          return "Thurdsday";
        case 5:
          return "Friday";
        case 6:
          return "Saturday";
        case 7:
          return "Sunday";
      }
    } else if (date.year == today.year) {
      return '${date.day} $month';
    } else {
      return '${date.day} $month ${date.year}';
    }
    return "";
  }
}