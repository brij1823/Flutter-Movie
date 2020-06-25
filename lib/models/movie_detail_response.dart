import 'package:movie_review/models/movie_details.dart';

class MovieDetailResponse {
  MovieDetail movieDetail;
  String error;

  MovieDetailResponse(this.movieDetail, this.error);

  MovieDetailResponse.jsonDecode(Map<String, dynamic> json)
      : movieDetail = MovieDetail.jsonDecode(json),
        error = "";

  MovieDetailResponse.errors(String errorValue)
      : movieDetail = MovieDetail(null, null, null, null, "", null),
        error = errorValue;
}
