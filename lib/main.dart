import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:itunes_search/widgets/player_bar.dart';
import 'package:itunes_search/widgets/search_bar.dart' as searchbar;
import 'package:itunes_search/widgets/song_card.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'controllers/songController.dart';
import 'message.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        translations: Messages(),
        locale: Get.deviceLocale,
        fallbackLocale: const Locale('en', 'US'),
        theme: ThemeData(
          primaryColor: Colors.white,
          textTheme: TextTheme(
            displayLarge: GoogleFonts.roboto(
                fontSize: 96, fontWeight: FontWeight.w300, letterSpacing: -1.5),
            displayMedium: GoogleFonts.roboto(
                fontSize: 60, fontWeight: FontWeight.w300, letterSpacing: -0.5),
            displaySmall:
                GoogleFonts.roboto(fontSize: 48, fontWeight: FontWeight.w400),
            headlineMedium: GoogleFonts.roboto(
                fontSize: 34, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            headlineSmall:
                GoogleFonts.roboto(fontSize: 24, fontWeight: FontWeight.w400),
            titleLarge: GoogleFonts.roboto(
                fontSize: 20, fontWeight: FontWeight.w500, letterSpacing: 0.15, color: Colors.white),
            titleMedium: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.15),
            titleSmall: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 0.1),
            bodyLarge: GoogleFonts.roboto(
                fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
            bodyMedium: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
            labelLarge: GoogleFonts.roboto(
                fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25, color: Colors.white, height: 1.0),
            bodySmall: GoogleFonts.roboto(
                fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
            labelSmall: GoogleFonts.roboto(
                fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
          ),
        ),
        home: const MyHomePage());
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
          title: Text(
            'iTunes Search',
            style: Get.theme.textTheme.titleLarge,
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
                  padding:
                      const EdgeInsets.only(left: 32.0, right: 32.0, top: 16.0),
                  child: searchbar.SearchBar(
                      searchController: searchController,
                      focusNode: _focusNode,
                      songController: songController),
                ),
                Expanded(
                  child: Obx(() {
                    if (songController.isLoading.value) {
                      return const Center(
                          child: CircularProgressIndicator(
                        color: Colors.grey,
                      ));
                    } else if (songController.isInit.isTrue) {
                      return const Column();
                    } else {
                      if (songController.songList.isEmpty) {
                        return Center(child: Text('no song'.tr, style: Get.theme.textTheme.bodyLarge));
                      }
                      List<Widget> widgets = songController.songList
                          .map((song) => SongCard(
                                songController: songController,
                                song: song,
                              ))
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
