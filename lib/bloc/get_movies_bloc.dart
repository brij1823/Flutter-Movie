import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/respository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieListBloc {
  MovieRepository _repository = MovieRepository();

  BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

  getMovies() async {
    MovieResponse response = await _repository.getMovies();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<MovieResponse> get subject => _subject;
}

final moviesBloc = MovieListBloc();
