import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/helper_provider.dart';

class MovieShowSelectorWidget extends ConsumerWidget {
  final bool isMovie;
  final String type;
  const MovieShowSelectorWidget({
    super.key,
    required this.isMovie,
    required this.type,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cur = ref.watch(curTypeProvider);
    final isSelected = (isMovie == cur);
    return Container(
      height: 40,
      color: isSelected ? Colors.blue : Colors.white,
      child: TextButton(
        onPressed: () => ref.read(curTypeProvider.notifier).state = isMovie,
        child: Text(
          type,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
