// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:movie_show_tracker/providers/saved_show_list.dart';
// import 'package:movie_show_tracker/providers/show_provider.dart';
// import 'package:movie_show_tracker/util/colors.dart';

// class ShowPage extends ConsumerWidget {
//   final String id;

//   const ShowPage({super.key, required this.id});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final showDetail = ref.watch(showProvider(id));

//     return Scaffold(
//       body: SafeArea(
//         child: showDetail.when(
//           data: (data) {
//             return NestedScrollView(
//               headerSliverBuilder: (context, innerBoxIsScrolled) => [
//                 SliverAppBar(
//                   expandedHeight: 220,
//                   pinned: true,
//                   flexibleSpace: FlexibleSpaceBar(
//                     background: Image.network(data.backImg, fit: BoxFit.cover),
//                   ),
//                 ),
//               ],
//               body: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 12.0,
//                   vertical: 8,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         SizedBox(
//                           height: 160,
//                           width: 110,
//                           child: Image.network(data.poster, fit: BoxFit.cover),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 data.title,
//                                 style: const TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.w500,
//                                 ),
//                                 softWrap: true,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               const SizedBox(height: 8),
//                               Container(
//                                 decoration: BoxDecoration(
//                                   borderRadius: BorderRadius.circular(5),
//                                   color:
//                                       AppColor.primaryColor, // Consistent color
//                                 ),
//                                 child: Padding(
//                                   padding: const EdgeInsets.symmetric(
//                                     vertical: 4,
//                                     horizontal: 8,
//                                   ),
//                                   child: Text(
//                                     "Score - ${data.score.toStringAsFixed(1)}", // Format score
//                                     style: const TextStyle(
//                                       color: Colors.white,
//                                       fontSize: 14,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(height: 12),
//                               WatchStatus(
//                                 id: id,
//                                 // contentType: ContentType.show,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     Expanded(
//                       child: SingleChildScrollView(
//                         child: Text(
//                           data.overview,
//                           style: const TextStyle(fontSize: 16),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//           error: (error, stackTrace) => Center(child: Text("Error: $error")),
//           loading: () => const Center(child: CircularProgressIndicator()),
//         ),
//       ),
//     );
//   }
// }

// class WatchStatus extends ConsumerWidget {
//   final String id;
//   const WatchStatus({super.key, required this.id});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     bool isWatched = ref.watch(watchedShowProvider).contains(id);
//     bool isPlanned = ref.watch(plannedShowProvider).contains(id);
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 2.0),
//         child: Row(
//           children: [
//             if (!isPlanned)
//               Expanded(
//                 child: Container(
//                   color: Color(0xffBD3039),
//                   child: TextButton(
//                     onPressed: () {
//                       if (!isWatched) {
//                         ref
//                             .read(watchedShowProvider.notifier)
//                             .addWatchedShow(id);
//                         ref
//                             .read(plannedShowProvider.notifier)
//                             .removePlannedShow(id);
//                       } else {
//                         ref
//                             .read(watchedShowProvider.notifier)
//                             .removeWatchedShow(id);
//                       }
//                     },
//                     child: Text(
//                       "Watched",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             if (!isWatched)
//               Expanded(
//                 child: Container(
//                   color: AppColor.primaryColor,
//                   child: TextButton(
//                     onPressed: () {
//                       if (!isPlanned) {
//                         ref
//                             .read(plannedShowProvider.notifier)
//                             .addPlannedShow(id);
//                         ref
//                             .read(watchedShowProvider.notifier)
//                             .removeWatchedShow(id);
//                       } else {
//                         ref
//                             .read(plannedShowProvider.notifier)
//                             .removePlannedShow(id);
//                       }
//                     },
//                     child: Text(
//                       "Planning",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/saved_movie_list_provider.dart';
import 'package:movie_show_tracker/providers/saved_show_list.dart';
import 'package:movie_show_tracker/providers/show_provider.dart';
import 'package:movie_show_tracker/util/colors.dart'; // Ensure you have this import for AppColor
import 'package:movie_show_tracker/util/helper.dart'; // Ensure you have this import for date/time formatters

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
                    // Add a back button
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ),
              ],
              body: SingleChildScrollView(
                // Changed to SingleChildScrollView for the body content
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
                            height: 180, // Slightly increased height for poster
                            width: 120, // Slightly increased width for poster
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

                              // const SizedBox(height: 4),
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
                                    data.score.toStringAsFixed(
                                      1,
                                    ), // Format score to one decimal
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
                              // GenresChip(genres: data.genres)
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    // WatchStatus(id: id),
                    const SizedBox(height: 24),
                    // GenresChip(genres: data.genres),
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

// Keep the common WatchStatus widget as it was, it's already refactored for both
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
        mainAxisAlignment:
            MainAxisAlignment.spaceEvenly, // Distribute space evenly
        children: [
          // Watched Button (visible if not planned)
          if (!isPlanned)
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isWatched
                      ? Colors.redAccent
                      : AppColor
                            .primaryColor, // Red when watched, primary when not
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
          const SizedBox(width: 10), // Space between buttons
          // Planning Button (visible if not watched)
          if (!isWatched)
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPlanned
                      ? Colors.amber[700]
                      : AppColor
                            .primaryColor, // Amber when planned, primary when not
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
