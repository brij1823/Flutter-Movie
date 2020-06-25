import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/respository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MoviesListByGenreBloc {
  MovieRepository movieRepository = MovieRepository();
  BehaviorSubject<MovieResponse> behaviorSubject =
      BehaviorSubject<MovieResponse>();

  getMovieByGenre(int id) async {
    MovieResponse movieResponse = await movieRepository.getMoviesbyGenre(id);
    behaviorSubject.sink.add(movieResponse);
  }

  dispose() {
    behaviorSubject.close();
  }

  BehaviorSubject<MovieResponse> get subject => behaviorSubject;
}

final moviebygenreBloc = MoviesListByGenreBloc();
