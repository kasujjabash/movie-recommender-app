import 'package:flutter/material.dart';
import 'package:movie/api/service.dart';
import 'package:movie/componets/on_air_tile.dart';

import 'package:movie/model/on_air_movies.dart';

class OnAirMoviesPage extends StatefulWidget {
  const OnAirMoviesPage({
    super.key,
  });

  @override
  State<OnAirMoviesPage> createState() => _OnAirMoviesPageState();
}

class _OnAirMoviesPageState extends State<OnAirMoviesPage> {
  // An instance for the service function
  final MovieServices _movieServices = MovieServices();

  // An empty list to store the on aire movie
  List<OnAirMovies> _onair = [];

  // initState
  @override
  void initState() {
    super.initState();
    _fetchOnAirMovie();
  }

  Future<void> _fetchOnAirMovie() async {
    final onair = await _movieServices.onAir(); // Fetch TV series
    setState(() {
      _onair = onair; // Update the onair list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<OnAirMovies>>(
        future: _movieServices.onAir(),
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
              child: Text("No TV series available"),
            );
          } else {
            final onAirList = snapshot.data!; // Extract the list of TV series

            // Split the list into two parts for two rows
            final int halfLength = (onAirList.length / 2).ceil();
            final List<OnAirMovies> firstRowSeries =
                onAirList.take(halfLength).toList();
            final List<OnAirMovies> secondRowSeries =
                onAirList.skip(halfLength).toList();

            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Popular text
                    const Text(
                      'Popular Movies playing',
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
                        itemCount: firstRowSeries.length,
                        itemBuilder: (context, index) {
                          return OnAirMovieTile(
                              playingmovie: firstRowSeries[index]);
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Now playing text
                    const Text(
                      'Now playing',
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
                        itemCount: secondRowSeries.length,
                        itemBuilder: (context, index) {
                          return OnAirMovieTile(
                              playingmovie: secondRowSeries[index]);
                        },
                      ),
                    ),

                    SizedBox(
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
