import 'package:flutter/material.dart';
import 'package:lunarcalgoog/pages/date_set_screen.dart';
import 'package:lunarcalgoog/pages/home.dart';
import 'package:lunarcalgoog/pages/loading.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/home',
  routes: {
    '/': (context) => Loading(),
    '/home': (context) => Home(),
    '/date_set_screen': (context) => DateSetScreen(),
  }
));




