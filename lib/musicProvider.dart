import 'package:get/get.dart';

class MusicProvider extends GetConnect {
  Future<Response> getMusic(String term) => get('https://itunes.apple.com/search?term=$term');
}