import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/movie_list_provider.dart';
import 'package:movie_show_tracker/widgets/movie_list_widget.dart';

class MovieTypeListScreen extends ConsumerWidget {
  final String movieType;
  final String name;
  final bool isMovie;
  const MovieTypeListScreen({
    super.key,
    required this.movieType,
    required this.name,
    required this.isMovie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(
      movieShowsListProvider((isMovie: isMovie, type: movieType)),
    );
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        child: list.when(
          data: (data) => MovieListWidget(data: data),
          error: (error, stackTrace) => Center(child: Text("$error")),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
