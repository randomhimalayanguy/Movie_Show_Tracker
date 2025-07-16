class Media {
  final String title;
  final String overview;
  final String poster;
  final String backImg;
  final String id;

  Media({
    required this.title,
    required this.overview,
    required this.poster,
    required this.backImg,
    required this.id,
  });

  factory Media.fromJson(Map<String, dynamic> json) {
    final String posterPath = json["poster_path"] ?? "";
    final String fullPosterUrl = posterPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$posterPath"
        : "https://via.placeholder.com/500x750?text=No+Image";

    final String backgPath = json["backdrop_path"] ?? "";
    final String fullBackgUrl = backgPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$backgPath"
        : "https://via.placeholder.com/500x750?text=No+Image";

    return Media(
      title: json["title"] ?? json["name"],
      overview: json["overview"],
      poster: fullPosterUrl,
      id: json["id"].toString(),
      backImg: fullBackgUrl,
    );
  }
}
