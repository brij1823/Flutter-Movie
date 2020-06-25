class Movie {
  int id;
  double popularity;
  String title;
  String backposter;
  String poster;
  String overview;
  double rating;

  Movie(this.id, this.popularity, this.title, this.backposter, this.poster,
      this.overview, this.rating);

  Movie.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"].toDouble(),
        title = json["title"],
        backposter = json["backdrop_path"],
        poster = json["poster_path"],
        overview = json["overview"],
        rating = json["vote_average"].toDouble();
}
