import 'package:flutter/material.dart';
import 'package:movie/api/urls.dart';
import 'package:movie/model/tv_series_model.dart';

import '../pages/details_page.dart';

class TvSeriesTile extends StatelessWidget {
  final TvSeries tvseries;
  const TvSeriesTile({super.key, required this.tvseries});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsPage(tvseries: tvseries),
            ),
          );
        },
        child: Container(
          width: 200,
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(
                'https://image.tmdb.org/t/p/original${tvseries.posterPath}',
              ),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5),
                BlendMode.darken,
              ),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // first air date
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 6),
                child: Text(
                  tvseries.first_air_date,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),

              //rating
              Padding(
                padding: const EdgeInsets.only(top: 4, left: 6, right: 2),
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: const Color.fromARGB(158, 0, 0, 0),
                  ),
                  child: Row(
                    children: [
                      //Star Icon
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      //rating
                      Text(
                        tvseries.vote_average.toString(),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
    // ListTile(
    //     title: Text(tvseries.name),
    //     // subtitle: Text(tvseries.overview),
    //     leading: Image.network(
    //       'https://image.tmdb.org/t/p/original${tvseries.posterPath}',
    //       width: 50,
    //       height: 50,
    //       fit: BoxFit.cover,
    //     ),);
  }
}
