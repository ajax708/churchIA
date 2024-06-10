import 'package:flutter/material.dart';
import 'package:relevans_app/model/response/trackDto.dart';

class AlabanzaLink {
  void playerMusicPage(BuildContext context, TrackDto trackDto) {
    Navigator.of(context)
        .pushNamed("/music_player", arguments: trackDto);
  }

  void homePage(BuildContext context) {
    Navigator.of(context).pushNamed("/");
  }

  void alabanzaPage(BuildContext context){
    Navigator.of(context)
        .pushNamed("/alabanza");
  }

  void playlistPage(BuildContext context, String id){
    Navigator.of(context)
        .pushNamed("/playlist" , arguments: id);
  }
}
