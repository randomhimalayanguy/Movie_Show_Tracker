import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../constant_values.dart';
import '../models/movie.dart';

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
