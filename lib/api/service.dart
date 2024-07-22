import 'dart:convert';

import 'package:movie/api/model/movie_model.dart';
import 'package:http/http.dart' as http;

class MovieServices {
  final String apiKey = '5200ad4284724d8e5b67de42f21ca31e';
  final String baseUrl = 'https://api.themoviedb.org/3/trending/all/day';

  Future<List<Movie>> fetcheMovies() async {
    final response = await http.get(
      Uri.parse('$baseUrl?api_key=$apiKey'),
    );

    // checking the response status
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['results'];
      List<Movie> movies =
          body.map((dynamic item) => Movie.fromJson(item)).toList();

      return movies;
    } else {
      throw Exception('Failed to load movie');
    }
  }
}
