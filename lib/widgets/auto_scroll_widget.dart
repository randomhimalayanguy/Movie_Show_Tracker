import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/movie_list_provider.dart';

class AutoScrollCarousel extends ConsumerStatefulWidget {
  const AutoScrollCarousel({super.key});

  @override
  ConsumerState<AutoScrollCarousel> createState() => _AutoScrollCarouselState();
}

class _AutoScrollCarouselState extends ConsumerState<AutoScrollCarousel> {
  @override
  Widget build(BuildContext context) {
    final movieLi = ref.watch(
      movieShowsListProvider((isMovie: true, type: "now_playing")),
    );
    return SizedBox(
      height: 195,
      child: movieLi.when(
        data: (data) => PageView.builder(
          pageSnapping: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 30,
                    child: Stack(
                      children: [
                        Image.network(data[index].backgImg, fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              data[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset.fromDirection(2),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        error: (error, stack) => Center(child: Text("Can't load data")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
