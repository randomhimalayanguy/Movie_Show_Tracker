import 'package:flutter/material.dart';
import 'package:movie_show_tracker/screens/home_screen.dart';
import 'package:movie_show_tracker/screens/search_screen.dart';
import 'package:movie_show_tracker/screens/watchlist_screen.dart';
import 'package:movie_show_tracker/util/colors.dart';
import 'package:movie_show_tracker/widgets/movie_show_selector_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int curScreen = 0;

  final List<Widget> screens = [HomeScreen(), SearchPage(), WatchListPage()];

  final List<String> titles = ["Explore", "Search", "Watch List"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColor.backgroundColor,
        surfaceTintColor: AppColor.backgroundColor,
        title: Text(titles[curScreen]),

        actions: (curScreen == 1 || curScreen == 2)
            ? [
                const MovieShowSelectorWidget(isMovie: true, type: "Movies"),
                const MovieShowSelectorWidget(isMovie: false, type: "Shows"),
                const SizedBox(width: 20),
              ]
            : [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        currentIndex: curScreen,
        unselectedItemColor: Colors.grey,
        fixedColor: AppColor.primaryColor,
        elevation: 1,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: "Explore",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shop_two_sharp),
            label: "Library",
          ),
        ],

        onTap: (value) => setState(() => curScreen = value),
      ),
      body: screens[curScreen],
    );
  }
}
