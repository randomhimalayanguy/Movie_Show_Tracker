import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/movie_provider.dart';
import 'package:movie_show_tracker/providers/saved_movie_list_provider.dart';
import 'package:movie_show_tracker/widgets/content_card_widget.dart';

class WatchListPage extends ConsumerStatefulWidget {
  const WatchListPage({super.key});

  @override
  ConsumerState<WatchListPage> createState() => _WatchListPageState();
}

class _WatchListPageState extends ConsumerState<WatchListPage> {
  final PageController pageController = PageController();
  int curPage = 0;

  @override
  Widget build(BuildContext context) {
    final movieLi = ref.watch(savedMovieProvider);
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: TextButton(
                    onPressed: () => print("s"),
                    child: Text("Watched"),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: TextButton(
                    onPressed: () => print("s"),
                    child: Text("Plan to watch"),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            onPageChanged: (value) => setState(() => curPage = value),
            children: [
              GridView.builder(
                itemCount: movieLi.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 0.75,
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final movie = ref.watch(movieProvider(movieLi[index]));

                  return movie.when(
                    data: (data) =>
                        ContentCardWidget(data: data, isMovie: true),
                    error: (error, stackTrace) => Center(child: Text("$error")),
                    loading: () => Center(child: CircularProgressIndicator()),
                  );
                },

                // Card(child: Container(color: Colors.amber)),
              ),
              GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) => Card(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
