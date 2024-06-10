import 'package:flutter/material.dart';
import 'package:relevans_app/bussiness/alabanza_links.dart';
import 'package:relevans_app/model/response/trackDto.dart';

class MusicButton extends StatelessWidget {
  const MusicButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        TrackDto trackDto = TrackDto(idTrack: "test", index: 1);

        AlabanzaLink alabanzaLink = AlabanzaLink();
        alabanzaLink.playerMusicPage(context, trackDto);
      },
      child: const Row(
        children: [
          SizedBox(
            height: 90,
            width: 100,
            child: Card(
              color: Color.fromARGB(255, 167, 166, 166),
              child: Icon(
                Icons.play_arrow,
                size: 60,
                color: Color.fromARGB(255, 78, 78, 78),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 10, left: 10),
                child: Text(
                  'ERROR 403',
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 5, left: 10),
                child: Text('Lu de la Tower, Corona',
                    style: TextStyle(
                        color: Color.fromARGB(255, 64, 64, 64), fontSize: 15)),
              )
            ],
          ),
        ],
      ),
    );
  }
}
