import 'package:movie_review/models/genre.dart';

class GenreResponse {
  List<Genre> genres;
  String errors;

  GenreResponse(this.genres, this.errors);

  GenreResponse.fromJson(Map<String, dynamic> json)
      : genres =
            (json["genres"] as List).map((e) => Genre.fromJson(e)).toList(),
        errors = "";

  GenreResponse.withError(String error)
      : genres = List(),
        errors = error;
}
