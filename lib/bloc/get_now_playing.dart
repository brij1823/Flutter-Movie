import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/respository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetNowPlayingBloc {
  MovieRepository movieRepository = MovieRepository();
  BehaviorSubject<MovieResponse> behaviorSubject =
      BehaviorSubject<MovieResponse>();

  getNowplaying() async {
    MovieResponse movieResponse = await movieRepository.getPlayingMovies();
    behaviorSubject.sink.add(movieResponse);
  }

  dispose() {
    behaviorSubject.close();
  }

  BehaviorSubject<MovieResponse> get subject => behaviorSubject;
}

final getPlayingBloc = GetNowPlayingBloc();
