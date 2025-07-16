import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/helper_provider.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curTheme = ref.watch(themeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dark Mode", style: TextStyle(fontSize: 20)),
              Switch(
                value: (curTheme == ThemeData.dark()),
                onChanged: (value) => ref.read(themeProvider.notifier).state =
                    (value) ? ThemeData.dark() : ThemeData.light(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
