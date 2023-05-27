import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': {
      'language': 'Language',
      'search': 'Search',
      'no song': 'Sorry, no song found.',
      'unknown track': 'Unknown Track',
      'unknown artist': 'Unknown Artist',
      'unknown album': 'Unknown Album'
    },
    'zh_HK': {
      'language': '語言',
      'search': '搜尋',
      'no song': '抱歉，找不到歌曲',
      'unknown track': '未知歌曲',
      'unknown artist': '未知藝人',
      'unknown album': '未知專輯'
    }
  };
}