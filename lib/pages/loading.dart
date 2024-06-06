import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:lunarcalgoog/objects_widgets/event_info.dart';
import 'package:lunarcalgoog/objects_widgets/save_and_read.dart';
import 'package:lunarcalgoog/pages/home.dart';

class Loading extends StatefulWidget {
  const Loading({super.key});

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  Future<void> loadData() async {
    List<EventInfo> eventsToPass;

    try {
      eventsToPass = EventInfo.decode(await SaveAndRead.readData());
    } catch (e) {
      print('First Time opening');
      eventsToPass = [];
    }
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(events: eventsToPass),
          ),
      );
    });

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
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
