import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/models/movie.dart';
import 'package:movie_show_tracker/widgets/movie_card_widget.dart';

class MovieTileGrid extends StatelessWidget {
  final AsyncValue<List<Movie>> movieLi;
  final bool isMovie;
  const MovieTileGrid({
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
              child: MovieCardWidget(data: data[index], isMovie: isMovie),
            ),
          );
        },
        error: (error, stack) => Center(child: Text("Can't load data")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
