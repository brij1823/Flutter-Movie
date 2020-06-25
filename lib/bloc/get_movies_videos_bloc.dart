import 'package:movie_review/models/video_response.dart';
import 'package:movie_review/respository/repository.dart';
import 'package:rxdart/rxdart.dart';

class GetVideos{
  MovieRepository movieRepository = MovieRepository();
  BehaviorSubject<VideoResponse> behaviorSubject = BehaviorSubject<VideoResponse>();

  getVideos(int id) async{
    VideoResponse videoResponse =await movieRepository.getVideo(id);
    behaviorSubject.sink.add(videoResponse);
  }
  dispose(){
    behaviorSubject.close();
  }

  BehaviorSubject<VideoResponse> get subject => behaviorSubject;

}

final getvideobloc = GetVideos();