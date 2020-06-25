import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_review/bloc/get_movies_videos_bloc.dart';
import 'package:movie_review/models/movie.dart';
import 'package:movie_review/models/video.dart';
import 'package:movie_review/models/video_response.dart';
import 'package:movie_review/style/theme.dart';
import 'package:movie_review/widgets/get_cast_movie.dart';
import 'package:movie_review/widgets/get_similar_movies.dart';
import 'package:sliver_fab/sliver_fab.dart';

class MovieDetailScreen extends StatefulWidget {
  Movie movie;

  MovieDetailScreen(this.movie);
  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState(movie);
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  Movie movie;
  _MovieDetailScreenState(this.movie);
  @override
  void initState() {
    super.initState();
    getvideobloc.getVideos(movie.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsFix.mainColor,
      body: Builder(
        builder: (context) {
          return SliverFab(
            floatingWidget: StreamBuilder(
                stream: getvideobloc.subject.stream,
                builder: (context, AsyncSnapshot<VideoResponse> snapshot) {
                  if (snapshot.hasData) {
                    return _buildVideoWidget(snapshot.data);
                  } else if (snapshot.hasError) {
                    return _buildErrorWidget(snapshot.error);
                  } else {
                    return _buildLoadingWidget();
                  }
                }),
            expandedHeight: 200,
            floatingPosition: FloatingPosition(right: 20),
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: ColorsFix.mainColor,
                expandedHeight: 200,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(
                    movie.title.length > 30
                        ? movie.title.substring(0, 27) + '...'
                        : movie.title,
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                  background: Stack(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/original/' +
                                    movie.backposter),
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5)),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withOpacity(0.9),
                              Colors.black.withOpacity(0),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.all(10),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              movie.popularity.toStringAsFixed(1),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            RatingBar(
                              initialRating: movie.rating / 2,
                              minRating: 1,
                              itemSize: 20,
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
                        )),
                    Padding(
                      padding: EdgeInsets.only(top: 20, left: 15),
                      child: Text(
                        'Overview',
                        style: TextStyle(
                            color: ColorsFix.secondColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(top: 10, left: 10),
                        child: Text(
                          movie.overview,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        )),
                    getcastMovies(movie.id),
                    getsimilarMoviesWidget(movie.id),
                  ]),
                ),
              )
            ],
          );
        },
      ),
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

  Widget _buildVideoWidget(VideoResponse videoResponse) {
    List<Video> video = videoResponse.videos;
    return FloatingActionButton(
      backgroundColor: ColorsFix.secondColor,
      child: Icon(Icons.play_arrow),
      onPressed: null,
    );
  }
}
