import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/page/google_sign_in_page.dart';
import 'package:lunarcalgoog/util/save_and_read.dart';

class LoadFromStoragePage extends StatefulWidget {
  const LoadFromStoragePage({super.key});

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

    Future.delayed(const Duration(seconds: 1), () {
      navigatorState.pushReplacement(
        PageRouteBuilder<void>(
          pageBuilder: (_, __, ___) => GoogleSignInPage(
            storedEvents: storedEvents,
          ),
          transitionsBuilder: (_, a, __, c) =>
              FadeTransition(opacity: a, child: c),
        ),
      );
    });
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
