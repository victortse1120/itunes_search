import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/songController.dart';
import 'models/song.dart';

void main() {
  runApp(const GetMaterialApp(
      home: MyHomePage(
    title: 'iTunes Search',
  )));
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final SongController songController = Get.put(SongController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.only(top: AppBar().preferredSize.height),
      child: SizedBox(
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'iTunesSearch',
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextFormField(
                        controller: searchController,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {
                          if (searchController.text.isNotEmpty) {
                            songController.fetchSongs(searchController.text);
                          }
                        })
                  ],
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(() {
                          if (songController.isLoading.value) {
                            return const Center(child: CircularProgressIndicator());
                          } else {
                            List<Song> songs =
                                (songController.responseJson.value['results'] as List)
                                    .map((itemJson) => Song.fromJson(itemJson))
                                    .toList();
                            if (songs.length==0) return Center(child: const Text('no song found.'));
                            List<Widget> widgets = songs.map((song) => Text(song.trackName??'')).toList();
                            return Column(children: widgets);
                          }
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
