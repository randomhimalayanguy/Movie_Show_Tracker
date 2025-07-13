import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/models/movie.dart';
import 'package:movie_show_tracker/widgets/movie_card_widget.dart';

class MovieTileGrid extends StatelessWidget {
  const MovieTileGrid({super.key, required this.movieLi});

  final AsyncValue<List<Movie>> movieLi;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: movieLi.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                SizedBox(width: 120, child: MovieCardWidget(data: data[index])),
          );
        },
        error: (error, stack) => Center(child: Text("Can't load data")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
