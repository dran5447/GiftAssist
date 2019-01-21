import 'package:json_annotation/json_annotation.dart';
import 'idea.dart';
import 'event.dart';

part 'person.g.dart';

@JsonSerializable()
class Person {
  final String name;
  final List<Event> events;
  final List<Idea> unassignedIdeas;

  Person(this.name, [this.events, this.unassignedIdeas]);

  factory Person.fromJson(Map<String, dynamic> json) => _$PersonFromJson(json);
  Map<String, dynamic> toJson() => _$PersonToJson(this);
}