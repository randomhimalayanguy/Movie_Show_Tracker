import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/helper_provider.dart';
import 'package:movie_show_tracker/providers/content_search_provider.dart';
import 'package:movie_show_tracker/util/colors.dart';
import 'package:movie_show_tracker/widgets/genre_list_widget.dart';
import 'package:movie_show_tracker/widgets/content_list_widget.dart';
import 'package:movie_show_tracker/widgets/content_row_widget.dart';
import 'package:movie_show_tracker/widgets/widgets_container.dart';
import 'dart:async';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  Timer? timer;
  String searchQuery = "";

  void search(String value) {
    if (timer?.isActive ?? false) timer?.cancel();

    timer = Timer(
      Duration(milliseconds: 750),
      () => setState(() => searchQuery = value.trim()),
    );
  }

  void cancel() {
    setState(() {
      searchQuery = "";
      _controller.text = "";
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMovie = ref.watch(curTypeProvider);
    final searchLi = ref.watch(
      contentSearchProvider((search: searchQuery, isMovie: isMovie)),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: AppColor.secondaryBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: TextField(
                        onChanged: (value) => search(value),
                        controller: _controller,
                        autofocus: false,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hint: Text(
                            "Search ${isMovie ? "movies" : "shows"}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (searchQuery.isNotEmpty)
                    IconButton(
                      onPressed: cancel,
                      icon: Icon(Icons.cancel_rounded, color: Colors.white),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            if (searchQuery.isEmpty) ...[
              ContentRowWidget(
                title: "Popular",
                movieType: "popular",
                isMovie: isMovie,
                isParent: true,
              ),
              const SizedBox(height: 10),
              WidgetsContainer(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text("Genres", style: TextStyle(fontSize: 22)),
                    ),
                    GenreListWidget(isMovie: isMovie),
                  ],
                ),
              ),
            ] else
              searchLi.when(
                data: (data) => ContentListWidget(data: data, isMovie: isMovie),
                error: (error, stackTrace) =>
                    Center(child: Text("Lol no data")),
                loading: () => const Center(child: CircularProgressIndicator()),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
