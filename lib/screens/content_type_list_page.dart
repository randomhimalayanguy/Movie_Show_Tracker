import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/content_list_provider.dart';
import 'package:movie_show_tracker/widgets/content_list_widget.dart';

class ContentTypeListScreen extends ConsumerWidget {
  final String movieType;
  final String name;
  final bool isMovie;
  const ContentTypeListScreen({
    super.key,
    required this.movieType,
    required this.name,
    required this.isMovie,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final list = ref.watch(
      contentListProvider((isMovie: isMovie, type: movieType)),
    );
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        child: list.when(
          data: (data) => ContentListWidget(data: data, isMovie: isMovie),
          error: (error, stackTrace) => Center(child: Text("$error")),
          loading: () => const Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}
