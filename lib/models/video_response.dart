import 'package:movie_review/models/video.dart';

class VideoResponse {
  List<Video> videos;
  String errors;

  VideoResponse(this.videos, this.errors);

  VideoResponse.jsonDecode(Map<String, dynamic> json)
      : videos =
            (json["results"] as List).map((e) => Video.jsonDecode(e)).toList(),
        errors = "";

  VideoResponse.withErrors(String errorVal)
      : videos = List(),
        errors = errorVal;
}
