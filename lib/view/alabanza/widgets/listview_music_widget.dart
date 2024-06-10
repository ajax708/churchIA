import 'package:flutter/material.dart';
import './music_button_widget.dart';

class ListViewMusic extends StatelessWidget {
  const ListViewMusic({super.key});

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
            ));
  }
}
