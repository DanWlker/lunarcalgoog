import 'package:flutter/material.dart';
import 'package:lunarcalgoog/objects_widgets/event_info.dart';
import 'package:lunarcalgoog/objects_widgets/save_and_read.dart';
import 'package:lunarcalgoog/pages/home.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void loadData() async {
    SaveAndRead storage = SaveAndRead();
    List<EventInfo> eventsToPass = EventInfo.decode(await storage.readData());
    new Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(events: eventsToPass),
          )
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
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 59, 66, 82),
      body: Center(
        child: SpinKitRotatingCircle(
          color: Colors.white,
          size: 60.0,
        ),
      )
    );
  }
}
