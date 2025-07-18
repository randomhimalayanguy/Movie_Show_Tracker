import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/models/media.dart';
import 'package:movie_show_tracker/providers/saved_movie_list_provider.dart';
import 'package:movie_show_tracker/providers/saved_show_list.dart';
import 'package:movie_show_tracker/screens/movie_page.dart';
import 'package:movie_show_tracker/screens/show_page.dart';

class ContentCardWidget extends ConsumerWidget {
  final Media data;
  final bool isMovie;
  const ContentCardWidget({
    super.key,
    required this.data,
    required this.isMovie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watchedMovies = ref.watch(watchedMovieProvider).toSet();
    final plannedMovies = ref.watch(plannedMovieProvider).toSet();

    final watchedShows = ref.watch(watchedShowProvider).toSet();
    final plannedShows = ref.watch(plannedShowProvider).toSet();
    return InkWell(
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 170,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  Image.network(data.poster, fit: BoxFit.cover),
                  if (isMovie) ...[
                    if (watchedMovies.contains(data.id)) WatchedIcon(),
                    if (plannedMovies.contains(data.id)) PlanToWatchWidget(),
                  ] else ...[
                    if (watchedShows.contains(data.id)) WatchedIcon(),
                    if (plannedShows.contains(data.id)) PlanToWatchWidget(),
                  ],
                ],
              ),
            ),
            SizedBox(height: 10),
            Text(
              data.title,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) =>
              (isMovie) ? MoviePage(id: data.id) : ShowPage(id: data.id),
        ),
      ),
    );
  }
}

class PlanToWatchWidget extends StatelessWidget {
  const PlanToWatchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Icon(Icons.watch_later, color: Colors.grey, size: 34),
    );
  }
}

class WatchedIcon extends StatelessWidget {
  const WatchedIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Icon(Icons.check_circle, size: 34, color: Colors.green),
    );
  }
}
