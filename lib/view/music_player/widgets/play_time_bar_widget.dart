import 'package:flutter/material.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:relevans_app/model/music.dart';
import 'package:audioplayers/audioplayers.dart';

class PlayTimeBar extends StatelessWidget {
  const PlayTimeBar({
    super.key,
    required this.player,
    required this.music,
  });

  final AudioPlayer player;
  final Music music;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: player.onPositionChanged,
        builder: (context, data) {
          return ProgressBar(
            progress: data.data ?? const Duration(seconds: 0),
            total: music.duration ?? const Duration(minutes: 4),
            bufferedBarColor: Colors.white38,
            baseBarColor: Colors.white10,
            thumbColor: Colors.white,
            timeLabelTextStyle: const TextStyle(color: Colors.white),
            progressBarColor: Colors.white,
            onSeek: (duration) {
              player.seek(duration);
            },
          );
        });
  }
}
