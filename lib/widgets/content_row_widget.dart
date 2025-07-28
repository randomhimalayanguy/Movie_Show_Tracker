import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/content_list_provider.dart';
import 'package:movie_show_tracker/screens/content_type_list_page.dart';
import 'package:movie_show_tracker/util/colors.dart';
import 'package:movie_show_tracker/widgets/content_tile_grid_widget.dart';
import 'package:movie_show_tracker/widgets/widgets_container.dart';

class ContentRowWidget extends ConsumerStatefulWidget {
  final String title;
  final String movieType;
  final bool isMovie;
  final bool isParent;
  const ContentRowWidget({
    super.key,
    required this.title,
    required this.movieType,
    required this.isMovie,
    this.isParent = false,
  });

  @override
  ConsumerState<ContentRowWidget> createState() => _MovieRowWidgetState();
}

class _MovieRowWidgetState extends ConsumerState<ContentRowWidget> {
  @override
  Widget build(BuildContext context) {
    final movieLi = ref.watch(
      contentListProvider((isMovie: widget.isMovie, type: widget.movieType)),
    );
    return WidgetsContainer(
      isParent: widget.isParent,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ContentTypeListScreen(
                        movieType: widget.movieType,
                        name: widget.title,
                        isMovie: widget.isMovie,
                      ),
                    ),
                  ),
                  child: const Text(
                    "See All",
                    style: TextStyle(
                      color: AppColor.primaryColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
          ContentTileGrid(contentList: movieLi, isMovie: widget.isMovie),
        ],
      ),
    );
  }
}
