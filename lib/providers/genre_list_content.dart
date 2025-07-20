import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_show_tracker/models/media.dart';
import 'dart:convert';

import '../util/constant_values.dart';

/// Provides list of content of specific genre
final contentGenreListProvider =
    FutureProvider.family<List<Media>, ({int id, bool isMovie})>((
      ref,
      para,
    ) async {
      final String type = (para.isMovie) ? "movie" : "tv";
      final String conditions = "sort_by=vote_average.desc&vote_count.gte=200";

      final response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/discover/$type?api_key=$movieAPI&with_genres=${para.id}&$conditions",
        ),
      );

      List<Media> li = [];
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = jsonDecode(response.body);
        final List<dynamic>? data = map["results"];
        if (data == null) return li;
        for (int i = 0; i < data.length; i++) {
          li.add(Media.fromJson(data[i]));
        }
        return li;
      } else {
        throw Exception("Can't load data");
      }
    });
