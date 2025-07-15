import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/movie_list_provider.dart';
import 'package:movie_show_tracker/screens/movie_type_list_page.dart';
import 'package:movie_show_tracker/widgets/movie_tile_grid_widget.dart';

class MovieRowWidget extends ConsumerStatefulWidget {
  final String title;
  final String movieType;
  final bool isMovie;
  const MovieRowWidget({
    super.key,
    required this.title,
    required this.movieType,
    required this.isMovie,
  });

  @override
  ConsumerState<MovieRowWidget> createState() => _MovieRowWidgetState();
}

class _MovieRowWidgetState extends ConsumerState<MovieRowWidget> {
  @override
  Widget build(BuildContext context) {
    final movieLi = ref.watch(
      movieShowsListProvider((isMovie: widget.isMovie, type: widget.movieType)),
    );
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MovieTypeListScreen(
                      movieType: widget.movieType,
                      name: widget.title,
                      isMovie: widget.isMovie,
                    ),
                  ),
                ),
                child: Text("See All"),
              ),
            ],
          ),
        ),
        MovieTileGrid(movieLi: movieLi, isMovie: widget.isMovie),
      ],
    );
  }
}
