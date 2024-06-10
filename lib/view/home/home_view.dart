//Dart
//import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:relevans_app/model/KeyValue.dart';
//import 'package:relevans_app/model/response/RVM2.dart';
//import 'package:relevans_app/model/screen_arguments.dart';
import 'package:relevans_app/utils/ConstanstAplication.dart';
//import 'package:relevans_app/utils/ConstanstService.dart';

//Widgets reutilizables
import 'package:relevans_app/view/widgets/custom_drawer.dart';
import 'package:relevans_app/view/widgets/custom_navigationbar.dart';

//Instancias
import 'package:relevans_app/bussiness/home_links.dart';

import '../../bussiness/home_service.dart';
//import '../../utils/common_widget.dart';

//Widgets
import 'widgets/appbar_home_widget.dart';
import 'widgets/carrousel_message_widget.dart';
import 'widgets/first_clip_path_widget.dart';
import 'widgets/second_clip_path_widget.dart';
import 'widgets/listview_pastor_widget.dart';
import 'widgets/alabanza_button_widget.dart';
import 'widgets/event_button_widget.dart';
import 'widgets/register_button_widget.dart';
import 'widgets/facebook_button_widget.dart';
import 'widgets/instagram_button_widget.dart';
import 'widgets/tiktok_button_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeLink homeLink = HomeLink();

  bool isRoot = true;
  final int _currentPage = 0;
  List<String> _listTitle = [
    'Un lugar para conectar',
    'Una iglesia relevante',
    'Una familia para pertenecer'
  ];
  final List<String> _listDescription = [
    'Experimentar la comunión, lo difícil lo hace Cristo.',
    'Participa en cada ámbito de la sociedad.- Espiritual es lo que haces en lo que haces a diario. Soy hijo de Dios dentro y fuera del templo.',
    'Libertad sin máscaras. Podemos ser genuinos, así como somos. En la familia hay lealtad.'
  ];

  @override
  void initState() {
    //loadDataFromService();
    super.initState();
  }

  Future<void> loadDataFromService() async {
    try {
      await onConsumeMesage(context);
    } catch (e) {
      print(e);
    }
  }

  onConsumeMesage(BuildContext context) async {
    final homeService = HomeService(server: ConstanstAplication.SERVER);
    KeyValue keyValue = await homeService.onProcess();
    this._listTitle = homeService.list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppbarHome(), //appbar_home_widget
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 1470,
            ),
            const FirstClipPath(), //first_clip_path_widget
            CarrouselMessage(
              listTitle: _listTitle,
              listDescription: _listDescription,
            ), //carrousel_message_widget
            Positioned(
                top: 280,
                left: 50,
                child: SizedBox(
                  height: 280,
                  width: 320,
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    elevation: 8,
                    child: Card(
                      clipBehavior: Clip.hardEdge,
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      child: Stack(
                        children: [
                          Opacity(
                            opacity: 0.5,
                            child: Image.asset('assets/capilla.png',
                                fit: BoxFit.contain),
                          ),
                          Positioned(
                              top: 25,
                              left: 20,
                              right: 20,
                              child: SizedBox(
                                height: 90,
                                child: AlabanzaButton(
                                    homeLink:
                                        homeLink), //alabanza_button_widget
                              )),
                          Positioned(
                              top: 145,
                              left: 20,
                              right: 20,
                              child: SizedBox(
                                height: 90,
                                child: EventButton(
                                    homeLink: homeLink), //event_button_widget
                              ))
                        ],
                      ),
                    ),
                  ),
                )),
            const Positioned(
              top: 610,
              left: 140,
              child: Text(
                'Pastores',
                style: TextStyle(fontSize: 31, color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 670, left: 10, right: 10),
              child: SizedBox(
                height: 200,
                child: ListViewPastor(), //listview_pastor_widget
              ),
            ),
            Positioned(
                top: 1115,
                width: 450,
                height: 360,
                child: Container(
                  color: Colors.black,
                )),
             Positioned(
              top: 920,
              width: MediaQuery.of(context).size.width,
              child: const SecondClipPath(), //second_clip_path_widget
            ),
            const Positioned(
              top: 1020,
              child: Padding(
                padding: EdgeInsets.only(left: 30),
                child: Text(
                  'Titulo',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
              ),
            ),
            const Positioned(
              top: 1040,
              child: Padding(
                padding: EdgeInsets.only(top: 30, left: 30),
                child: Text('Descripción',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
            Positioned(
              top: 1115,
              left: 30,
              child: SizedBox(
                width: 215,
                height: 50,
                child:
                    RegisterButton(homeLink: homeLink), //register_button_widget
              ),
            ),
            const Positioned(
                top: 1230,
                width: 450,
                height: 360,
                child: Padding(
                  padding: EdgeInsets.only(left: 110),
                  child: Row(
                    children: [
                      FacebookButton(), //facebook_button_widget
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: InstagramButton(), //instagram_button_widget
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: TikTokButton(), //tiktok_button_widget
                      ),
                    ],
                  ),
                ))
          ],
        ),
      ),
      bottomNavigationBar: CustomNavigationBar(currentPage: _currentPage),
    );
  }
}
