import 'package:flutter/material.dart';
import 'package:movie_show_tracker/widgets/auto_scroll_widget.dart';
import 'package:movie_show_tracker/widgets/content_row_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AutoScrollCarousel(),
              SizedBox(height: 10),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
              ),
              SizedBox(height: 18),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
