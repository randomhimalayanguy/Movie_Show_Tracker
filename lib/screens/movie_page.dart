import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/movie_provider.dart';
import 'package:movie_show_tracker/providers/saved_movie_list_provider.dart';

class MoviePage extends ConsumerWidget {
  final String id;

  const MoviePage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail = ref.watch(movieProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text("Movie Detail"),
        actions: [
          IconButton(
            onPressed: () => ref.read(savedMovieProvider.notifier).add(id),
            icon: Icon(Icons.bookmark_add_outlined),
          ),
          SizedBox(width: 60),
        ],
      ),
      body: movieDetail.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Image.network(data.poster, fit: BoxFit.fill),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Row(
                  //   children: [
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: Colors.orange,
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //           vertical: 2,
                  //           horizontal: 6,
                  //         ),
                  //         // child: Text("IMDb - ${data.imdbRating}"),
                  //       ),
                  //     ),
                  //     const SizedBox(width: 15),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         color: Colors.orange,
                  //       ),
                  //       child: Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //           vertical: 2,
                  //           horizontal: 6,
                  //         ),
                  //         // child: Text("Metascore - ${data.metascore}"),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(height: 20),
                  Text(data.overview, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
