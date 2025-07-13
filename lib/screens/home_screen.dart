import 'package:flutter/material.dart';
import 'package:movie_show_tracker/widgets/auto_scroll_widget.dart';
import 'package:movie_show_tracker/widgets/movie_row_widget.dart';

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
              MovieRowWidget(title: "New", movieType: "now_playing"),
              MovieRowWidget(title: "Top Rated", movieType: "top_rated"),
              MovieRowWidget(title: "Popular", movieType: "popular"),
            ],
          ),
        ),
      ),
    );
  }
}
