import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

import '../models/song.dart';

class SongController extends GetxController {
  var isLoading = false.obs;
  var isInit = true.obs;
  var songList = [].obs;

  var isPlaying = false.obs;
  var songPlaying = Song().obs;
  var audioPlayer = AudioPlayer();

  @override
  void onInit() {
    super.onInit();
    audioPlayer.playerStateStream.listen((state) {
      if (state.playing) {
        if (state.processingState == ProcessingState.completed) {
          isPlaying(false);
        } else {
          isPlaying(true);
        }
      } else {
        isPlaying(false);
      }
    });
  }

  void fetchSongs(String term) async {
    try {
      isInit(false);
      isLoading(true);
      var response = await http.get(Uri.parse('https://itunes.apple.com/search?term=$term&attribute=artistTerm'));
      var responseJson = json.decode(response.body.toString());
      songList.value = (responseJson['results'] as List)
          .map((itemJson) => Song.fromJson(itemJson))
          .toList();
    } finally {
      isLoading(false);
    }
  }

  Future<void> playSong(Song song) async {
    if (songPlaying.value.trackId != song.trackId) {
      songPlaying(song);
      await audioPlayer.stop();
      await audioPlayer.setUrl(song.previewUrl!);
      audioPlayer.play();
    } else {
      if (isPlaying.value) {
        await audioPlayer.pause();
      } else if (audioPlayer.processingState == ProcessingState.completed) {
        await audioPlayer.seek(const Duration(seconds: 0));
        audioPlayer.play();
      } else {
        audioPlayer.play();
      }
    }
  }

  void prevSong() async {
    int songIndex = songList.indexWhere((song) => song.trackId == songPlaying.value.trackId);
    if (songIndex == 0) {
      await audioPlayer.seek(const Duration(seconds: 0));
      audioPlayer.play();
    } else {
      playSong(songList[songIndex-1]);
    }
  }

  void nextSong() async {
    int songIndex = songList.indexWhere((song) => song.trackId == songPlaying.value.trackId);
    if (songIndex == songList.length-1) {
      playSong(songList[0]);
      audioPlayer.play();
    } else {
      playSong(songList[songIndex+1]);
    }
  }
}