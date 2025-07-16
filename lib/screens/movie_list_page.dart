import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/genre_list_content.dart';
import 'package:movie_show_tracker/widgets/content_list_widget.dart';

class MovieListPage extends ConsumerWidget {
  final String genre;
  final int genreId;
  final bool isMovie;
  const MovieListPage({
    super.key,
    required this.genreId,
    required this.genre,
    required this.isMovie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieList = ref.watch(
      contentGenreListProvider((id: genreId, isMovie: isMovie)),
    );
    return Scaffold(
      appBar: AppBar(title: Text(genre)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: SingleChildScrollView(
          child: movieList.when(
            data: (data) => ContentListWidget(data: data, isMovie: isMovie),
            error: (error, stackTrace) => Center(child: Text("No movie list")),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}
