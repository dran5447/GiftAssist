// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'eventtype.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventType _$EventTypeFromJson(Map<String, dynamic> json) {
  return EventType(json['id'] as int, json['name'] as String,
      json['iconDataCodePoint'] as int);
}

Map<String, dynamic> _$EventTypeToJson(EventType instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'iconDataCodePoint': instance.iconDataCodePoint
    };
