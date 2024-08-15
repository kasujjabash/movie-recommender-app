import 'package:flutter/material.dart';
import 'package:movie/model/on_air_movies.dart';

class OnAirDetailsScreen extends StatelessWidget {
  final OnAirMovies playingmovie;

  const OnAirDetailsScreen({super.key, required this.playingmovie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(playingmovie.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the TV series image
            Image.network(
              'https://image.tmdb.org/t/p/original${playingmovie.posterPath}',
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
            const SizedBox(height: 20),
            // Display the TV series title
            const Text(
              'Movie story',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            // Display the TV series description
            Text(playingmovie.overview),
          ],
        ),
      ),
    );
  }
}
