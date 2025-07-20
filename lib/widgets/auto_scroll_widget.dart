import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/content_list_provider.dart';
import 'dart:async';

class AutoScrollCarousel extends ConsumerStatefulWidget {
  const AutoScrollCarousel({super.key});

  @override
  ConsumerState<AutoScrollCarousel> createState() => _AutoScrollCarouselState();
}

class _AutoScrollCarouselState extends ConsumerState<AutoScrollCarousel> {
  late PageController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll(int itemCount) {
    if (itemCount == 0) return; // Prevent errors if data is empty

    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        // Calculate the next page, ensuring it loops around
        _currentPage = (_currentPage + 1) % itemCount;

        _pageController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeIn,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieLi = ref.watch(
      contentListProvider((isMovie: true, type: "now_playing")),
    );

    return SizedBox(
      height: 195,
      child: movieLi.when(
        data: (data) {
          // Stop any existing timer and start a new one if data is available
          _timer?.cancel();
          if (data.isNotEmpty) {
            _startAutoScroll(data.length);
          }

          return PageView.builder(
            controller: _pageController,
            pageSnapping: true,
            itemCount: data.length,
            onPageChanged: (index) {
              _currentPage = index;
            },
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: MediaQuery.sizeOf(context).width - 30,
                      child: Stack(
                        children: [
                          // Ensure Image.network handles null or empty URLs
                          data[index].backImg.isNotEmpty
                              ? Image.network(
                                  data[index].backImg,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  color: Colors.grey,
                                ), // Placeholder for missing image
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
          );
        },
        error: (error, stack) => const Center(child: Text("Can't load data")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
