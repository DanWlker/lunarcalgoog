import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lunarcalgoog/provider/google_sign_in_provider.dart';

class GoogleSignInPage extends ConsumerWidget {
  const GoogleSignInPage({
    required this.onSignInSuccessful,
    super.key,
  });

  final VoidCallback onSignInSuccessful;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final googleSignInRes = ref.watch(googleSignInProviderSilent);

    ref.listen(googleSignInProviderSilent, (prev, next) {
      if (prev case AsyncData(:final value) when value != null) {
        return;
      }
      if (next case AsyncData(:final value) when value != null) {
        onSignInSuccessful();
      }
    });

    final signInButton = TextButton(
      onPressed: () async {
        await googleSignIn.signIn();
        ref.invalidate(googleSignInProviderSilent);
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
