import 'package:movie_review/models/movie.dart';

class MovieResponse {
  List<Movie> movies;
  String errors;

  MovieResponse(this.movies, this.errors);

  MovieResponse.fromJson(Map<String, dynamic> json)
      : movies = (json["results"] as List)
            .map((e) => new Movie.fromJson(e))
            .toList(),
        errors = "";

  MovieResponse.withError(String errorValue)
      : movies = List(),
        errors = errorValue;
}
