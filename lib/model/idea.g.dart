// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Idea _$IdeaFromJson(Map<String, dynamic> json) {
  return Idea(
      json['id'] as String,
      json['title'] as String,
      json['description'] as String,
      json['website'] as String,
      json['done'] as int,
      json['eventId'] as String,
      json['uncategorizedPersonId'] as String);
}

Map<String, dynamic> _$IdeaToJson(Idea instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'website': instance.website,
      'done': instance.done,
      'eventId': instance.eventId,
      'uncategorizedPersonId': instance.uncategorizedPersonId
    };
