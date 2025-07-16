import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:movie_show_tracker/constant_values.dart';
import 'package:movie_show_tracker/models/media.dart';
import 'dart:convert';

final contentListProvider =
    FutureProvider.family<List<Media>, ({String type, bool isMovie})>((
      ref,
      params,
    ) async {
      String movieShow = (params.isMovie) ? "movie" : "tv";
      final response = await http.get(
        Uri.parse(
          "https://api.themoviedb.org/3/$movieShow/${params.type}?api_key=$movieAPI",
        ),
      );

      List<Media> li = [];
      if (response.statusCode == 200) {
        final Map<String, dynamic> map = jsonDecode(response.body);
        final List<dynamic>? data = map["results"];
        for (int i = 0; i < data!.length; i++) {
          li.add(Media.fromJson(data[i]));
        }
        return li;
      } else {
        throw Exception("Can't load data");
      }
    });
