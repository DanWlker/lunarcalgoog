import 'dart:convert';

class EventInfo {
  String eventID;
  String title;
  DateTime dateTime;
  int repeatFor;
  EventInfo({this.eventID, this.title, this.dateTime, this.repeatFor});

  factory EventInfo.fromJson(Map<String, dynamic> jsonData) {
    return EventInfo(
      eventID: jsonData['eventID'],
      title: jsonData['title'],
      dateTime: DateTime.parse(jsonData['dateTime']),
      repeatFor: int.parse(jsonData['repeatFor']),
    );
  }

  static Map<String, dynamic> toMap(EventInfo event) => {
    'eventID': event.eventID,
    'title': event.title,
    'dateTime': event.dateTime.toString(),
    'repeatFor': event.repeatFor.toString(),
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