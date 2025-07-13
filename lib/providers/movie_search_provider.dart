import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_show_tracker/constant_values.dart';
import 'dart:convert';

import 'package:movie_show_tracker/models/movie.dart';

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
