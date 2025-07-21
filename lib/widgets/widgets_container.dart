import 'package:flutter/material.dart';
import 'package:movie_show_tracker/util/colors.dart';

class WidgetsContainer extends StatelessWidget {
  final Widget child;
  final bool isParent;
  const WidgetsContainer({
    super.key,
    required this.child,
    this.isParent = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColor.secondaryBackgroundColor,
      ),
      child: Padding(
        padding: (isParent)
            ? EdgeInsets.symmetric(vertical: 10, horizontal: 12)
            : EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: child,
      ),
    );
  }
}
