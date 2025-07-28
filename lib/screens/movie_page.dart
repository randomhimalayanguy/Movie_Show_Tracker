import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/movie_provider.dart';
import 'package:movie_show_tracker/providers/saved_movie_list_provider.dart';
import 'package:movie_show_tracker/util/colors.dart';
import 'package:movie_show_tracker/util/helper.dart';

class MoviePage extends ConsumerWidget {
  final String id;
  const MoviePage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail = ref.watch(movieProvider(id));

    return Scaffold(
      body: SafeArea(
        child: movieDetail.when(
          data: (data) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 220,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(data.backImg, fit: BoxFit.cover),
                  ),
                ),
              ],
              body: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 160,
                          width: 110,
                          child: Image.network(data.poster),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                                softWrap: true,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                "Release : ${dateFormatter(data.releaseDate)}",
                                style: TextStyle(fontSize: 16),
                              ),
                              Text(
                                timeFormatter(data.runtime),
                                style: TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 4),
                              WatchStatus(id: id),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Text(
                        data.overview,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) => Center(child: Text("$error")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
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
        padding: const EdgeInsets.symmetric(horizontal: 2.0),
        child: Row(
          children: [
            if (!isPlanned)
              Expanded(
                child: Container(
                  color: Color(0xffBD3039),
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
                    child: const Text(
                      "Watched",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            if (!isWatched)
              Expanded(
                child: Container(
                  color: AppColor.primaryColor,
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
                    child: const Text(
                      "Planning",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
