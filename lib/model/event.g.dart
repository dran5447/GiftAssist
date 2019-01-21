// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) {
  return Event(
      json['date'] == null ? null : DateTime.parse(json['date'] as String),
      json['title'] as String,
      json['description'] as String,
      _$enumDecodeNullable(_$EventTypeEnumMap, json['eventType']),
      (json['ideas'] as List)
          ?.map((e) =>
              e == null ? null : Idea.fromJson(e as Map<String, dynamic>))
          ?.toList(),
      json['recurring'] as bool,
      json['isExpanded'] as bool);
}

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'date': instance.date?.toIso8601String(),
      'title': instance.title,
      'description': instance.description,
      'eventType': _$EventTypeEnumMap[instance.eventType],
      'recurring': instance.recurring,
      'ideas': instance.ideas,
      'isExpanded': instance.isExpanded
    };

T _$enumDecode<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }
  return enumValues.entries
      .singleWhere((e) => e.value == source,
          orElse: () => throw ArgumentError(
              '`$source` is not one of the supported values: '
              '${enumValues.values.join(', ')}'))
      .key;
}

T _$enumDecodeNullable<T>(Map<T, dynamic> enumValues, dynamic source) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source);
}

const _$EventTypeEnumMap = <EventType, dynamic>{
  EventType.BIRTHDAY: 'BIRTHDAY',
  EventType.GRADUATION: 'GRADUATION',
  EventType.WINTER_HOLIDAY: 'WINTER_HOLIDAY',
  EventType.HOUSEWARMING: 'HOUSEWARMING',
  EventType.BABY_SHOWER: 'BABY_SHOWER',
  EventType.VALENTINES: 'VALENTINES',
  EventType.PARTY: 'PARTY',
  EventType.PROMOTION: 'PROMOTION',
  EventType.FOOD_OUTING: 'FOOD_OUTING',
  EventType.WEDDING: 'WEDDING',
  EventType.ANNIVERSARY: 'ANNIVERSARY',
  EventType.OTHER: 'OTHER'
};
