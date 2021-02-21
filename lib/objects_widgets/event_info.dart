import 'dart:convert';

class EventInfo {
  String eventID;
  String title;
  DateTime dateTime;
  int repeatFor;
  int yearModified;
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

  static Map<String, dynamic> toMap(EventInfo event) => {
    'eventID': event.eventID,
    'title': event.title,
    'dateTime': event.dateTime.toString(),
    'repeatFor': event.repeatFor.toString(),
    'yearModified': event.yearModified.toString(),
  };

  static String encode(List<EventInfo> event) => json.encode(
    event.map<Map<String, dynamic>>(
        (event) => EventInfo.toMap(event)
    ).toList(),
  );

  static List<EventInfo> decode(String event) =>
      (json.decode(event) as List<dynamic>)
        .map<EventInfo>(
              (item) => EventInfo.fromJson(item)
      ).toList();
}