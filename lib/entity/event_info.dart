import 'package:json_annotation/json_annotation.dart';

part 'event_info.g.dart';

@JsonSerializable()
class EventInfo {
  EventInfo({
    required this.title,
    required this.dateTime,
    required this.repeatFor,
    this.eventID,
    // this.yearModified,
  });

  factory EventInfo.fromJson(Map<String, dynamic> json) =>
      _$EventInfoFromJson(json);

  Map<String, dynamic> toJson() => _$EventInfoToJson(this);

  String title;
  DateTime dateTime;
  int? repeatFor;
  String? eventID;
  // int yearModified;
}
