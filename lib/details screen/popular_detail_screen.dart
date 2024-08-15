import 'package:flutter/material.dart';
import 'package:movie/model/popular_movies_model.dart';

class PopularDetailsScreen extends StatelessWidget {
  final PopularMoviesModule commonmovie;

  const PopularDetailsScreen({super.key, required this.commonmovie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(commonmovie.name),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the TV series image
            Image.network(
              'https://image.tmdb.org/t/p/original${commonmovie.posterPath}',
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
            Text(commonmovie.overview),
          ],
        ),
      ),
    );
  }
}
