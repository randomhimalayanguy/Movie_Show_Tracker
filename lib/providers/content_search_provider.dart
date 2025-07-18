import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_show_tracker/constant_values.dart';
import 'package:movie_show_tracker/models/media.dart';
import 'dart:convert';

final contentSearchProvider =
    FutureProvider.family<List<Media>, ({String search, bool isMovie})>((
      ref,
      para,
    ) async {
      final movieShow = (para.isMovie) ? "movie" : "tv";
      final response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/search/$movieShow?api_key=$movieAPI&query=${para.search}",
        ),
      );

      List<Media> li = [];
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = jsonDecode(response.body);
        final List<dynamic>? data = map["results"];
        int len = (data!.length > 10) ? 10 : data.length;
        for (int i = 0; i < len; i++) {
          li.add(Media.fromJson(data[i]));
        }
        return li;
      } else {
        throw Exception("Can't load data");
      }
    });
