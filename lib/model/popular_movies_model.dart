class PopularMoviesModule {
  final String name;
  final String overview;
  final String posterPath;

  final double vote_average;

  PopularMoviesModule({
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.vote_average,
  });

  factory PopularMoviesModule.fromJson(Map<String, dynamic> json) {
    return PopularMoviesModule(
      name: json['original_title'],
      overview: json['overview'],
      posterPath: json['poster_path'],

      vote_average: json['vote_average'],
      // id: json['id'],
    );
  }
}
