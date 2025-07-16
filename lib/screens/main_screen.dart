import 'package:flutter/material.dart';
import 'package:movie_show_tracker/screens/home_screen.dart';
import 'package:movie_show_tracker/screens/search_screen.dart';
import 'package:movie_show_tracker/screens/settings_screen.dart';
import 'package:movie_show_tracker/screens/watchlist_screen.dart';
import 'package:movie_show_tracker/widgets/movie_show_selector_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int curScreen = 0;

  final List<Widget> screens = [
    HomeScreen(),
    SearchPage(),
    WatchListPage(),
    SettingsPage(),
  ];

  final List<String> titles = ["Explore", "Search", "Watch List", "Settings"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titles[curScreen]),

        actions: (curScreen == 1 || curScreen == 2)
            ? [
                MovieShowWidget(isMovie: true, type: "Movies"),
                MovieShowWidget(isMovie: false, type: "Shows"),
                SizedBox(width: 20),
              ]
            : [],
      ),
      bottomNavigationBar: BottomNavigationBar(
        enableFeedback: true,
        currentIndex: curScreen,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.orange,
        fixedColor: Colors.green,
        elevation: 1,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
          BottomNavigationBarItem(
            icon: Icon(Icons.shop_two_sharp),
            label: "Library",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],

        onTap: (value) => setState(() => curScreen = value),
      ),
      body: screens[curScreen],
    );
  }
}
