import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/saved_show_list.dart';
import 'package:movie_show_tracker/providers/show_provider.dart';
import 'package:movie_show_tracker/util/colors.dart';
import 'package:movie_show_tracker/util/helper.dart';

class ShowPage extends ConsumerWidget {
  final String id;

  const ShowPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showDetail = ref.watch(showProvider(id));

    return Scaffold(
      body: SafeArea(
        child: showDetail.when(
          data: (data) {
            return NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  expandedHeight: 220,
                  pinned: true,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(data.backImg, fit: BoxFit.cover),
                  ),
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
              body: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 12.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: SizedBox(
                            height: 180,
                            width: 120,
                            child: Image.network(
                              data.poster,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.title,
                                style: const TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 12),
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_rate_rounded,
                                    color: Colors.amber,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    data.score.toStringAsFixed(1),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Icon(
                                    Icons.calendar_today,
                                    color: Colors.grey[600],
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    dateFormatter(data.released),
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  Icon(
                                    Icons.live_tv,
                                    color: Colors.grey[600],
                                    size: 18,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      '${data.numberOfSeasons} Seasons, ${data.numberOfEpisodes} Eps',
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey[700],
                                      ),
                                      softWrap: true,
                                      maxLines: 2,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              WatchStatus(id: data.id),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    const SizedBox(height: 24),
                    const Text(
                      "Overview",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      data.overview,
                      style: const TextStyle(fontSize: 16, height: 1.5),
                    ),
                    const SizedBox(height: 20), // Extra space at the bottom
                  ],
                ),
              ),
            );
          },
          error: (error, stackTrace) => Center(child: Text("Error: $error")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class GenresChip extends StatelessWidget {
  final List<String> genres;
  const GenresChip({super.key, required this.genres});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 4.0,
      children: genres
          .take(3)
          .map(
            (genre) => Chip(
              label: Text(genre, style: const TextStyle(color: Colors.white)),
              backgroundColor: AppColor.primaryColor,
            ),
          )
          .toList(),
    );
  }
}

class WatchStatus extends ConsumerWidget {
  final String id;

  const WatchStatus({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    bool isWatched;
    bool isPlanned;

    isWatched = ref.watch(watchedShowProvider).contains(id);
    isPlanned = ref.watch(plannedShowProvider).contains(id);

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (!isPlanned)
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isWatched
                      ? Colors.redAccent
                      : AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (!isWatched) {
                    ref.read(watchedShowProvider.notifier).addWatchedShow(id);
                    ref
                        .read(plannedShowProvider.notifier)
                        .removePlannedShow(id);
                  } else {
                    ref
                        .read(watchedShowProvider.notifier)
                        .removeWatchedShow(id);
                  }
                },
                child: Text("Watched"),
              ),
            ),
          const SizedBox(width: 10),

          if (!isWatched)
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPlanned
                      ? Colors.amber[700]
                      : AppColor.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (!isPlanned) {
                    ref.read(plannedShowProvider.notifier).addPlannedShow(id);
                    ref
                        .read(watchedShowProvider.notifier)
                        .removeWatchedShow(id);
                  } else {
                    ref
                        .read(plannedShowProvider.notifier)
                        .removePlannedShow(id);
                  }
                },
                child: Text("Planning"),
              ),
            ),
        ],
      ),
    );
  }
}
