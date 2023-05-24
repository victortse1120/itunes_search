import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/songController.dart';

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
              height: (Get.height - AppBar().preferredSize.height),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'iTunesSearch',
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32.0),
                    child: Row(
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
                                songController.fetchSongs(searchController
                                    .text);
                              }
                            })
                      ],
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Expanded(
                    child: Obx(() {
                      if (songController.isLoading.value) {
                        return const Center(
                            child: CircularProgressIndicator());
                      } else if (songController.isInit.isTrue) {
                        return Column();
                      } else {
                        if (songController.songList.isEmpty) {
                          return const Center(
                              child: Text('Sorry, no song found.'));
                        }
                        List<Widget> widgets = songController.songList
                            .map((song) =>
                            GestureDetector(
                              onTap: () {
                                songController.playSong(song);
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
                                        padding: const EdgeInsets.fromLTRB(
                                            20.0, 25.0, 20.0, 25.0),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                              5.0),
                                          child: SizedBox(
                                            width: 80,
                                            height: 80,
                                            child: song.artworkUrl100 != null
                                                ? Image.network(
                                              song.artworkUrl100!,
                                              fit: BoxFit.cover,
                                              errorBuilder: (_, __, ___) =>
                                                  const Icon(Icons.music_note),
                                            )
                                                : const Icon(Icons.music_note),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 15.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: [
                                              Text(
                                                song.trackName ??
                                                    'Unknown Track',
                                                style: Theme
                                                    .of(context)
                                                    .textTheme
                                                    .subtitle1,
                                                textScaleFactor: 1.1,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(song.artistName ??
                                                  'Unknown Artist',
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .bodyText2),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(song.collectionName ??
                                                  'Unknown Album',
                                                  style: Theme
                                                      .of(context)
                                                      .textTheme
                                                      .caption),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment
                                            .spaceBetween,
                                        children: [
                                          const SizedBox(width: 20.0),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20.0),
                                            child: Icon(
                                              songController.songPlaying
                                                  .value.trackId == song.trackId
                                                  ? (songController.isPlaying
                                                  .value ? Icons.pause : Icons
                                                  .play_arrow)
                                                  : Icons.play_arrow,
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
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 32.0),
                              child: Column(children: widgets),
                            ));
                      }
                    }),
                  ),
                  Obx(() {
                    return ListTile(
                      tileColor: Colors.grey.withOpacity(0.2),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5.0),
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: songController.songPlaying.value.artworkUrl100 !=
                              null
                              ? Image.network(
                            songController.songPlaying.value.artworkUrl100!,
                            fit: BoxFit.cover,
                          )
                              : const Icon(Icons.music_note),
                        ),
                      ),
                      title: Text(
                        songController.songPlaying.value.trackName ??
                            '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: SizedBox(
                        width: 160,
                        child: Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.skip_previous),
                              color: Colors.black,
                              onPressed: () => songController.prevSong(),
                            ),
                            IconButton(
                              icon: Icon(songController.isPlaying
                                  .value ? Icons.pause : Icons
                                  .play_arrow),
                              splashColor: Colors.transparent,
                              color: Colors.black,
                              onPressed: () async => songController.playSong(songController.songPlaying.value),
                            ),
                            IconButton(
                              icon: const Icon(Icons.skip_next),
                              color: Colors.black,
                              onPressed: () => songController.nextSong(),
                            )
                          ],
                        ),
                      ),
                    );
                  })
                ],
              )),
        ));
  }
}
