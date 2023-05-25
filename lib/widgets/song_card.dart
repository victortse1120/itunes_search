import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/songController.dart';

class SongCard extends StatelessWidget {
  const SongCard({
    super.key,
    required this.songController,
    required this.song
  });

  final SongController songController;
  final dynamic song;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return GestureDetector(
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
                    borderRadius:
                    BorderRadius.circular(5.0),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child:
                      song.artworkUrl100 != null
                          ? Image.network(
                        song.artworkUrl100!,
                        fit: BoxFit.cover,
                        errorBuilder: (_,
                            __, ___) =>
                        const Icon(Icons
                            .music_note),
                      )
                          : const Icon(
                          Icons.music_note),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(
                        vertical: 15.0),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
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
                        Text(
                            song.artistName ??
                                'Unknown Artist',
                            style: Theme
                                .of(context)
                                .textTheme
                                .bodyText2),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                            song.collectionName ??
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
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20.0),
                      child: Icon(
                        songController.songPlaying
                            .value.trackId ==
                            song.trackId
                            ? (songController
                            .isPlaying.value
                            ? Icons.pause
                            : Icons.play_arrow)
                            : Icons.play_arrow,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ],
            )),
      );
    });
  }
}