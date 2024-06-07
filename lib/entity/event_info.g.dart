// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventInfo _$EventInfoFromJson(Map<String, dynamic> json) => EventInfo(
      eventID: json['eventID'] as String,
      title: json['title'] as String,
      dateTime: DateTime.parse(json['dateTime'] as String),
      repeatFor: (json['repeatFor'] as num?)?.toInt(),
    );

Map<String, dynamic> _$EventInfoToJson(EventInfo instance) => <String, dynamic>{
      'eventID': instance.eventID,
      'title': instance.title,
      'dateTime': instance.dateTime.toIso8601String(),
      'repeatFor': instance.repeatFor,
    };
