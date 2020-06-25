import 'package:dio/dio.dart';
import 'package:movie_review/models/cast_response.dart';
import 'package:movie_review/models/genre_response.dart';
import 'package:movie_review/models/movie_detail_response.dart';
import 'package:movie_review/models/movie_response.dart';
import 'package:movie_review/models/person_response.dart';
import 'package:movie_review/models/video_response.dart';

class MovieRepository {
  final String apiKey = "ca901ac5b1b28b9b7ad2ba20c412abb4";
  static String mainUrl = "https://api.themoviedb.org/3";
  final Dio dio = Dio();
  var getPopularUrl = '$mainUrl/movie/top_rated';
  var getMoviesUrl = '$mainUrl/discover/movie';
  var getPlayingUrl = '$mainUrl/movie/now_playing';
  var getGenresUrl = '$mainUrl/genre/movie/list';
  var getPersonUrl = '$mainUrl/trending/person/week';
  var movieUrl = '$mainUrl/movie';

  Future<MovieResponse> getMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(getPopularUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error) {
      return MovieResponse.withError("$error");
    }
  }

  Future<MovieResponse> getPlayingMovies() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(getPlayingUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (error) {
      return MovieResponse.withError('$error');
    }
  }

  Future<GenreResponse> getGenres() async {
    var params = {"api_key": apiKey, "language": "en-US", "page": 1};

    try {
      Response response = await dio.get(getGenresUrl, queryParameters: params);
      return GenreResponse.fromJson(response.data);
    } catch (error) {
      return GenreResponse.withError(error);
    }
  }

  Future<PersonResponse> getPerson() async {
    var params = {"api_key": apiKey};

    try {
      Response response = await dio.get(getPersonUrl, queryParameters: params);
      return PersonResponse.fromJson(response.data);
    } catch (e) {
      return PersonResponse.withError(e);
    }
  }

  Future<MovieResponse> getMoviesbyGenre(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
      "page": 1,
      "with_genres": id
    };

    try {
      Response response = await dio.get(getMoviesUrl, queryParameters: params);
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      return MovieResponse.withError(e);
    }
  }

  Future<MovieDetailResponse> getMovieDetails(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
    };

    try {
      Response response =
          await dio.get(movieUrl + "/$id", queryParameters: params);
      return MovieDetailResponse.jsonDecode(response.data);
    } catch (e) {
      return MovieDetailResponse.errors(e);
    }
  }

  Future<CastResponse> getCastResponse(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
    };

    try {
      Response response = await dio.get(movieUrl + "/$id" + "/credits",
          queryParameters: params);
      return CastResponse.jsonDecode(response.data);
    } catch (e) {
      return CastResponse.withErrors(e);
    }
  }

  Future<MovieResponse> getSimilarMovies(int id) async {
    var params = {
      "api_key": apiKey,
      "language": "en_US",
    };

    try {
      Response response = await dio.get(movieUrl + "/$id" + "/similar",
          queryParameters: params);
      print(response);
      return MovieResponse.fromJson(response.data);
    } catch (e) {
      return MovieResponse.withError(e);
    }
  }

  Future<VideoResponse> getVideo(int id) async {
    var params = {
      "api_key": apiKey,
      "languege": "en-US",
    };

    try {
      Response response =
          await dio.get(movieUrl + "/$id" + "/videos", queryParameters: params);
      return VideoResponse.jsonDecode(response.data);
    } catch (e) {
      return VideoResponse.withErrors(e);
    }
  }
}
