import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../api/model/movie_model.dart';
import '../api/service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MovieServices _movieServices =
      MovieServices(); //? This is an instance to the MovieService
  List<Movie> _movies = []; // initialize an empty list

  @override
  void initState() {
    super.initState();
    _fetchMovies(); // call the fetch function
  }

  Future<void> _fetchMovies() async {
    final movies = await _movieServices.fetcheMovies(); // fetch movies
    setState(() {
      _movies = movies; // update the movie list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            centerTitle: true,
            toolbarHeight: 60,
            pinned: true,
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              background: FutureBuilder(
                future: _fetchMovies(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return CarouselSlider(
                      items: _movies.map((movies) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.network(
                                  'https://image.tmdb.org/t/p/original/${[
                                'poster_path'
                              ]}'),
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 1),
                          height: MediaQuery.of(context).size.height),
                    );
                  }
                },
              ),
            ),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Trending'),
                SizedBox(
                  width: 10,
                )
              ],
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            const Center(
              child: Text('Simple Text'),
            )
          ]))
        ],
      ),
    );
  }
}
