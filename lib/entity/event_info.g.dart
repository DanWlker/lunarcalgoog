// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventInfo _$EventInfoFromJson(Map<String, dynamic> json) => EventInfo(
      title: json['title'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      eventID: json['eventID'] as String,
      repeatFor: (json['repeatFor'] as num?)?.toInt() ?? 1,
    );

Map<String, dynamic> _$EventInfoToJson(EventInfo instance) => <String, dynamic>{
      'title': instance.title,
      'dateTime': instance.dateTime.toIso8601String(),
      'repeatFor': instance.repeatFor,
      'eventID': instance.eventID,
    };
