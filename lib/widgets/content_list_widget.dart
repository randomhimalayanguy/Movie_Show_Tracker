import 'package:flutter/material.dart';
import 'package:movie_show_tracker/models/media.dart';
import 'package:movie_show_tracker/widgets/content_card_widget.dart';

class ContentListWidget extends StatelessWidget {
  final List<Media> data;
  final bool isMovie;
  const ContentListWidget({
    super.key,
    required this.data,
    required this.isMovie,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) =>
          ContentCardWidget(isMovie: isMovie, data: data[index]),
    );
  }
}
