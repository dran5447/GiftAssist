import 'package:json_annotation/json_annotation.dart';

part 'event.g.dart';

//JSON serialization info from https://flutter.io/docs/development/data-and-backend/json

@JsonSerializable()
class Event {
  final String id;
  final int dateInMilli;  //in millisSinceEpoch
  final String title;

  final String description;
  final String eventTypeStrId;
  final int recurring; //false = 0
  int isExpanded;
  final String personId;

  Event(this.id, this.dateInMilli, this.title, [this.description='', this.eventTypeStrId = '', 
      this.recurring = 0, this.isExpanded = 0, this.personId]);

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  bool ideasCompleted(){
  //   if(ideas.length > 0) {
  //     for(int i=0; i<ideas.length; i++){
  //       if(!ideas[i].done){
  //         return false;
  //       }
  //     }
  //     return true;
  //   }
    return true;
   }
}

class EventDateGroup{
  final String formattedDate;
  final List<Event> events;

  EventDateGroup(this.formattedDate, this.events);
}