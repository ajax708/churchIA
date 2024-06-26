// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA_8eMeuvGQUUELwCokfioIbMfNKprrm3M',
    appId: '1:967970994529:web:d0471ddd407d134fbead20',
    messagingSenderId: '967970994529',
    projectId: 'relevans2-bb0f6',
    authDomain: 'relevans2-bb0f6.firebaseapp.com',
    storageBucket: 'relevans2-bb0f6.appspot.com',
    measurementId: 'G-04LLJ70M9H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCHRVNymQjCJqSyrKvi2P7F5J26xScJlP0',
    appId: '1:967970994529:android:bc0b9607bf1bf417bead20',
    messagingSenderId: '967970994529',
    projectId: 'relevans2-bb0f6',
    storageBucket: 'relevans2-bb0f6.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAq_Pwc48gTcK9e4UY1gQRIxQuEiTEhw0o',
    appId: '1:967970994529:ios:c42b66b5b69695b6bead20',
    messagingSenderId: '967970994529',
    projectId: 'relevans2-bb0f6',
    storageBucket: 'relevans2-bb0f6.appspot.com',
    iosBundleId: 'com.example.relevansApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAq_Pwc48gTcK9e4UY1gQRIxQuEiTEhw0o',
    appId: '1:967970994529:ios:c42b66b5b69695b6bead20',
    messagingSenderId: '967970994529',
    projectId: 'relevans2-bb0f6',
    storageBucket: 'relevans2-bb0f6.appspot.com',
    iosBundleId: 'com.example.relevansApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyA_8eMeuvGQUUELwCokfioIbMfNKprrm3M',
    appId: '1:967970994529:web:938b618a5a5e327abead20',
    messagingSenderId: '967970994529',
    projectId: 'relevans2-bb0f6',
    authDomain: 'relevans2-bb0f6.firebaseapp.com',
    storageBucket: 'relevans2-bb0f6.appspot.com',
    measurementId: 'G-NX6G2YQMYH',
  );
}
