import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/helper_provider.dart';
import 'package:movie_show_tracker/providers/movie_provider.dart';
import 'package:movie_show_tracker/providers/saved_movie_list_provider.dart';
import 'package:movie_show_tracker/providers/saved_show_list.dart';
import 'package:movie_show_tracker/providers/show_provider.dart';
import 'package:movie_show_tracker/util/colors.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                StatusSelectionWidget(
                  isCur: curPage == 0,
                  pageController: pageController,
                  text: "Watched",
                  targetPage: 0,
                ),
                const SizedBox(width: 10),
                StatusSelectionWidget(
                  isCur: curPage == 1,
                  pageController: pageController,
                  text: "Planning",
                  targetPage: 1,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: PageView(
              controller: pageController,
              onPageChanged: (value) => setState(() => curPage = value),
              children: [
                GridList(
                  contentList: (curType) ? watchedMovieLi : watchedShowLi,
                  ref: ref,
                ),
                GridList(
                  contentList: (curType) ? plannedMovieLi : plannedShowLi,
                  ref: ref,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class StatusSelectionWidget extends StatelessWidget {
  const StatusSelectionWidget({
    super.key,
    required this.pageController,
    required this.text,
    required this.isCur,
    required this.targetPage,
  });

  final bool isCur;
  final PageController pageController;
  final String text;
  final int targetPage;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        color: (isCur)
            ? AppColor.primaryColor
            : AppColor.secondaryBackgroundColor,
        child: TextButton(
          onPressed: () {
            pageController.animateToPage(
              targetPage,
              duration: Duration(milliseconds: 200),
              curve: Curves.easeIn,
            );
          },
          child: Text(
            text,
            style: TextStyle(color: isCur ? Colors.white70 : Colors.white12),
          ),
        ),
      ),
    );
  }
}

class GridList extends ConsumerWidget {
  const GridList({super.key, required this.contentList, required this.ref});

  final List<String> contentList;
  final WidgetRef ref;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curSelected = ref.watch(curTypeProvider);
    return GridView.builder(
      itemCount: contentList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 0.68,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final movie = (curSelected)
            ? ref.watch(movieProvider(contentList[index]))
            : ref.watch(showProvider(contentList[index]));
        return movie.when(
          data: (data) => ContentCardWidget(
            data: data,
            isMovie: curSelected,
            isParent: true,
          ),
          error: (error, stackTrace) => Center(child: Text("$error")),
          loading: () => const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
