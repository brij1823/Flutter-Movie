import 'package:movie_review/models/cast.dart';

class CastResponse {
  List<Cast> cast;
  String errors;

  CastResponse(this.cast, this.errors);

  CastResponse.jsonDecode(Map<String, dynamic> json)
      : cast = (json["cast"] as List).map((e) => Cast.jsonDecode(e)).toList(),
        errors = "";

  CastResponse.withErrors(String errorValue)
      : cast = List(),
        errors = errorValue;
}
