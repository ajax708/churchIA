import 'package:flutter/material.dart';
import './music_button_widget.dart';

class ListViewMusic extends StatefulWidget {
  const ListViewMusic(String? playlistId, {Key? key}) : super(key: key);

  @override
  _ListViewMusicState createState() => _ListViewMusicState();
}

class _ListViewMusicState extends State<ListViewMusic> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, int index) => const SizedBox(
        height: 100,
        child: Card(
          elevation: 5,
          child: MusicButton(),
        ),
      ),
    );
  }


}