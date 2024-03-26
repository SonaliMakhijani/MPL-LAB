// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyD3HtMIiW5YxZsH18glRKJhpCNaN1j8QQk',
    appId: '1:434033430428:web:25f843c3a36674c0694259',
    messagingSenderId: '434033430428',
    projectId: 'expensio-a9d0e',
    authDomain: 'expensio-a9d0e.firebaseapp.com',
    storageBucket: 'expensio-a9d0e.appspot.com',
    measurementId: 'G-T2QM4TQET9',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBadlw3Pfca4nq0t-0jpO4dmQ2ZdIrA_WM',
    appId: '1:434033430428:android:0d4dc4a8c0e6a266694259',
    messagingSenderId: '434033430428',
    projectId: 'expensio-a9d0e',
    storageBucket: 'expensio-a9d0e.appspot.com',
  );
}