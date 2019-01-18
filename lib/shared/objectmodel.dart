import 'package:flutter/material.dart';

class Idea {
  final String title;
  final String description;
  final String website;
  final bool done;

  Idea(this.title, this.description, [this.website = '', this.done = false]);  
}

class Event {
  final DateTime date;
  final String title;
  final String description;
  
  final EventType eventType;
  final bool recurring;
  final List<Idea> ideas;
  bool isExpanded;

  IconData icon;

  Event(this.date, this.title, this.description, [this.eventType = EventType.OTHER, this.ideas, this.recurring = false, this.isExpanded = false]){
      icon = eventIconMap[eventType];
  }

  Map<EventType, IconData> eventIconMap = {
    EventType.BIRTHDAY: (Icons.cake), 
    EventType.GRADUATION: (Icons.school),
    EventType.WINTER_HOLIDAY: (Icons.ac_unit),
    EventType.HOUSEWARMING: (Icons.home),
    EventType.BABY_SHOWER: (Icons.child_friendly), 
    EventType.VALENTINES: (Icons.favorite_border),
    EventType.PARTY: (Icons.people),
    EventType.PROMOTION: (Icons.work),
    EventType.FOOD_OUTING: (Icons.restaurant),
    EventType.WEDDING: (Icons.all_inclusive),
    EventType.ANNIVERSARY: (Icons.favorite),
    EventType.OTHER: (Icons.card_giftcard),
  };

  bool ideasCompleted(){
    if(ideas.length > 0) {
      for(int i=0; i<ideas.length; i++){
        if(!ideas[i].done){
          return false;
        }
      }
      return true;
    }
    return true;
  }
}

enum EventType { BIRTHDAY, GRADUATION, WINTER_HOLIDAY, HOUSEWARMING, BABY_SHOWER, 
                  VALENTINES, PARTY, PROMOTION, FOOD_OUTING, WEDDING, ANNIVERSARY, OTHER}

class EventDateGroup{
  final String formattedDate;
  final List<Event> events;

  EventDateGroup(this.formattedDate, this.events);
}


class Person {
  final String name;
  final List<Event> events;
  final List<Idea> unassignedIdeas;

  Person(this.name, this.events, this.unassignedIdeas);
}