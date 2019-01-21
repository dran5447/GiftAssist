import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'idea.dart';

part 'event.g.dart';

enum EventType { BIRTHDAY, GRADUATION, WINTER_HOLIDAY, HOUSEWARMING, BABY_SHOWER, 
                  VALENTINES, PARTY, PROMOTION, FOOD_OUTING, WEDDING, ANNIVERSARY, OTHER}


//JSON serialization info from https://flutter.io/docs/development/data-and-backend/json

@JsonSerializable()
class Event {
  final DateTime date;
  final String title;
  final String description;
  
  final EventType eventType;
  final bool recurring;
  final List<Idea> ideas;
  bool isExpanded;

  Event(this.date, this.title, this.description, [this.eventType = EventType.OTHER, this.ideas, this.recurring = false, this.isExpanded = false]){
  }

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  final Map<EventType, IconData> eventIconMap = {
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

  IconData getIcon(){
    return eventIconMap[this.eventType];
  }

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


class EventDateGroup{
  final String formattedDate;
  final List<Event> events;

  EventDateGroup(this.formattedDate, this.events);
}