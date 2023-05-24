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
          height: (Get.height - AppBar().preferredSize.height) * 0.95,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
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
                const SizedBox(height: 8.0),
                Expanded(
                  child: Obx(() {
                    if (songController.isLoading.value) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      List<Song> songs =
                          (songController.responseJson.value['results'] as List)
                              .map((itemJson) => Song.fromJson(itemJson))
                              .toList();
                      if (songs.isEmpty) {
                        return const Center(
                            child: Text('Sorry, no song found.'));
                      }
                      List<Widget> widgets = songs
                          .map((song) => GestureDetector(
                        onTap: () {
                          songController.isPlaying.value ? songController.pauseSong()
                           : songController.playSong(song.previewUrl!);
                        },
                            child: Card(
                                elevation: 2,
                                color: Colors.white,
                                margin: const EdgeInsets.all(8.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(3),
                                ),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(20.0, 25.0, 20.0, 25.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(5.0),
                                        child: SizedBox(
                                          width: 80,
                                          height: 80,
                                          child: song.artworkUrl100 != null
                                              ? Image.network(
                                            song.artworkUrl100!,
                                            fit: BoxFit.cover,
                                            errorBuilder: (_, __, ___) => Image.asset(
                                              'assets/no_artwork_available.png',
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                              : Image.asset(
                                            'assets/no_artwork_available.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              song.trackName ?? 'Unknown Track',
                                              style: Theme.of(context).textTheme.subtitle1,
                                              textScaleFactor: 1.1,
                                            ),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(song.artistName ?? 'Unknown Artist',
                                                style: Theme.of(context).textTheme.bodyText2),
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Text(song.collectionName ?? 'Unknown Album',
                                                style: Theme.of(context).textTheme.caption),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(width: 20.0),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 20.0),
                                          child: Icon(
                                            songController.isPlaying.value ? Icons.play_arrow : Icons.pause,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                )),
                          ))
                          .toList();
                      return SingleChildScrollView(
                          child: Column(children: widgets));
                    }
                  }),
                ),
              ],
            ),
          )),
    ));
  }
}
