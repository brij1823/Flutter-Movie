import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/respository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetMoviessimilarBloc {
  MovieRepository movieRepository = MovieRepository();
  BehaviorSubject<MovieResponse> behaviorSubject =
      BehaviorSubject<MovieResponse>();

  getSimilarMovies(int id) async {
    MovieResponse movieResponse = await movieRepository.getSimilarMovies(id);
    behaviorSubject.sink.add(movieResponse);
  }

  dispose() {
    behaviorSubject.close();
  }

  BehaviorSubject<MovieResponse> get subject => behaviorSubject;
}

final getsimilarMovies = GetMoviessimilarBloc();
