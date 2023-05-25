import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:itunes_search/widgets/player_bar.dart';
import 'package:itunes_search/widgets/search_bar.dart';
import 'package:itunes_search/widgets/song_card.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'controllers/songController.dart';
import 'message.dart';

void main() {
  runApp(GetMaterialApp(
      translations: Messages(),
      locale: Get.deviceLocale,
      fallbackLocale: const Locale('en', 'US'),
      home: const MyHomePage()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SongController songController = Get.put(SongController());
  final TextEditingController searchController = TextEditingController();
  final _focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'iTunes Search',
        ),
        backgroundColor: Colors.grey,
      ),
        drawer: Drawer(
          child: ListView(
            children: [
              ListTile(
                  title: Text('language'.tr),
                  trailing: ToggleSwitch(
                      initialLabelIndex:
                          (Get.locale?.languageCode == 'zh') ? 1 : 0,
                      activeBgColor: [Colors.grey[900]!],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.grey,
                      inactiveFgColor: Colors.grey[900],
                      labels: const ['ENG', '繁'],
                      onToggle: (index) {
                        index == 0
                            ? Get.updateLocale(const Locale('en', 'US'))
                            : Get.updateLocale(const Locale('zh', 'HK'));
                      }))
            ],
          ),
        ),
        body: SizedBox(
            width: Get.width,
            height: (Get.height - AppBar().preferredSize.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0),
                  child: SearchBar(searchController: searchController, focusNode: _focusNode, songController: songController),
                ),
                Expanded(
                  child: Obx(() {
                    if (songController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator(color: Colors.grey,));
                    } else if (songController.isInit.isTrue) {
                      return Column();
                    } else {
                      if (songController.songList.isEmpty) {
                        return Center(
                            child: Text('no song'.tr));
                      }
                      List<Widget> widgets = songController.songList
                          .map((song) => SongCard(songController: songController, song: song,))
                          .toList();
                      return SingleChildScrollView(
                          child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32.0),
                        child: Column(children: widgets),
                      ));
                    }
                  }),
                ),
                PlayerBar(songController: songController)
              ],
            )));
  }
}






