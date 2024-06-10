import 'package:flutter/material.dart';
import 'package:relevans_app/model/music.dart';
import 'package:relevans_app/view/widgets/art_work_image.dart';

class MusicImage extends StatelessWidget {
  const MusicImage({
    super.key,
    required this.music,
  });

  final Music music;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 210,
        width: 200,
        child: Card(
          color: Colors.white,
          child: Card(
              clipBehavior: Clip.hardEdge,
              child: ArtWorkImage(image: music.songImage)),
        ),
      ),
    );
  }
}
