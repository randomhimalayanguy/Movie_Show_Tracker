import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

void main() => runApp(ProviderScope(child: MainApp()));

const String movieAPI = "ef80cb55bb670834155905451eaa0b08";
const String omdbAPI = "d5d68f4d";

final themeProvider = StateProvider<ThemeData>((ref) => ThemeData.light());

class Genre {
  int id;
  String name;

  Genre({required this.id, required this.name});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: json["id"] as int, name: json["name"]);
  }
}

final genreProvider = Provider<List<Genre>>((ref) {
  {
    final json = {
      "genres": [
        {"id": 28, "name": "Action"},
        {"id": 12, "name": "Adventure"},
        {"id": 16, "name": "Animation"},
        {"id": 35, "name": "Comedy"},
        {"id": 80, "name": "Crime"},
        {"id": 99, "name": "Documentary"},
        {"id": 18, "name": "Drama"},
        {"id": 10751, "name": "Family"},
        {"id": 14, "name": "Fantasy"},
        {"id": 36, "name": "History"},
        {"id": 27, "name": "Horror"},
        {"id": 10402, "name": "Music"},
        {"id": 9648, "name": "Mystery"},
        {"id": 10749, "name": "Romance"},
        {"id": 878, "name": "Science Fiction"},
        {"id": 10770, "name": "TV Movie"},
        {"id": 53, "name": "Thriller"},
        {"id": 10752, "name": "War"},
        {"id": 37, "name": "Western"},
      ],
    };

    return (json["genres"] as List).map((ele) => Genre.fromJson(ele)).toList();
  }
});

class Movie {
  String posterImg;
  String backgImg;
  String id;
  String title;

  Movie({
    required this.posterImg,
    required this.id,
    required this.title,
    required this.backgImg,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final String posterPath =
        json["poster_path"] ?? ""; // Handle null poster_path
    final String backgPath = json["backdrop_path"] ?? "";
    final String fullPosterUrl = posterPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w300$posterPath"
        : "https://via.placeholder.com/500x750?text=No+Image";
    final String fullBackgUrl = backgPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$backgPath"
        : "https://via.placeholder.com/500x750?text=No+Image";
    return Movie(
      posterImg: fullPosterUrl,
      id: json["id"].toString(),
      title: json["title"],
      backgImg: fullBackgUrl,
    );
  }
}

class MovieDetail {
  final String title;
  final String overview;
  final String poster;
  final int runtime;
  final String released;
  final String metascore;
  final String imdbRating;

  MovieDetail({
    required this.title,
    required this.overview,
    required this.poster,
    required this.runtime,
    required this.released,
    required this.imdbRating,
    required this.metascore,
  });

