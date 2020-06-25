import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_review/bloc/get_movies_bloc.dart';
import 'package:movie_review/models/movie.dart';
import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/style/theme.dart';

import 'package:movie_review/screens/movieDetail.dart';

class TopMovies extends StatefulWidget {
  @override
  _TopMoviesState createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviesBloc.getMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 20, bottom: 20),
            child: Text(
              'Top Rated Movies',
              style: TextStyle(
                color: ColorsFix.titleColor,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
          ),
          StreamBuilder(
              stream: moviesBloc.subject.stream,
              builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
                if (snapshot.hasData) {
                  return _buildHome(snapshot.data);
                } else if (snapshot.hasError) {
                  return _buildErrors();
                } else {
                  return _buildLoading();
                }
              })
        ],
      ),
    );
  }

  Widget _buildLoading() {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 25,
              width: 25,
              child: CircularProgressIndicator(
                strokeWidth: 4.0,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildErrors() {
    return Container(
      child: Column(
        children: <Widget>[Text('Errors')],
      ),
    );
  }

  Widget _buildHome(MovieResponse movieResponse) {
    List<Movie> movie = movieResponse.movies;
    if (movie.length == 0) {
      return Container(
        child: Column(
          children: <Widget>[Text('No Movies Present')],
        ),
      );
    } else {
      return Container(
        height: 300,
        padding: EdgeInsets.only(left: 10),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => MovieDetailScreen(movie[index]))),
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    children: <Widget>[
                      movie[index].poster == null
                          ? Container(
                              width: 120,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: ColorsFix.secondColor,
                                  borderRadius: BorderRadius.circular(20),
                                  shape: BoxShape.rectangle),
                              child: Column(
                                children: <Widget>[
                                  Icon(
                                    EvaIcons.filmOutline,
                                    color: Colors.white,
                                    size: 50,
                                  )
                                ],
                              ),
                            )
                          : Container(
                              width: 120,
                              height: 180,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w200/' +
                                            movie[index].poster),
                                    fit: BoxFit.cover),
                              ),
                            ),
                      SizedBox(height: 10),
                      Container(
                        width: 100,
                        child: Text(
                          movie[index].title,
                          maxLines: 2,
                          style: TextStyle(
                              height: 1.4,
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            movie[index].popularity.toStringAsFixed(1),
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 11),
                          ),
                          SizedBox(
                            width: 8,
                          ),
                          RatingBar(
                            initialRating: movie[index].rating / 2,
                            minRating: 1,
                            itemSize: 10,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {},
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            }),
      );
    }
  }
}
