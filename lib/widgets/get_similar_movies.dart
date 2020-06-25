import 'package:flutter/material.dart';
import 'package:movie_review/bloc/get_movies_similar_bloc.dart';
import 'package:movie_review/models/movie.dart';
import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/style/theme.dart';

import 'package:movie_review/screens/movieDetail.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class getsimilarMoviesWidget extends StatefulWidget {
  int id;

  getsimilarMoviesWidget(this.id);
  @override
  _getsimilarMoviesWidgetState createState() =>
      _getsimilarMoviesWidgetState(this.id);
}

class _getsimilarMoviesWidgetState extends State<getsimilarMoviesWidget> {
  int id;

  @override
  void initState() {
    super.initState();
    getsimilarMovies.getSimilarMovies(id);
  }

  _getsimilarMoviesWidgetState(this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.only(left: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Similar Movies',
            style: TextStyle(
                fontSize: 20,
                color: ColorsFix.secondColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
          ),
          StreamBuilder(
              stream: getsimilarMovies.subject.stream,
              builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
                if (snapshot.hasData) {
                  return _homeMovies(snapshot.data);
                } else if (snapshot.hasError) {
                  return hasError(snapshot.error);
                } else {
                  return _loading();
                }
              })
        ],
      ),
    );
  }

  Widget _loading() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 25,
              height: 25,
              child: CircularProgressIndicator(
                strokeWidth: 4,
                backgroundColor: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget hasError(String error) {
    return Container(
      child: Column(
        children: <Widget>[
          Text('$error'),
        ],
      ),
    );
  }

  Widget _homeMovies(MovieResponse movieResponse) {
    List<Movie> movies = movieResponse.movies;
    return Container(
        height: 300,
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(movies[index]))),
                child: Container(
                  padding: EdgeInsets.only(left: 12),
                  child: Column(
                    children: <Widget>[
                      movies[index].poster == null
                          ? Container()
                          : Container(
                              height: 200,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w200/' +
                                          movies[index].poster),
                                ),
                              ),
                            ),
                      Container(
                        width: 120,
                        height: 40,
                        child: Text(
                          movies[index].title,
                          maxLines: 2,
                          style: TextStyle(
                            color: ColorsFix.titleColor,
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        child: RatingBar(
                          initialRating: movies[index].rating / 2,
                          minRating: 1,
                          itemSize: 12,
                          direction: Axis.horizontal,
                          allowHalfRating: true,
                          itemCount: 5,
                          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                          itemBuilder: (context, _) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          onRatingUpdate: (rating) {
                            print(rating);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            }));
  }
}
