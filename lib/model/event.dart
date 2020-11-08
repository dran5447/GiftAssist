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
  int completed;
  int isExpanded;
  final String personId;

  Event(this.id, this.dateInMilli, this.title, [this.description='', this.eventTypeStrId = '', 
      this.recurring = 0, this.isExpanded = 0, this.personId, this.completed=0]);

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'dateInMilli': dateInMilli,
      'title': title,
      'description': description,
      'eventTypeStrId': eventTypeStrId,
      'recurring': recurring,
      'completed': completed,
      'isExpanded': isExpanded,
      'personId': personId,
    };
  }
}

class EventDateGroup{
  final String formattedDate;
  final List<Event> events;

  EventDateGroup(this.formattedDate, this.events);
}