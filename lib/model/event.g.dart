// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
      json['dateInMilli'] as int,
      json['title'] as String,
      json['description'] as String,
      json['eventTypeId'] as int,
      json['recurring'] as int,
      json['isExpanded'] as int,
      json['personId'] as String);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'dateInMilli': instance.dateInMilli,
      'title': instance.title,
      'description': instance.description,
      'eventTypeId': instance.eventTypeId,
      'recurring': instance.recurring,
      'isExpanded': instance.isExpanded,
      'personId': instance.personId
    };
