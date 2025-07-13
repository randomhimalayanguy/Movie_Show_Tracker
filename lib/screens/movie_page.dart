import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/movie_provider.dart';

class MoviePage extends ConsumerWidget {
  final String movieId;
  const MoviePage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail = ref.watch(movieProvider(movieId));
    return Scaffold(
      appBar: AppBar(title: Text("Movie Detail")),
      body: movieDetail.when(
        data: (data) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 400,
                    // width: 700,
                    child: Image.network(data.poster, fit: BoxFit.fill),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data.title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 6,
                        ),
                        child: Text("IMDb - ${data.imdbRating}"),
                      ),
                    ),
                    SizedBox(width: 15),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.orange,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 2,
                          horizontal: 6,
                        ),
                        child: Text("Metascore - ${data.metascore}"),
                      ),
                    ),
                    // Text(data.metascore),
                  ],
                ),
                SizedBox(height: 20),
                Text(data.overview, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
        error: (error, stackTrace) => Center(child: Text("$error")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
