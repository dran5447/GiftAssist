// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Person _$PersonFromJson(Map<String, dynamic> json) {
  return Person(
      json['id'] as String,
      json['name'] as String,
      (json['events'] as List)
          ?.map((e) =>
              e == null ? null : Event.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      (json['unassignedIdeas'] as List)
          ?.map((e) =>
              e == null ? null : Idea.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$PersonToJson(Person instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'events': instance.events,
      'unassignedIdeas': instance.unassignedIdeas
    };
