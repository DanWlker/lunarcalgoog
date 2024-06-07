import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lunarcalgoog/objects_widgets/event_info.dart';
import 'package:lunarcalgoog/objects_widgets/save_and_read.dart';
import 'package:lunarcalgoog/pages/home.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  Future<void> loadData(NavigatorState navigatorState) async {
    List<EventInfo> storedEvents;

    try {
      storedEvents = EventInfo.decode(await SaveAndRead.readData());
    } catch (e) {
      log('First Time opening');
      storedEvents = [];
    }
    await navigatorState.pushReplacement(
      MaterialPageRoute<void>(
        builder: (context) => Home(events: storedEvents),
      ),
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
      backgroundColor: Color.fromARGB(255, 59, 66, 82),
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 60,
        ),
      ),
    );
  }
}
