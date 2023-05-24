import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class SongController extends GetxController {
  var isLoading = true.obs;
  var responseJson = {}.obs;

  var isPlaying = false.obs;
  var audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        isPlaying(true);
      } else {
        isPlaying(false);
      }
    });
  }

  void fetchSongs(String term) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://itunes.apple.com/search?term=$term'));
      responseJson.value = json.decode(response.body.toString());
      responseJson['isPlaying'] = false;
    } finally {
      isLoading(false);
    }
  }

  void playSong(String url) async {
    await audioPlayer.setUrl(url);
    await audioPlayer.play();
  }

  void pauseSong() async {
    await audioPlayer.pause();
  }

  void stopSong() async {
    await audioPlayer.stop();
  }
}