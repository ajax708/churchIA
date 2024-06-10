
import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:relevans_app/utils/shared_pref.dart';

import 'ConstanstAplication.dart';

class FirebaseNotificationPush{
  late FirebaseMessaging _firebaseMessaging ;
  final _messagesStreamController = StreamController<String>.broadcast();
  late final Stream<String> messages = _messagesStreamController.stream;


  initNotifications() {
    _firebaseMessaging = FirebaseMessaging.instance;
    _firebaseMessaging.requestPermission();

    _firebaseMessaging.getToken().then((token) {
       print('===== FCM Token =====');
       print(token);
      if (token!.length > 0)
      {
        SharedPref.setString(ConstanstAplication.TOKEN, token!);
        _firebaseMessaging.subscribeToTopic("all");
      }
    });


    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      if (event.notification != null) {
        print('Mensaje mientras esta en primer plano: ${event.notification}');
        print('Body: ${event.notification!.body}');
        _messagesStreamController.sink.add(event.notification!.body!);
      }
      if (event.data != null) {
        print('Message also contained data: ${event.data}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');

      if (message.data != null) {
        print('Mensaje mientras esta en segundo plano: ${message.data}');
        _messagesStreamController.sink.add(message.data.toString());
      }
    });
  }
}