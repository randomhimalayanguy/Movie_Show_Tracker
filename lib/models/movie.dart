class Movie {
  String posterImg;
  String backgImg;
  String id;
  String title;

  Movie({
    required this.posterImg,
    required this.id,
    required this.title,
    required this.backgImg,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    final String posterPath =
        json["poster_path"] ?? ""; // Handle null poster_path
    final String backgPath = json["backdrop_path"] ?? "";
    final String fullPosterUrl = posterPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w300$posterPath"
        : "https://via.placeholder.com/500x750?text=No+Image";
    final String fullBackgUrl = backgPath.isNotEmpty
        ? "https://image.tmdb.org/t/p/w500$backgPath"
        : "https://via.placeholder.com/500x750?text=No+Image";
    return Movie(
      posterImg: fullPosterUrl,
      id: json["id"].toString(),
      title: json["title"] ?? json["name"],
      backgImg: fullBackgUrl,
    );
  }
}
