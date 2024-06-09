import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

final _googleSignIn = GoogleSignIn(
  scopes: <String>[CalendarApi.calendarEventsScope],
);

final googleSignInProvider = FutureProvider<GoogleSignInAccount?>((ref) async {
  return (await _googleSignIn.signInSilently()) ?? await _googleSignIn.signIn();
});
