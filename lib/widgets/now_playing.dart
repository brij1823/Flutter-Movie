import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_review/bloc/get_now_playing.dart';
import 'package:movie_review/models/movie.dart';
import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/style/theme.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatefulWidget {
  @override
  _NowPlayingState createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> {
  @override
  void initState() {
    super.initState();
    getPlayingBloc.getNowplaying();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getPlayingBloc.subject.stream,
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

  Widget _buildHomeWidget(MovieResponse data) {
    List<Movie> movies = data.movies;
    if (movies.length == 0) {
      return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[Text('No Movies Present')],
        ),
      );
    } else {
      return Container(
        height: 220,
        child: PageIndicatorContainer(
          align: IndicatorAlign.bottom,
          indicatorSpace: 8,
          length: movies.take(5).length,
          padding: EdgeInsets.all(5),
          indicatorColor: ColorsFix.titleColor,
          shape: IndicatorShape.circle(size: 5),
          indicatorSelectorColor: ColorsFix.secondColor,
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.take(5).length,
              itemBuilder: (context, index) {
                return Stack(
                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 220,
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://image.tmdb.org/t/p/original/" +
                                      movies[index].backposter))),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                            ColorsFix.mainColor.withOpacity(1),
                            ColorsFix.mainColor.withOpacity(0),
                          ],
                              stops: [
                            0.0,
                            0.9
                          ])),
                    ),
                    Container(
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.playCircle,
                          color: ColorsFix.secondColor,
                          size: 50,
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          movies[index].title,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2),
                        ),
                      ),
                    )
                  ],
                );
              }),
        ),
      );
    }
  }
}
