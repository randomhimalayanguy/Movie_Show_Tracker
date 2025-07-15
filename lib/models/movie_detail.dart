import 'package:movie_show_tracker/models/media.dart';

class MovieDetail extends Media {
  final String title;
  final String overview;
  final String poster;
  final int runtime;
  final String released;
  final String metascore;
  final String imdbRating;

  MovieDetail({
    required this.title,
    required this.overview,
    required this.poster,
    required this.runtime,
    required this.released,
    required this.imdbRating,
    required this.metascore,
  });

  factory MovieDetail.fromJson(
    Map<String, dynamic> source1,
    Map<String, dynamic> source2,
  ) {
    final String posterPath = source1["poster_path"] ?? "";
    final String fullPosterUrl = posterPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$posterPath"
        : "https://via.placeholder.com/500x750?text=No+Image";

    return MovieDetail(
      title: source1["title"] ?? source1["name"],
      overview: source1["overview"],
      poster: fullPosterUrl,
      runtime: source1["runtime"] ?? 0,
      released: source2["Released"],
      imdbRating: source2["imdbRating"] ?? "",
      metascore: source2["Metascore"] ?? "",
    );
  }
}