  factory MovieDetail.fromJson(
    Map<String, dynamic> source1,
    Map<String, dynamic> source2,
  ) {
    final String posterPath = source1["poster_path"] ?? "";
    final String fullPosterUrl = posterPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$posterPath"
        : "https://via.placeholder.com/500x750?text=No+Image";

    return MovieDetail(
      title: source1["title"],
      overview: source1["overview"],
      poster: fullPosterUrl,
      runtime: source1["runtime"],
      released: source2["Released"],
      imdbRating: source2["imdbRating"],
      metascore: source2["Metascore"],
    );
  }
}

final movieListProvider = FutureProvider.family<List<Movie>, String>((
  ref,
  movieType,
) async {
  final response = await http.get(
    Uri.parse(
      "https://api.themoviedb.org/3/movie/$movieType?api_key=$movieAPI",
    ),
  );

  List<Movie> li = [];
  if (response.statusCode == 200) {
    final Map<String, dynamic> map = jsonDecode(response.body);
    final List<dynamic>? data = map["results"];
    int len = (data!.length > 10) ? 10 : data.length;
    for (int i = 0; i < len; i++) {
      li.add(Movie.fromJson(data[i]));
    }
    return li;
  } else {
    throw Exception("Can't load data");
  }
});

final movieSearchProvider = FutureProvider.family<List<Movie>, String>((
  ref,
  search,
) async {
  final response = await http.get(
    Uri.parse(
      "https://api.themoviedb.org/3/search/movie?api_key=$movieAPI&query=$search",
    ),
  );

  List<Movie> li = [];
  if (response.statusCode == 200) {
    final Map<String, dynamic> map = jsonDecode(response.body);
    final List<dynamic>? data = map["results"];
    int len = (data!.length > 10) ? 10 : data.length;
    for (int i = 0; i < len; i++) {
      li.add(Movie.fromJson(data[i]));
    }
    return li;
  } else {
    throw Exception("Can't load data");
  }
});

final movieProvider = FutureProvider.family<MovieDetail, String>((
  ref,
  movidID,
) async {
  final response1 = await http.get(
    Uri.parse("https://api.themoviedb.org/3/movie/$movidID?api_key=$movieAPI"),
  );

  final String imdbId = jsonDecode(response1.body)["imdb_id"];

  final response2 = await http.get(
    Uri.parse("http://www.omdbAPI.com/?i=$imdbId&apikey=$omdbAPI"),
  );

  if (response1.statusCode == 200 && response2.statusCode == 200) {
    return MovieDetail.fromJson(
      jsonDecode(response1.body),
      jsonDecode(response2.body),
    );
  } else {
    throw Exception("Can't load data");
  }
});

final movieGenreListProvider = FutureProvider.family<List<Movie>, int>((
  ref,
  genreId,
) async {
  final response = await http.get(
    Uri.parse(
      "https://api.themoviedb.org/3/discover/movie?api_key=$movieAPI&with_genres=$genreId",
    ),
  );

  List<Movie> li = [];
  if (response.statusCode == 200) {
    final Map<String, dynamic> map = jsonDecode(response.body);
    final List<dynamic>? data = map["results"];
    if (data == null) return li;
    for (int i = 0; i < data.length; i++) {
      li.add(Movie.fromJson(data[i]));
    }
    return li;
  } else {
    throw Exception("Can't load data");
  }
});

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curTheme = ref.watch(themeProvider);
    return MaterialApp(
      theme: curTheme,
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

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

  final List<String> titles = ["Explore", "Search", "Wish List", "Settings"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titles[curScreen])),
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AutoScrollCarousel(),
              MovieRow(title: "New", movieType: "now_playing"),
              MovieRow(title: "Top Rated", movieType: "top_rated"),
              MovieRow(title: "Popular", movieType: "popular"),
            ],
          ),
        ),
      ),
    );
  }
}

class AutoScrollCarousel extends ConsumerStatefulWidget {
  const AutoScrollCarousel({super.key});

  @override
  ConsumerState<AutoScrollCarousel> createState() => _AutoScrollCarouselState();
}

