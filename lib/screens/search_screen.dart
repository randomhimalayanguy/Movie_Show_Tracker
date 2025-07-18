import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/helper_provider.dart';
import 'package:movie_show_tracker/providers/content_search_provider.dart';
import 'dart:async';
import 'package:movie_show_tracker/widgets/genre_list_widget.dart';
import 'package:movie_show_tracker/widgets/content_list_widget.dart';
import 'package:movie_show_tracker/widgets/content_row_widget.dart';

class SearchPage extends ConsumerStatefulWidget {
  const SearchPage({super.key});

  @override
  ConsumerState<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends ConsumerState<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  Timer? debounce;
  String searchQuery = "";

  void search(String value) {
    if (debounce?.isActive ?? false) debounce?.cancel();

    debounce = Timer(
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
    debounce?.cancel();
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
      padding: const EdgeInsets.symmetric(vertical: 14.0, horizontal: 18),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
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
                        decoration: InputDecoration(border: InputBorder.none),
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
            if (searchQuery.isEmpty) ...[
              ContentRowWidget(
                title: "Popular",
                movieType: "popular",
                isMovie: isMovie,
              ),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Genres", style: TextStyle(fontSize: 22)),
              ),
              GenreListWidget(isMovie: isMovie),
              //this is a comment to sett
            ] else
              searchLi.when(
                data: (data) => ContentListWidget(data: data, isMovie: isMovie),
                error: (error, stackTrace) =>
                    Center(child: Text("Lol no data")),
                loading: () => Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
