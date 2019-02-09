// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
      json['id'] as String,
      json['dateInMilli'] as int,
      json['title'] as String,
      json['description'] as String,
      json['eventTypeStrId'] as String,
      json['recurring'] as int,
      json['isExpanded'] as int,
      json['personId'] as String);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'dateInMilli': instance.dateInMilli,
      'title': instance.title,
      'description': instance.description,
      'eventTypeStrId': instance.eventTypeStrId,
      'recurring': instance.recurring,
      'isExpanded': instance.isExpanded,
      'personId': instance.personId
    };
