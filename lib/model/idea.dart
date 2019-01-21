import 'package:json_annotation/json_annotation.dart';

//JSON serialization info from https://flutter.io/docs/development/data-and-backend/json

/// This allows the `<Class>` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'idea.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class Idea {
  final String title;
  final String description;
  final String website;
  final bool done;

  Idea(this.title, this.description, [this.website = '', this.done = false]);  

  /// A necessary factory constructor for creating a new Idea instance
  /// from a map. Pass the map to the generated `_$IdeaFromJson()` constructor.
  /// The constructor is named after the source class, in this case User.
  factory Idea.fromJson(Map<String, dynamic> json) => _$IdeaFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$IdeaToJson`.
  Map<String, dynamic> toJson() => _$IdeaToJson(this);
}