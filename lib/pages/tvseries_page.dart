import 'package:flutter/material.dart';
import 'package:movie/api/service.dart';
import 'package:movie/componets/tv_series_tile.dart';

import '../model/tv_series_model.dart';

class TvseriesPage extends StatefulWidget {
  const TvseriesPage({super.key});

  @override
  State<TvseriesPage> createState() => _TvseriesPageState();
}

class _TvseriesPageState extends State<TvseriesPage> {
  // An instance for the service function
  final MovieServices _movieServices = MovieServices();

  // An empty list to store the TV series
  List<TvSeries> _series = [];

  // initState
  @override
  void initState() {
    super.initState();
    _fetchTvSeries();
  }

  Future<void> _fetchTvSeries() async {
    final series = await _movieServices.fetchTvSeries(); // Fetch TV series
    setState(() {
      _series = series; // Update the TV series list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TvSeries>>(
        future: _movieServices.fetchTvSeries(),
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
            final tvSeriesList =
                snapshot.data!; // Extract the list of TV series

            // Split the list into two parts for two rows
            final int halfLength = (tvSeriesList.length / 2).ceil();
            final List<TvSeries> firstRowSeries =
                tvSeriesList.take(halfLength).toList();
            final List<TvSeries> secondRowSeries =
                tvSeriesList.skip(halfLength).toList();

            return Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    // Popular text
                    const Text(
                      'Popular TV Series',
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
                          return TvSeriesTile(tvseries: firstRowSeries[index]);
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
                          return TvSeriesTile(tvseries: secondRowSeries[index]);
                        },
                      ),
                    ),
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
