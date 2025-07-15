import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_show_tracker/constant_values.dart';
import 'dart:convert';

import 'package:movie_show_tracker/models/movie_detail.dart';

final movieProvider = FutureProvider.family<MovieDetail, String>((
  ref,
  id,
) async {
  final response1 = await http.get(
    Uri.parse("https://api.themoviedb.org/3/movie/$id?api_key=$movieAPI"),
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
