import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/helper_provider.dart';
import 'package:movie_show_tracker/util/colors.dart';

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
      decoration: BoxDecoration(
        borderRadius: (isMovie)
            ? const BorderRadius.horizontal(left: Radius.circular(10))
            : const BorderRadius.horizontal(right: Radius.circular(10)),
        color: isSelected
            ? AppColor.primaryColor
            : AppColor.secondaryBackgroundColor,
      ),
      child: TextButton(
        onPressed: () => ref.read(curTypeProvider.notifier).state = isMovie,
        child: Text(
          type,
          style: TextStyle(color: isSelected ? Colors.white70 : Colors.white30),
        ),
      ),
    );
  }
}
