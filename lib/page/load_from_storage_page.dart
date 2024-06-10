import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/util/save_and_read.dart';

class LoadFromStoragePage extends StatefulWidget {
  const LoadFromStoragePage({
    required this.onLoadSuccessful,
    super.key,
  });

  final void Function(List<EventInfo>) onLoadSuccessful;

  @override
  State<LoadFromStoragePage> createState() => _LoadFromStoragePageState();
}

class _LoadFromStoragePageState extends State<LoadFromStoragePage> {
  Future<void> loadData(NavigatorState navigatorState) async {
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

    widget.onLoadSuccessful(storedEvents);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadData(Navigator.of(context));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Attempting to load history from storage...'),
      ),
    );
  }
}
