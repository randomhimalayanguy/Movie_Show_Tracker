import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
    return Column(
      children: [
        SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(child: Container(color: Colors.green)),
              SizedBox(width: 10),
              Expanded(child: Container(color: Colors.green)),
              SizedBox(width: 10),
              Expanded(child: Container(color: Colors.green)),
            ],
          ),
        ),
        Expanded(
          child: PageView(
            onPageChanged: (value) => setState(() => curPage = value),
            children: [
              GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) =>
                    Card(child: Container(color: Colors.amber)),
              ),
              GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
                itemBuilder: (context, index) => Card(),
              ),
              GridView.builder(
                itemCount: 10,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
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
