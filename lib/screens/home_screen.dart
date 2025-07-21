import 'package:flutter/material.dart';
import 'package:movie_show_tracker/widgets/auto_scroll_widget.dart';
import 'package:movie_show_tracker/widgets/content_row_widget.dart';
import 'package:movie_show_tracker/widgets/widgets_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 14),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AutoScrollCarousel(),
              SizedBox(height: 18),
              WidgetsContainer(
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
              SizedBox(height: 22),
              WidgetsContainer(
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
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