class _AutoScrollCarouselState extends ConsumerState<AutoScrollCarousel> {
  @override
  Widget build(BuildContext context) {
    final movieLi = ref.watch(movieListProvider("now_playing"));
    return SizedBox(
      height: 195,
      child: movieLi.when(
        data: (data) => PageView.builder(
          pageSnapping: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            return Stack(
              children: [
                Center(
                  child: SizedBox(
                    width: MediaQuery.sizeOf(context).width - 30,
                    child: Stack(
                      children: [
                        Image.network(data[index].backgImg, fit: BoxFit.cover),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Text(
                              data[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    color: Colors.black26,
                                    offset: Offset.fromDirection(2),
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),

        error: (error, stack) => Center(child: Text("Can't load data")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class MovieRow extends ConsumerStatefulWidget {
  final String title;
  final String movieType;
  const MovieRow({super.key, required this.title, required this.movieType});

  @override
  ConsumerState<MovieRow> createState() => _MovieRowState();
}

class _MovieRowState extends ConsumerState<MovieRow> {
  @override
  Widget build(BuildContext context) {
    final movieLi = ref.watch(movieListProvider(widget.movieType));
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MovieTypeList(
                      movieType: widget.movieType,
                      name: widget.title,
                    ),
                  ),
                ),
                child: Text("See All"),
              ),
            ],
          ),
        ),
        MovieTile(movieLi: movieLi),
      ],
    );
  }
}

class MovieTile extends StatelessWidget {
  const MovieTile({super.key, required this.movieLi});

  final AsyncValue<List<Movie>> movieLi;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 240,
      child: movieLi.when(
        data: (data) {
          return ListView.builder(
            itemCount: data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) =>
                SizedBox(width: 120, child: MovieCard(data: data[index])),
          );
        },
        error: (error, stack) => Center(child: Text("Can't load data")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie data;
  const MovieCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 0,
        child: Column(
          children: [
            Container(
              height: 170,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.network(
                data.posterImg,
                fit: BoxFit.cover,
                // frameBuilder: ,
              ),
            ),
            SizedBox(height: 10),
            Text(
              data.title,
              softWrap: true,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      // onLongPress: () {
      //   print("Add this");
      // },
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MoviePage(movieId: data.id)),
      ),
    );
  }
}

class MoviePage extends ConsumerWidget {
  final String movieId;
  const MoviePage({super.key, required this.movieId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieDetail = ref.watch(movieProvider(movieId));
    return Scaffold(
      appBar: AppBar(title: Text("Movie Detail")),
      body: movieDetail.when(
        data: (data) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
            child: Column(
              children: [
                Center(
                  child: SizedBox(
                    height: 400,
                    // width: 700,
                    child: Image.network(data.poster, fit: BoxFit.fill),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    data.title,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                ),
                SizedBox(height: 15),
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
                        child: Text("IMDb - ${data.imdbRating}"),
                      ),
                    ),
                    SizedBox(width: 15),
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
                        child: Text("Metascore - ${data.metascore}"),
                      ),
                    ),
                    // Text(data.metascore),
                  ],
                ),
                SizedBox(height: 20),
                Text(data.overview, style: TextStyle(fontSize: 16)),
              ],
            ),
          ),
        ),
        error: (error, stackTrace) => Center(child: Text("$error")),
        loading: () => Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

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
    final searchLi = ref.watch(movieSearchProvider(searchQuery));
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
              MovieRow(title: "Popular", movieType: "popular"),
              SizedBox(height: 10),
              Align(
                alignment: Alignment.centerLeft,
                child: Text("Genres", style: TextStyle(fontSize: 22)),
              ),
              GenreListWidget(),
            ] else
              searchLi.when(
                data: (data) => MovieListWidget(data: data),
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

class GenreListWidget extends ConsumerWidget {
  const GenreListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final genres = ref.watch(genreProvider);
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: genres.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3,
      ),
      itemBuilder: (context, index) => InkWell(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MovieListPage(
              genreId: genres[index].id,
              genre: genres[index].name,
            ),
          ),
        ),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(genres[index].name),
            ),
          ),
        ),
      ),
    );
  }
}

class MovieTypeList extends ConsumerWidget {
  final String movieType;
  final String name;
  const MovieTypeList({super.key, required this.movieType, required this.name});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieLi = ref.watch(movieListProvider(movieType));
    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: SingleChildScrollView(
        child: movieLi.when(
          data: (data) => MovieListWidget(data: data),
          error: (error, stackTrace) => Center(child: Text("$error")),
          loading: () => Center(child: CircularProgressIndicator()),
        ),
      ),
    );
  }
}

class MovieListPage extends ConsumerWidget {
  final String genre;
  final int genreId;
  const MovieListPage({super.key, required this.genreId, required this.genre});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movieList = ref.watch(movieGenreListProvider(genreId));
    return Scaffold(
      appBar: AppBar(title: Text(genre)),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: SingleChildScrollView(
          child: movieList.when(
            data: (data) => MovieListWidget(data: data),
            error: (error, stackTrace) => Center(child: Text("No movie list")),
            loading: () => Center(child: CircularProgressIndicator()),
          ),
        ),
      ),
    );
  }
}

class MovieListWidget extends StatelessWidget {
  final List<Movie> data;
  const MovieListWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: data.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.7,
      ),
      itemBuilder: (context, index) => MovieCard(
        data: Movie(
          id: data[index].id,
          backgImg: data[index].backgImg,
          posterImg: data[index].posterImg,
          title: data[index].title,
        ),
      ),
    );
  }
}

class WatchListPage extends ConsumerWidget {
  const WatchListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Placeholder();
  }
}

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final curTheme = ref.watch(themeProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Dark Mode", style: TextStyle(fontSize: 20)),
              Switch(
                value: (curTheme == ThemeData.dark()),
                onChanged: (value) => ref.read(themeProvider.notifier).state =
                    (value) ? ThemeData.dark() : ThemeData.light(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
