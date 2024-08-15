import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movie/api/urls.dart';

import '../model/trending_movies_model.dart';
import '../api/service.dart';
import 'popular_movies_page.dart';
import 'tvseries_page.dart';
import 'on_air.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  // Instance of the MovieService
  final MovieServices _movieServices = MovieServices();

  // Initialize an empty list to store movies fetched from the API
  List<TrendingMovie> _movies = [];

  // TabController for managing tabs
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _fetchTrendingMovies(); // Call the fetch function
  }

  Future<void> _fetchTrendingMovies() async {
    final movies = await _movieServices
        .fetchTrendingMovies(trendingMovies); // Fetch movies
    setState(() {
      _movies = movies; // Update the movie list
    });
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose of the TabController when not needed
    super.dispose();
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
              background: FutureBuilder<List<TrendingMovie>>(
                future: _movieServices.fetchTrendingMovies(trendingMovies),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No movies available.'));
                  } else {
                    return CarouselSlider(
                      items: snapshot.data!.map((movie) {
                        return Builder(
                          builder: (BuildContext context) {
                            return SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                'https://image.tmdb.org/t/p/original/${movie.posterPath}',
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        height: MediaQuery.of(context).size.height,
                      ),
                    );
                  }
                },
              ),
            ),
            title: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Trending',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(kToolbarHeight),
              child: Container(
                color: const Color.fromARGB(185, 0, 0, 0),
                child: TabBar(
                  labelColor: Colors.green,
                  indicatorColor: Colors.green,
                  unselectedLabelColor: Colors.white,
                  controller: _tabController,
                  tabs: const [
                    Tab(text: "Popular Movies"),
                    Tab(text: "On Air"),
                    Tab(text: "Tv Series"),
                  ],
                ),
              ),
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: const [
                PopularMovies(),
                OnAirMoviesPage(),
                TvseriesPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
