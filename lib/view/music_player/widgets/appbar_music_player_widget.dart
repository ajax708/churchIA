import 'package:flutter/material.dart';
import 'package:relevans_app/bussiness/music_player_links.dart';
import 'package:relevans_app/utils/custom_icons.dart';

class AppbarMusicPlayer extends StatelessWidget implements PreferredSizeWidget {
  const AppbarMusicPlayer({Key? key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Padding(
        padding: EdgeInsets.only(top: 30),
        child: Text(
          'RELEVANS',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      centerTitle: true,
      toolbarHeight: 65,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      elevation: 4,
      shadowColor: const Color.fromARGB(255, 184, 184, 184),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(55),
          bottomLeft: Radius.circular(55),
        ),
      ),
      leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {
                /*MusicPlayerLink musicPlayerLink = MusicPlayerLink();
                musicPlayerLink.alabanzaPage(context);*/
                Navigator.pop(context);
              },
              icon: const Padding(
                  padding: EdgeInsets.only(left: 8),
                  child: Icon(Icons.arrow_back_ios_new)),
              iconSize: 38,
              color: Colors.black)),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 20, right: 20),
          child: IconButton(
              onPressed: () {
                MusicPlayerLink musicPlayerLink = MusicPlayerLink();
                musicPlayerLink.alabanzaPage(context);
              },
              icon: const Icon(CustomIcons.music),
              iconSize: 38,
              color: Colors.black),
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size(double.maxFinite, 70);
}
