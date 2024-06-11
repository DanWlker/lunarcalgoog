import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart';

final googleSignIn = GoogleSignIn(
  scopes: <String>[CalendarApi.calendarEventsScope],
);

final googleSignInProviderSilent =
    FutureProvider<GoogleSignInAccount?>((ref) async {
  return googleSignIn.signInSilently();
});
