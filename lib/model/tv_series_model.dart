class TvSeries {
  final String name;
  final String overview;
  final String posterPath;
  final String first_air_date;
  final double vote_average;
  // final double id;

  TvSeries({
    required this.name,
    required this.overview,
    required this.posterPath,
    required this.first_air_date,
    required this.vote_average,
    // required this.id,
  });

  factory TvSeries.fromJson(Map<String, dynamic> json) {
    return TvSeries(
      name: json['name'],
      overview: json['overview'],
      posterPath: json['poster_path'],
      first_air_date: json['first_air_date'],
      vote_average: json['vote_average'],
      // id: json['id'],
    );
  }
}
