import 'package:movie_review/models/person_response.dart';
import 'package:movie_review/respository/repository.dart';
import 'package:rxdart/rxdart.dart';

class PersonListBloc {
  MovieRepository movieRepository = MovieRepository();
  BehaviorSubject<PersonResponse> behaviorSubject =
      BehaviorSubject<PersonResponse>();

  getPerson() async {
    PersonResponse personResponse = await movieRepository.getPerson();
    behaviorSubject.sink.add(personResponse);
  }

  dispose() {
    behaviorSubject.close();
  }

  BehaviorSubject<PersonResponse> get subject => behaviorSubject;
}

final personBloc = PersonListBloc();
