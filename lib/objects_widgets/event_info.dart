import 'dart:convert';

class EventInfo {
  EventInfo({this.eventID, this.title, this.dateTime, this.repeatFor, this.yearModified});

  factory EventInfo.fromJson(Map<String, dynamic> jsonData) {
    return EventInfo(
      eventID: jsonData['eventID'],
      title: jsonData['title'],
      dateTime: DateTime.parse(jsonData['dateTime']),
      repeatFor: int.parse(jsonData['repeatFor']),
      yearModified: int.parse(jsonData['yearModified']),
    );
  }
  String eventID;
  String title;
  DateTime dateTime;
  int repeatFor;
  int yearModified;

  static Map<String, dynamic> toMap(EventInfo event) => {
    'eventID': event.eventID,
    'title': event.title,
    'dateTime': event.dateTime.toString(),
    'repeatFor': event.repeatFor.toString(),
    'yearModified': event.yearModified.toString(),
  };

  static String encode(List<EventInfo> event) => json.encode(
    event.map<Map<String, dynamic>>(
        EventInfo.toMap,
    ).toList(),
  );

  static List<EventInfo> decode(String event) =>
      (json.decode(event) as List<dynamic>)
        .map<EventInfo>(
              EventInfo.fromJson,
      ).toList();
}