// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'idea.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Idea _$IdeaFromJson(Map<String, dynamic> json) {
  return Idea(json['title'] as String, json['description'] as String,
      json['website'] as String, json['done'] as bool);
}

Map<String, dynamic> _$IdeaToJson(Idea instance) => <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'website': instance.website,
      'done': instance.done
    };