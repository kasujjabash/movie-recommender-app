import 'package:flutter/material.dart';
import '../model/tv_series_model.dart';

class DetailsPage extends StatelessWidget {
  final TvSeries tvseries;

  const DetailsPage({super.key, required this.tvseries});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tvseries.name), 
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the TV series image
            Image.network(
              'https://image.tmdb.org/t/p/original${tvseries.posterPath}',
              height: 200,
              width: MediaQuery.of(context).size.width,
            ), 
            const SizedBox(height: 20),
            // Display the TV series title
            const Text(
              'Movie story', 
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 10),
            // Display the TV series description
            Text(tvseries
                .overview), 
            
          ],
        ),
      ),
    );
  }
}
