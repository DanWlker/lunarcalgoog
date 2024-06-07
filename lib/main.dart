import 'package:flutter/material.dart';
import 'package:lunarcalgoog/pages/loading_page.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const LoadingPage(),
        },
      ),
    );
