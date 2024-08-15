import 'package:flutter/material.dart';
import 'package:movie/api/service.dart';

import 'package:movie/model/popular_movies_model.dart';

import '../componets/popular_movie_tile.dart';

class PopularMovies extends StatefulWidget {
  const PopularMovies({
    super.key,
  });

  @override
  State<PopularMovies> createState() => _PopularMoviesState();
}

class _PopularMoviesState extends State<PopularMovies> {
  // An instance for the service function
  final MovieServices _movieServices = MovieServices();

  // An empty list to store the on aire movie
  List<PopularMoviesModule> _popularmovie = [];

  // initState
  @override
  void initState() {
    super.initState();
    _fetchPopularMovies();
  }

  Future<void> _fetchPopularMovies() async {
    final popularmovie =
        await _movieServices.popularMovies(); // Fetch TV series
    setState(() {
      _popularmovie = popularmovie; // Update the onair list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<PopularMoviesModule>>(
        future: _movieServices.popularMovies(),
        builder: (context, snapshot) {
          // Checking if the data is loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("Movie not availabe"),
            );
          } else {
            final popularList = snapshot.data!; // Extract the list of TV series

            // Split the list into two parts for two rows
            final int halfLength = (popularList.length / 2).ceil();
            final List<PopularMoviesModule> firstRowPopularMovie =
                popularList.take(halfLength).toList();
            final List<PopularMoviesModule> secondRowPopularMovie =
                popularList.skip(halfLength).toList();

            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Popular text
                    const Text(
                      'For you',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    // First row of TV series
                    SizedBox(
                      height: 200, // Adjust height as needed
                      child: ListView.builder(
                        // physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: firstRowPopularMovie.length,
                        itemBuilder: (context, index) {
                          return PopularMovieTile(
                              commonmovie: firstRowPopularMovie[index]);
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Now playing text
                    const Text(
                      'Must watch',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    // Second row of TV series
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        // physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: secondRowPopularMovie.length,
                        itemBuilder: (context, index) {
                          return PopularMovieTile(
                              commonmovie: secondRowPopularMovie[index]);
                        },
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
