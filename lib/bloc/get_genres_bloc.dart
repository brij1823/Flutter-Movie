import 'package:movie_review/models/genre_response.dart';
import 'package:movie_review/respository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GenresListBloc {
  MovieRepository repository = MovieRepository();
  BehaviorSubject<GenreResponse> _behaviorSubject =
      BehaviorSubject<GenreResponse>();

  getGenres() async {
    GenreResponse genreResponse = await repository.getGenres();
    _behaviorSubject.sink.add(genreResponse);
  }

  dispose() {
    _behaviorSubject.close();
  }

  BehaviorSubject<GenreResponse> get subject => _behaviorSubject;
}

final genreBloc = GenresListBloc();
