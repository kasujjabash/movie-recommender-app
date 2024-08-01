import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie/model/tv_series_model.dart';

import 'api_key.dart';
import '../model/trending_movies_model.dart';
import 'urls.dart';

class MovieServices {
//?Future function for fetching trending movies
  Future<List<TrendingMovie>> fetchTrendingMovies(String endPoint) async {
    // Making the HTTP GET request to fetch TV series
    final response = await http.get(
      Uri.parse('$endPoint?api_key=$apikey'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)['results'];
      List<TrendingMovie> tredingMovies =
          body.map((dynamic item) => TrendingMovie.fromJson(item)).toList();

      return tredingMovies;
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // //?Future function for tv-series
  Future<List<TvSeries>> fetchTvSeries() async {
    // Making the HTTP GET request to fetch TV series
    final response = await http.get(
      Uri.parse("$tvSeries?api_key=$apikey"),
    );

    // Check if the TV series have been fetched successfully
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body)[
          'results']; // Decode the response body and extract the list of TV series results
      List<TvSeries> tvSeries = body
          .map((dynamic value) => TvSeries.fromJson(value))
          .toList(); // Map the dynamic data to a list of TvSeries objects

// Return the list of TvSeries objects
      return tvSeries;
    } else {
      throw Exception('Failed to fetch TV series');
    }
  }
}
