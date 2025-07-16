import 'package:movie_show_tracker/models/media.dart';

class ShowDetail extends Media {
  final String released;
  final String status;
  final double score;

  ShowDetail({
    required super.title,
    required super.overview,
    required super.poster,
    required super.id,
    required super.backImg,
    required this.released,
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
      released: json["first_air_date"] ?? "",
      status: json["status"] ?? "Not airing",
      score: json["vote_average"] ?? 0.0,
      backImg: "",
      id: json["id"] as String,
    );
  }
}
