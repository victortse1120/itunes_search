import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

class SongController extends GetxController {
  var isLoading = true.obs;
  var responseJson = {}.obs;

  var isPlaying = false.obs;
  var songPlaying = 0.obs;
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
      isLoading(true);
      var response = await http.get(Uri.parse('https://itunes.apple.com/search?term=$term&attribute=artistTerm'));
      responseJson.value = json.decode(response.body.toString());
    } finally {
      isLoading(false);
    }
  }

  void playSong(String url, int trackId) async {
    if (songPlaying.value != trackId) {
      songPlaying.value = trackId;
      await audioPlayer.stop();
      await audioPlayer.setUrl(url);
      await audioPlayer.play();
    } else {
      if (isPlaying.value) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.play();
      }
    }
  }
}