import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:movie_review/style/theme.dart';
import 'package:movie_review/widgets/genres.dart';
import 'package:movie_review/widgets/get_movies.dart';
import 'package:movie_review/widgets/get_person.dart';
import 'package:movie_review/widgets/now_playing.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsFix.mainColor,
      appBar: AppBar(
        backgroundColor: ColorsFix.mainColor,
        centerTitle: true,
        title: Text('Tobi'),
        leading: Icon(
          EvaIcons.menu2Outline,
          color: Colors.white,
        ),
        actions: <Widget>[
          Icon(
            EvaIcons.searchOutline,
            color: Colors.white,
          )
        ],
      ),
      body: ListView(
        children: <Widget>[
          NowPlaying(),
          Genres(),
          Person(),
          TopMovies(),
          
        ],
      ),
    );
  }
}
