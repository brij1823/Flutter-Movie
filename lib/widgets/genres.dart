import 'package:flutter/material.dart';
import 'package:movie_review/bloc/get_genres_bloc.dart';
import 'package:movie_review/models/genre.dart';
import 'package:movie_review/models/genre_response.dart';
import 'package:movie_review/widgets/genre_list.dart';

class Genres extends StatefulWidget {
  @override
  _GenresState createState() => _GenresState();
}

class _GenresState extends State<Genres> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genreBloc.getGenres();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: genreBloc.subject.stream,
        builder: (context, AsyncSnapshot<GenreResponse> snapshot) {
          if (snapshot.hasData) {
            return _buildHome(snapshot.data);
          } else if (snapshot.hasError) {
            return _buildErrors();
          } else {
            return _buildLoading();
          }
        }
      );
  }
}

Widget _buildLoading() {
  return Center(
    child: Column(
      children: <Widget>[
        SizedBox(
          width: 25,
          height: 25,
          child: CircularProgressIndicator(
            strokeWidth: 4,
          ),
        )
      ],
    ),
  );
}

Widget _buildErrors() {
  return Center(
    child: Column(
      children: <Widget>[Text('Error in loading genre')],
    ),
  );
}

Widget _buildHome(GenreResponse genreResponse) {
  List<Genre> genres = genreResponse.genres;

  if (genres.length == 0) {
    return Container(
      child: Text('No Genres'),
    );
  } else {
    return GenreList(genres);
  }
}
