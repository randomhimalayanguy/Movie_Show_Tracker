import 'package:movie_show_tracker/models/media.dart';

/* 
Genres (list)
*/

class MovieDetail extends Media {
  final int runtime;
  final String releaseDate;

  MovieDetail({
    required super.title,
    required super.overview,
    required super.poster,
    required super.backImg,
    required super.id,
    required this.runtime,
    required this.releaseDate,
  });

  factory MovieDetail.fromJson(Map<String, dynamic> json) {
    final String posterPath = json["poster_path"] ?? "";
    final String fullPosterUrl = posterPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$posterPath"
        : "https://via.placeholder.com/500x750?text=No+Image";

    final String backgPath = json["backdrop_path"] ?? "";
    final String fullBackgUrl = backgPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$backgPath"
        : "https://via.placeholder.com/500x750?text=No+Image";

    return MovieDetail(
      title: json["title"] ?? json["name"],
      overview: json["overview"],
      poster: fullPosterUrl,
      runtime: json["runtime"] ?? 0,
      id: json["id"].toString(),
      backImg: fullBackgUrl,
      releaseDate: json["release_date"] ?? "Not Release Date",
    );
  }
}
