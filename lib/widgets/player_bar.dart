import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/songController.dart';

class PlayerBar extends StatelessWidget {
  const PlayerBar({
    super.key,
    required this.songController,
  });

  final SongController songController;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListTile(
        tileColor: Colors.grey.withOpacity(0.2),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(5.0),
          child: SizedBox(
            width: 40,
            height: 40,
            child:
            songController.songPlaying.value.artworkUrl100 !=
                null
                ? Image.network(
              songController
                  .songPlaying.value.artworkUrl100!,
              fit: BoxFit.cover,
            )
                : const Icon(Icons.music_note),
          ),
        ),
        title: Text(
          songController.songPlaying.value.trackName ?? '',
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
                onPressed: () => songController.songPlaying.value.trackId != null ? songController.prevSong() : null,
              ),
              IconButton(
                icon: Icon(songController.isPlaying.value
                    ? Icons.pause
                    : Icons.play_arrow),
                splashColor: Colors.transparent,
                color: Colors.black,
                onPressed: () async => songController.songPlaying.value.trackId != null ? songController
                    .playSong(songController.songPlaying.value) : null,
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                color: Colors.black,
                onPressed: () => songController.songPlaying.value.trackId != null ? songController.nextSong() : null,
              )
            ],
          ),
        ),
      );
    });
  }
}