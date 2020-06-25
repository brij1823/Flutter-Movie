import 'package:movie_review/models/genre.dart';

class MovieDetail {
  int id;
  bool adult;
  int budget;
  List<Genre> genres;
  String releaseDates;
  int runtime;

  MovieDetail(this.id, this.adult, this.budget, this.genres, this.releaseDates,
      this.runtime);

  MovieDetail.jsonDecode(Map<String, dynamic> json)
      : id = json["id"],
        adult = json["adult"],
        budget = json["budget"],
        genres =
            (json["genres"] as List).map((e) => Genre.fromJson(e)).toList(),
        releaseDates = json["release_date"],
        runtime = json["runtime"];
}
