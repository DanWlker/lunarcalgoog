import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lunarcalgoog/entity/event_info.dart';
import 'package:lunarcalgoog/page/home.dart';
import 'package:lunarcalgoog/provider/google_sign_in_provider.dart';

class GoogleSignInPage extends ConsumerWidget {
  const GoogleSignInPage({
    required this.storedEvents,
    super.key,
  });

  final List<EventInfo> storedEvents;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleSignInRes = ref.watch(googleSignInProvider);

    ref.listen(googleSignInProvider, (prev, next) {
      if (prev case AsyncData(:final value) when value != null) {
        return;
      }
      if (next case AsyncData(:final value) when value != null) {
        Future.delayed(const Duration(seconds: 1), () {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder<void>(
              pageBuilder: (_, __, ___) => Home(
                events: storedEvents,
              ),
              transitionsBuilder: (_, a, __, c) =>
                  FadeTransition(opacity: a, child: c),
            ),
          );
        });
      }
    });

    final signInButton = TextButton(
      onPressed: () {
        ref.invalidate(googleSignInProvider);
      },
      child: const Text('Sign In'),
    );

    return Scaffold(
      body: Center(
        child: switch (googleSignInRes) {
          AsyncLoading() => const Text('Attempting to sign you in...'),
          AsyncError() => signInButton,
          AsyncData(:final value) when value == null => signInButton,
          AsyncData(:final value) when value != null => Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  leading: GoogleUserCircleAvatar(
                    identity: value,
                  ),
                  title: Text(value.displayName ?? ''),
                  subtitle: Text(value.email),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in successful, redirecting you to home page...',
                ),
              ],
            ),
          _ => const Text('Unhandled State'),
        },
      ),
    );
  }
}
