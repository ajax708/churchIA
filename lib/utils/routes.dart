//Flutter imports
import 'package:flutter/material.dart';
import 'package:relevans_app/utils/FirebaseNotificationPush.dart';
import 'package:relevans_app/utils/shared_pref.dart';

//page imports
import 'package:relevans_app/view/home/home_view.dart';
import 'package:relevans_app/view/more_activities/more_activities_view.dart';
import 'package:relevans_app/view/alabanza/alabanza_view.dart';
import 'package:relevans_app/view/event/event_view.dart';
import 'package:relevans_app/view/music_player/music_player_view.dart';
import 'package:relevans_app/view/playlist/playlist_view.dart';
import 'package:relevans_app/view/register/login_register.dart';
import 'package:relevans_app/view/register/signup.dart';
import 'package:relevans_app/view/register/user_register_view.dart';

import 'ConstanstAplication.dart';
import 'app_util.dart';

class Routes extends StatefulWidget {
  const Routes({Key? key}) : super(key: key);

  @override
  _RoutesState createState() => _RoutesState();
}

class _RoutesState extends State<Routes> {

  final pushProvider = FirebaseNotificationPush();

  @override
  void initState() {
    super.initState();
    pushProvider.initNotifications();
    _init();
    pushProvider.messages.listen((message) {
      print('Mensaje: $message');
    });
  }

  Future<void> _init() async {
    String ip = await getIp();
    SharedPref.setString(ConstanstAplication.SP_IP, ip);
    SharedPref.setString(ConstanstAplication.USER, "Movil");

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChurchIA App',
      initialRoute: "/login",
      routes: {
        "/": (context) => HomeView(),
        "/login": (context) => LoginWidget(),
        "/signup": (context) => SignUpForm(),
        "/user_register": (context) => UserRegisterView(),
        "/more_activities": (context) => MoreActivitiesView(),
        "/alabanza": (context) => AlabanzaView(),
        "/playlist": (context) => PlaylistView(),
        "/event": (context) => EventView(),
        "/music_player": (context) => MusicPlayerView()
      },
    );
  }
}
