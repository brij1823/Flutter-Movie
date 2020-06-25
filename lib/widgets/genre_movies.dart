import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_review/bloc/get_movies_by_genre.dart';
import 'package:movie_review/models/movie.dart';
import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/screens/movieDetail.dart';
import 'package:movie_review/style/theme.dart';

class Genremovies extends StatefulWidget {
  int genreID;

  Genremovies(this.genreID);
  @override
  _GenremoviesState createState() => _GenremoviesState(genreID);
}

class _GenremoviesState extends State<Genremovies> {
  int genreID;

  _GenremoviesState(this.genreID);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    moviebygenreBloc.getMovieByGenre(genreID);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: moviebygenreBloc.subject.stream,
      builder: (context, AsyncSnapshot<MovieResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.errors != null && snapshot.data.errors.length > 0) {
            return _buildErrorWidget(snapshot.data.errors);
          }
          return _buildHomeWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 25.0,
          width: 25.0,
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 4.0,
          ),
        )
      ],
    ));
  }

  Widget _buildErrorWidget(String error) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Error occured: $error"),
      ],
    ));
  }

  Widget _buildHomeWidget(MovieResponse movieResponse) {
    List<Movie> movie = movieResponse.movies;
    if (movie.length == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[Text('No Movies in this Genre')],
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
                onTap:()=> Navigator.push(context, MaterialPageRoute(builder:(_)=> MovieDetailScreen(movie[index]))),
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
                            initialRating: movie[index].rating/2,
                            minRating: 1,
                            itemSize: 10,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                             },
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
