import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lunarcalgoog/provider/event_list_provider.dart';

class LoadFromStoragePage extends ConsumerWidget {
  const LoadFromStoragePage({
    required this.onLoadSuccessful,
    super.key,
  });

  final void Function() onLoadSuccessful;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(eventListProvider, (prev, next) {
      if (prev case AsyncData()) {
        return;
      }
      if (next case AsyncData()) {
        onLoadSuccessful();
      }
    });
    return const Scaffold(
      body: Center(
        child: Text('Attempting to load history from storage...'),
      ),
    );
  }
}
