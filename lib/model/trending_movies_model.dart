class TrendingMovie {
  final String title;
  final String overview;
  final String posterPath;

  TrendingMovie(
      {required this.title, required this.overview, required this.posterPath});

  factory TrendingMovie.fromJson(Map<String, dynamic> json) {
    return TrendingMovie(
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterPath: json['poster_path'] ?? '',
    );
  }
}


// class Sermon {
//   final String title;
//   final String description;
//   final String thumbnail;

//   Sermon(
//       {required this.title, required this.description, required this.thumbnail});

//   factory Sermon.fromJson(Map<String, dynamic> json) {
//     return Sermon(
//       title: json['title'] ?? '',
//       description: json['description'] ?? '',
//       thumbnail: json['thumbnail'] ?? '',
//     );
//   }
// }
