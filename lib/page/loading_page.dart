import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/page/home.dart';
import 'package:lunarcalgoog/util/save_and_read.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
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
    await navigatorState.pushReplacement(
      PageRouteBuilder<void>(
        pageBuilder: (_, __, ___) => Home(events: storedEvents),
        transitionsBuilder: (_, a, __, c) =>
            FadeTransition(opacity: a, child: c),
      ),
      // MaterialPageRoute<void>(
      //   builder: (context) => Home(events: storedEvents),
      // ),
    );
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
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}
