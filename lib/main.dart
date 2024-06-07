import 'package:flutter/material.dart';
import 'package:lunarcalgoog/page/loading_page.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const LoadingPage(),
        },
      ),
    );
