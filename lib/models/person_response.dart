import 'package:movie_review/models/person.dart';

class PersonResponse {
  List<PersonModel> persons;
  String error;

  PersonResponse(this.persons, this.error);

  PersonResponse.fromJson(Map<String, dynamic> json)
      : persons = (json["results"] as List)
            .map((e) => PersonModel.fromJson(e))
            .toList(),
        error = "";

  PersonResponse.withError(String errorValue)
      : persons = List(),
        error = errorValue;
}
