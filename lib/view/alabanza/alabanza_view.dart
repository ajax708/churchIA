//Dart
import 'package:flutter/material.dart';

//Widgets reutilizables
import 'package:relevans_app/view/widgets/custom_navigationbar.dart';

//Instancias
import 'package:relevans_app/bussiness/alabanza_links.dart';

//widgets
import 'widgets/appbar_alabanza_widget.dart';
import 'widgets/first_clip_path_widget.dart';
import 'widgets/second_clip_path_widget.dart';
import 'widgets/search_widget.dart';
import 'widgets/listview_playlist_widget.dart';
import 'widgets/listview_music_widget.dart';
import 'widgets/more_button_widget.dart';

class AlabanzaView extends StatefulWidget {
  const AlabanzaView({super.key});

  @override
  State<AlabanzaView> createState() => _AlabanzaViewState();
}

class _AlabanzaViewState extends State<AlabanzaView> {
  int currentPage = 2;
  AlabanzaLink alabanzaLink = AlabanzaLink();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarAlabanza(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 1300,
            ),
            const FirstClipPath(), //first_clip_path_widget
            const Center(
              child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: Text(
                    'Alabanzas',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 100, left: 40, right: 40),
                child: SizedBox(
                  height: 40,
                  child: Search(), //search_widget
                ),
              ),
            ),
            const Padding(
                padding: EdgeInsets.only(top: 160, left: 15),
                child: SizedBox(
                    height: 200,
                    child: ListViewPlayList() //listview_playlist_widget <---------
                    )),
            const Positioned(
              top: 380,
              child: SecondClipPath(), //second_clip_path_widget
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 435),
                child: Column(
                  children: [
                    Text(
                      'Recientes',
                      style: TextStyle(color: Colors.black, fontSize: 35),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 120, right: 80),
                      child: Text(
                        'Lista de canciones que se reproducirán en el servicio',
                        style: TextStyle(color: Colors.black, fontSize: 14),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Text(
                        'Lista de canciones',
                        style: TextStyle(
                            color: Color.fromARGB(255, 203, 149, 0),
                            fontSize: 13),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 580),
              child: SizedBox(
                height: 505,
                child: ListViewMusic(), //listview_music_widget
              ),
            ),
            const Positioned(
                top: 1100,
                height: 110,
                width: 410,
                child: Padding(
                  padding: EdgeInsets.only(left: 12, right: 10),
                  child: MoreButton(), //more_button_widget
                ))
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentPage: currentPage),
    );
  }
}
