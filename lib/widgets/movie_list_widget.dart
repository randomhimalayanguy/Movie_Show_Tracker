import 'package:flutter/material.dart';
import 'package:movie_show_tracker/models/movie.dart';
import 'package:movie_show_tracker/widgets/movie_card_widget.dart';

class MovieListWidget extends StatelessWidget {
  final List<Movie> data;
  final bool isMovie;
  const MovieListWidget({super.key, required this.data, required this.isMovie});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) => MovieCardWidget(
        isMovie: isMovie,
        data: Movie(
          id: data[index].id,
          backgImg: data[index].backgImg,
          posterImg: data[index].posterImg,
          title: data[index].title,
        ),
      ),
    );
  }
}
