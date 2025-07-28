import 'package:flutter/material.dart';
import 'package:movie_show_tracker/widgets/auto_scroll_widget.dart';
import 'package:movie_show_tracker/widgets/content_row_widget.dart';
import 'package:movie_show_tracker/widgets/widgets_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AutoScrollCarousel(),
              const SizedBox(height: 18),
              const WidgetsContainer(
                child: Column(
                  children: [
                    Text(
                      "Movies",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ContentRowWidget(
                      title: "New",
                      movieType: "now_playing",
                      isMovie: true,
                    ),
                    ContentRowWidget(
                      title: "Top Rated",
                      movieType: "top_rated",
                      isMovie: true,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 22),
              const WidgetsContainer(
                child: Column(
                  children: [
                    Text(
                      "Shows",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    ContentRowWidget(
                      title: "Popular",
                      movieType: "popular",
                      isMovie: false,
                    ),
                    ContentRowWidget(
                      title: "Top Rated",
                      movieType: "top_rated",
                      isMovie: false,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
