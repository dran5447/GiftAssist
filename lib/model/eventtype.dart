import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'eventtype.g.dart';

//JSON serialization info from https://flutter.io/docs/development/data-and-backend/json

@JsonSerializable()
class EventType{
  final int id;
  final String name;
  final int iconDataCodePoint;

  EventType(this.id, this.name, this.iconDataCodePoint);

  factory EventType.fromJson(Map<String, dynamic> json) => _$EventTypeFromJson(json);
  Map<String, dynamic> toJson() => _$EventTypeToJson(this);
}
