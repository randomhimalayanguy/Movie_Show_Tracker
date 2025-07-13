import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/genre_provider.dart';
import 'package:movie_show_tracker/screens/movie_list_page.dart';

class GenreListWidget extends ConsumerWidget {
  const GenreListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(genreProvider);
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: genres.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieListPage(
              genreId: genres[index].id,
              genre: genres[index].name,
            ),
          ),
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(genres[index].name),
            ),
          ),
        ),
      ),
    );
  }
}
