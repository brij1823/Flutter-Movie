import 'package:movie_review/models/movie_detail_response.dart';
import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/respository/repository.dart';
import 'package:rxdart/rxdart.dart';

class MovieDetailbloc {
  MovieRepository movieRepository = MovieRepository();
  BehaviorSubject<MovieDetailResponse> behaviorSubject =
      BehaviorSubject<MovieDetailResponse>();

  getMovieDetails(int id) async {
    MovieDetailResponse movieDetailResponse =
        await movieRepository.getMovieDetails(id);
    behaviorSubject.sink.add(movieDetailResponse);
  }

  dispose() {
    behaviorSubject.close();
  }

  BehaviorSubject<MovieDetailResponse> get subject => behaviorSubject;
}

final getmoviedetailbloc = MovieDetailbloc();
