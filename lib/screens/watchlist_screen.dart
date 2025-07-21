import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/helper_provider.dart';
import 'package:movie_show_tracker/providers/movie_provider.dart';
import 'package:movie_show_tracker/providers/saved_movie_list_provider.dart';
import 'package:movie_show_tracker/providers/saved_show_list.dart';
import 'package:movie_show_tracker/providers/show_provider.dart';
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
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final watchedMovieLi = ref.watch(watchedMovieProvider);
    final plannedMovieLi = ref.watch(plannedMovieProvider);

    final watchedShowLi = ref.watch(watchedShowProvider);
    final plannedShowLi = ref.watch(plannedShowProvider);

    final curType = ref.watch(curTypeProvider);
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
                    onPressed: () {
                      pageController.animateToPage(
                        0,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text("Watched"),
                  ),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: Container(
                  color: Colors.green,
                  child: TextButton(
                    onPressed: () {
                      pageController.animateToPage(
                        1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeIn,
                      );
                    },
                    child: Text("Plan to watch"),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        Expanded(
          child: PageView(
            controller: pageController,
            onPageChanged: (value) => setState(() => curPage = value),
            children: [
              GridList(
                movieLi: (curType) ? watchedMovieLi : watchedShowLi,
                ref: ref,
              ),
              GridList(
                movieLi: (curType) ? plannedMovieLi : plannedShowLi,
                ref: ref,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class GridList extends ConsumerWidget {
  const GridList({super.key, required this.movieLi, required this.ref});

  final List<String> movieLi;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curSelected = ref.watch(curTypeProvider);
    return GridView.builder(
      itemCount: movieLi.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.78,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final movie = (curSelected)
            ? ref.watch(movieProvider(movieLi[index]))
            : ref.watch(showProvider(movieLi[index]));
        return movie.when(
          data: (data) => ContentCardWidget(
            data: data,
            isMovie: curSelected,
            isParent: true,
          ),
          error: (error, stackTrace) => Center(child: Text("$error")),
          loading: () => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
