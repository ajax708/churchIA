import 'package:flutter/material.dart';

class PlaylistLink {
  void playerMusicPage(BuildContext context) {
    Navigator.of(context)
        .pushNamed("/music_player");
  }

  void alabanzaPage(BuildContext context) {
    Navigator.of(context)
        .pushNamed("/alabanza");
  }
}
