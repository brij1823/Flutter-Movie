import 'package:movie_review/models/cast_response.dart';
import 'package:movie_review/respository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetCastBloc {
  MovieRepository movieRepository = MovieRepository();
  BehaviorSubject<CastResponse> behaviorSubject =
      BehaviorSubject<CastResponse>();

  getCast(int id) async {
    CastResponse castResponse = await movieRepository.getCastResponse(id);
    behaviorSubject.sink.add(castResponse);
  }

  dispose() {
    behaviorSubject.close();
  }

  BehaviorSubject<CastResponse> get subject => behaviorSubject;
}

final getcastbloc = GetCastBloc();
