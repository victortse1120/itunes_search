import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SongController extends GetxController {
  var isLoading = true.obs;
  var responseJson = {}.obs;

  void fetchSongs(String term) async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://itunes.apple.com/search?term=$term'));
      responseJson.value = json.decode(response.body.toString());
    } finally {
      isLoading(false);
    }
  }
}