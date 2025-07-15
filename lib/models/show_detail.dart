import 'package:movie_show_tracker/models/media.dart';

class ShowDetail extends Media {
  final String title;
  final String overview;
  final String poster;
  // final int runtime;
  final String released;
  // final String metascore;
  // final String imdbRating;
  final String status;
  final double score;

  ShowDetail({
    required this.title,
    required this.overview,
    required this.poster,
    // required this.runtime,
    required this.released,
    // required this.imdbRating,
    // required this.metascore,
    required this.status,
    required this.score,
  });

  factory ShowDetail.fromJson(Map<String, dynamic> json) {
    final String posterPath = json["poster_path"] ?? "";
    final String fullPosterUrl = posterPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$posterPath"
        : "https://via.placeholder.com/500x750?text=No+Image";

    return ShowDetail(
      title: json["name"] ?? "",
      overview: json["overview"] ?? "",
      poster: fullPosterUrl,
      // runtime: source1["runtime"] ?? 0,
      released: json["first_air_date"] ?? "",
      status: json["status"] ?? "Not airing",
      score: json["vote_average"] ?? 0.0,
    );
  }
}
