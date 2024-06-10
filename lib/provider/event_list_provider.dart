import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/util/save_and_read.dart';

final eventListProvider = FutureProvider<List<EventInfo>>((ref) async {
  List<EventInfo> storedEvents;
  try {
    storedEvents =
        (jsonDecode(await SaveAndRead.readData()) as List).map((item) {
      return EventInfo.fromJson(item as Map<String, dynamic>);
    }).toList();
  } catch (e) {
    debugPrint(e.toString());
    debugPrint('First Time opening');
    storedEvents = [];
  }
  debugPrint(storedEvents.toString());
  return storedEvents;
});
