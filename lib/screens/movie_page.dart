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
      appBar: AppBar(title: Text("Movie Detail")),
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
                  WatchStatus(id: data.id),
                  const SizedBox(height: 20),
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
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

class WatchStatus extends ConsumerWidget {
  final String id;
  const WatchStatus({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isWatched = ref.watch(watchedMovieProvider).contains(id);
    bool isPlanned = ref.watch(plannedMovieProvider).contains(id);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          children: [
            if (!isPlanned)
              Expanded(
                child: Container(
                  color: Colors.orange,
                  child: TextButton(
                    onPressed: () {
                      if (!isWatched) {
                        ref
                            .read(watchedMovieProvider.notifier)
                            .addWatchedMovie(id);
                        ref
                            .read(plannedMovieProvider.notifier)
                            .removePlannedMovie(id);
                      } else {
                        ref
                            .read(watchedMovieProvider.notifier)
                            .removeWatchedMovie(id);
                      }
                    },
                    child: Text("Watched"),
                  ),
                ),
              ),
            if (!isWatched)
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: TextButton(
                    onPressed: () {
                      if (!isPlanned) {
                        ref
                            .read(plannedMovieProvider.notifier)
                            .addPlannedMovie(id);
                        ref
                            .read(watchedMovieProvider.notifier)
                            .removeWatchedMovie(id);
                      } else {
                        ref
                            .read(plannedMovieProvider.notifier)
                            .removePlannedMovie(id);
                      }
                    },
                    child: Text("Plan to watch"),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
