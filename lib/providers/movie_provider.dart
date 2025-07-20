import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_show_tracker/util/constant_values.dart';
import 'dart:convert';

import 'package:movie_show_tracker/models/movie_detail.dart';

final movieProvider = FutureProvider.family<MovieDetail, String>((
  ref,
  id,
) async {
  final response = await http.get(
    Uri.parse("https://api.themoviedb.org/3/movie/$id?api_key=$movieAPI"),
  );

  if (response.statusCode == 200) {
    return MovieDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Can't load data");
  }
});
