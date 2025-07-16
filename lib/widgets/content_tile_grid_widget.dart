import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/models/media.dart';
import 'package:movie_show_tracker/widgets/content_card_widget.dart';

class ContentTileGrid extends StatelessWidget {
  final AsyncValue<List<Media>> movieLi;
  final bool isMovie;
  const ContentTileGrid({
    super.key,
    required this.movieLi,
    required this.isMovie,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: movieLi.when(
        data: (data) {
          return ListView.builder(
            itemCount: (data.length < 10) ? data.length : 10,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) => SizedBox(
              width: 120,
              child: ContentCardWidget(data: data[index], isMovie: isMovie),
            ),
          );
        },
        error: (error, stack) => Center(child: Text("Can't load data")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
