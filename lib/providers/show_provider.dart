import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_show_tracker/constant_values.dart';
import 'dart:convert';

import 'package:movie_show_tracker/models/show_detail.dart';

final showProvider = FutureProvider.family<ShowDetail, String>((ref, id) async {
  final response = await http.get(
    Uri.parse("https://api.themoviedb.org/3/tv/$id?api_key=$movieAPI"),
  );

  if (response.statusCode == 200) {
    return ShowDetail.fromJson(jsonDecode(response.body));
  } else {
    throw Exception("Can't load data");
  }
});
