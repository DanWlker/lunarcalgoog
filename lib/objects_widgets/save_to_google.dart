import 'dart:io';
import 'package:googleapis_auth/auth_io.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:url_launcher/url_launcher.dart';

class SaveToGoogle {
  static const _scopes = const[CalendarApi.calendarScope];
  var _credentials;

  void assignClientID() {
    if (Platform.isAndroid) {
      _credentials = new ClientId(
        "690477293202-jdq06bjdc537t7pc57qchptcejlm6g8s.apps.googleusercontent.com",
        "");
    } else if (Platform.isIOS) {
      _credentials = new ClientId(
        "690477293202-vt0idmk14tf3rf7rrb6m93mq8sppjk5h.apps.googleusercontent.com",
        "");
    }
  }

  void insert(String title, DateTime startTime, DateTime endTime) {
    assignClientID();
    var _clientID = _credentials;
    clientViaUserConsent(_credentials, _scopes, prompt).then((AuthClient client) {
      var calendar = CalendarApi(client);
      calendar.calendarList.list().then((value) => print("VAL: $value"));

      String calendarId = "primary";
      Event event = Event();

      event.summary = title;

      EventDateTime start = new EventDateTime();
      start.dateTime = startTime;
      start.timeZone = "GMT+8:00";
      event.start = start;

      EventDateTime end = new EventDateTime();
      end.timeZone = "GMT+8:00";
      end.dateTime = endTime;
      event.end = end;
      try {
        calendar.events.insert(event, calendarId).then((value) {
          print("ADDED: ${value.status}");
          if(value.status == "confirmed") {
            print('Event added in google calendar');
          } else {
            print("Unable to add event in google calendar");
          }
        });
      } catch(e) {
        print("Error creating event $e");
      }

    });
  }
  
  void prompt(String url) async {
    print("Please go to the following URL to grant access: ");
    print(" => $url");
    print("");

    if(await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}