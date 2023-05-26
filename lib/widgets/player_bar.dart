import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/songController.dart';

class PlayerBar extends StatefulWidget {
  const PlayerBar({
    super.key,
    required this.songController,
  });

  final SongController songController;

  @override
  State<PlayerBar> createState() => _PlayerBarState();
}

class _PlayerBarState extends State<PlayerBar>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    widget.songController.initAnimationController(this);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return ListTile(
        tileColor: Colors.grey.withOpacity(0.2),
        leading: RotationTransition(
          turns: Tween(begin: 0.0, end: 1.0)
              .animate(widget.songController.animationController),
          child: Container(
            width: 40.0,
            height: 40.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2.0),
            ),
            child: widget.songController.songPlaying.value.artworkUrl100 != null
                ? ClipOval(
                    child: Image.network(
                      widget.songController.songPlaying.value.artworkUrl100!,
                      fit: BoxFit.cover,
                    ),
                  )
                : const Icon(Icons.music_note),
          ),
        ),
        title: Text(
          widget.songController.songPlaying.value.trackName ?? '',
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
                onPressed: () =>
                    widget.songController.songPlaying.value.trackId != null
                        ? widget.songController.prevSong()
                        : null,
              ),
              IconButton(
                icon: Icon(widget.songController.isPlaying.value
                    ? Icons.pause
                    : Icons.play_arrow),
                splashColor: Colors.transparent,
                color: Colors.black,
                onPressed: () async {
                  if (widget.songController.songPlaying.value.trackId != null) {
                    widget.songController
                        .playSong(widget.songController.songPlaying.value);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.skip_next),
                color: Colors.black,
                onPressed: () =>
                    widget.songController.songPlaying.value.trackId != null
                        ? widget.songController.nextSong()
                        : null,
              )
            ],
          ),
        ),
      );
    });
  }
}
