import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lunarcalgoog/page/google_sign_in_page.dart';
import 'package:lunarcalgoog/page/home.dart';
import 'package:lunarcalgoog/page/load_from_storage_page.dart';

void main() => runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => Builder(
              builder: (context) {
                final navigatorState = Navigator.of(context);
                return GoogleSignInPage(
                  onSignInSuccessful: () {
                    Future.delayed(const Duration(seconds: 1), () {
                      navigatorState.pushReplacement(
                        PageRouteBuilder<void>(
                          pageBuilder: (_, __, ___) => LoadFromStoragePage(
                            onLoadSuccessful: (storedEvents) {
                              Future.delayed(const Duration(seconds: 1), () {
                                navigatorState.pushReplacement(
                                  PageRouteBuilder<void>(
                                    pageBuilder: (_, __, ___) => Home(
                                      events: storedEvents,
                                    ),
                                    transitionsBuilder: (_, a, __, c) =>
                                        FadeTransition(opacity: a, child: c),
                                  ),
                                );
                              });
                            },
                          ),
                          transitionsBuilder: (_, a, __, c) =>
                              FadeTransition(opacity: a, child: c),
                        ),
                      );
                    });
                  },
                );
              },
            ),
      },
    );
  }
}
