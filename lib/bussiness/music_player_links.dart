import 'package:flutter/material.dart';

class MusicPlayerLink {
  void lyricPage(BuildContext context) {
   Navigator.of(context).pushNamed("/user_register");
  }

  void alabanzaPage(BuildContext context) {
    Navigator.of(context).pushNamed("/alabanza");
  }
}
