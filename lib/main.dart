import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/helper_provider.dart';
import 'package:movie_show_tracker/screens/main_screen.dart';

void main() => runApp(ProviderScope(child: MainApp()));

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curTheme = ref.watch(themeProvider);
    return MaterialApp(
      theme: curTheme,
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
