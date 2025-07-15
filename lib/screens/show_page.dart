import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:movie_show_tracker/providers/show_provider.dart';

class ShowPage extends ConsumerWidget {
  final String id;

  const ShowPage({super.key, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail = ref.watch(showProvider(id));

    return Scaffold(
      appBar: AppBar(title: Text("Show Detail")),
      body: movieDetail.when(
        data: (data) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: SizedBox(
                      height: 400,
                      child: Image.network(data.poster, fit: BoxFit.fill),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    data.title,
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 2,
                            horizontal: 6,
                          ),
                          child: Text("Score - ${data.score}"),
                        ),
                      ),
                      const SizedBox(width: 15),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(data.overview, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ),
          );
        },
        error: (error, stackTrace) => Center(child: Text("Error: $error")),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
