// import 'package:movie_show_tracker/models/media.dart';

// class ShowDetail extends Media {
//   final String released;
//   final String status;
//   final double score;

//   ShowDetail({
//     required super.title,
//     required super.overview,
//     required super.poster,
//     required super.id,
//     required super.backImg,
//     required this.released,
//     required this.status,
//     required this.score,
//   });

//   factory ShowDetail.fromJson(Map<String, dynamic> json) {
//     final String posterPath = json["poster_path"] ?? "";
//     final String fullPosterUrl = posterPath.isNotEmpty
//         ? "https://image.tmdb.org/t/p/w500$posterPath"
//         : "https://via.placeholder.com/500x750?text=No+Image";

//     final String backPath = json["backdrop_path"] ?? "";
//     final String fullBackgUrl = backPath.isNotEmpty
//         ? "https://image.tmdb.org/t/p/w500$backPath"
//         : "https://via.placeholder.com/500x750?text=No+Image";

//     return ShowDetail(
//       title: json["name"] ?? "",
//       overview: json["overview"] ?? "",
//       poster: fullPosterUrl,
//       released: json["first_air_date"] ?? "",
//       status: json["status"] ?? "Not airing",
//       score: json["vote_average"] ?? 0.0,
//       backImg: fullBackgUrl,
//       id: json["id"].toString(),
//     );
//   }
// }

import 'package:movie_show_tracker/models/media.dart';

class ShowDetail extends Media {
  final String released;
  final String status;
  final double score;
  final String tagline; // New field
  final List<String> genres; // New field
  final int numberOfSeasons; // New field
  final int numberOfEpisodes; // New field

  ShowDetail({
    required super.title,
    required super.overview,
    required super.poster,
    required super.id,
    required super.backImg,
    required this.released,
    required this.status,
    required this.score,
    required this.tagline, // Initialize new field
    required this.genres, // Initialize new field
    required this.numberOfSeasons, // Initialize new field
    required this.numberOfEpisodes, // Initialize new field
  });

  factory ShowDetail.fromJson(Map<String, dynamic> json) {
    final String posterPath = json["poster_path"] ?? "";
    final String fullPosterUrl = posterPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$posterPath"
        : "https://via.placeholder.com/500x750?text=No+Image";

    final String backPath = json["backdrop_path"] ?? "";
    final String fullBackgUrl = backPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$backPath"
        : "https://via.placeholder.com/500x750?text=No+Image";

    // Parse genres
    List<String> genresList = [];
    if (json["genres"] != null) {
      for (var genre in json["genres"]) {
        genresList.add(genre["name"]);
      }
    }

    return ShowDetail(
      title: json["name"] ?? "N/A", // Use "N/A" for missing data
      overview: json["overview"] ?? "No overview available.",
      poster: fullPosterUrl,
      released: json["first_air_date"] ?? "N/A",
      status: json["status"] ?? "N/A",
      score:
          (json["vote_average"] as num?)?.toDouble() ??
          0.0, // Safely cast to double
      backImg: fullBackgUrl,
      id: json["id"]?.toString() ?? "", // Ensure ID is string and not null
      tagline: json["tagline"] ?? "", // Parse tagline
      genres: genresList, // Assign parsed genres
      numberOfSeasons:
          json["number_of_seasons"] ?? 0, // Parse number of seasons
      numberOfEpisodes:
          json["number_of_episodes"] ?? 0, // Parse number of episodes
    );
  }
}
