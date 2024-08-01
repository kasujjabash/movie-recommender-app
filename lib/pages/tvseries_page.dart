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
  //An instance for the service function
  final MovieServices _movieServices = MovieServices();

  //Am empty list to store the tv-series
  List<TvSeries> _series = [];

  //initState
  @override
  void initState() {
    super.initState();
    _fetchTvSeries();
  }

  Future<void> _fetchTvSeries() async {
    final series = await _movieServices.fetchTvSeries(); //  Fetch TV series
    setState(() {
      _series = series; // Update the movie list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<TvSeries>>(
          future: _movieServices.fetchTvSeries(),
          builder: (context, snapshot) {
            //checking if the data is loading
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
                child: Text("No TV serie availabe"),
              );
            } else {
              final tvSeriesList =
                  snapshot.data!; // Extract the list of TV series
              return Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    //popular text
                    const Text(
                      'Popular Tv series',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    //Popular images tile
                    SizedBox(
                      height: 300,
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: tvSeriesList.length,
                        itemBuilder: (context, i) {
                          return TvSeriesTile(tvseries: tvSeriesList[i]);
                        },
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}
