import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_review/bloc/get_cast_bloc.dart';
import 'package:movie_review/models/cast.dart';
import 'package:movie_review/models/cast_response.dart';
import 'package:movie_review/style/theme.dart';

class getcastMovies extends StatefulWidget {
  int id;

  getcastMovies(this.id);
  @override
  _getcastMoviesState createState() => _getcastMoviesState(id);
}

class _getcastMoviesState extends State<getcastMovies> {
  int id;

  @override
  void initState() {
    super.initState();
    getcastbloc.getCast(id);
  }

  _getcastMoviesState(this.id);
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, top: 20),
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Cast',
            style: TextStyle(
                fontSize: 20,
                color: ColorsFix.secondColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.2),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: StreamBuilder(
                stream: getcastbloc.subject.stream,
                builder: (context, AsyncSnapshot<CastResponse> snapshot) {
                  if (snapshot.hasData) {
                    return _buildCast(snapshot.data);
                  } else if (snapshot.hasError) {
                    return _buildErrorWidget(snapshot.error);
                  } else {
                    return _buildLoadingWidget();
                  }
                }),
          )
        ],
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

  Widget _buildCast(CastResponse castResponse) {
    List<Cast> casts = castResponse.cast;
    if (casts.length == 0) {
      return Container(
        child: Column(
          children: <Widget>[Text('No Cast Data Available')],
        ),
      );
    } else {
      return Container(
        height: 120,
        child: ListView.builder(
            itemCount: casts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(left: 8),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      casts[index].img == null
                          ? Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.account_circle,
                                size: 70,
                                color: ColorsFix.secondColor,
                              ))
                          : Container(
                              width: 70,
                              height: 70,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: NetworkImage(
                                        'https://image.tmdb.org/t/p/w200' +
                                            casts[index].img),
                                    fit: BoxFit.cover),
                              ),
                            ),
                      Text(
                        casts[index].name,
                        style: TextStyle(color: Colors.white, fontSize: 12),
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
