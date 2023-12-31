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
        return ios;
      case TargetPlatform.macOS:
        return macos;
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
    apiKey: 'AIzaSyDTGUCpt_igVuGBO_H4w_WLv2z4Ks4rCEw',
    appId: '1:237804505250:web:f452288c80089905922ffb',
    messagingSenderId: '237804505250',
    projectId: 'noteninja-fa41c',
    authDomain: 'noteninja-fa41c.firebaseapp.com',
    storageBucket: 'noteninja-fa41c.appspot.com',
    measurementId: 'G-EN5T6SQJ24',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBTBV-pqaKJ4uVg_dpk9SWIuoTMi46Tjcg',
    appId: '1:237804505250:android:ff7f571fc2fb15e9922ffb',
    messagingSenderId: '237804505250',
    projectId: 'noteninja-fa41c',
    storageBucket: 'noteninja-fa41c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBaD_49LXD7I-Vpyf4mED9QW9z-X9iyU2M',
    appId: '1:237804505250:ios:500920f355a14563922ffb',
    messagingSenderId: '237804505250',
    projectId: 'noteninja-fa41c',
    storageBucket: 'noteninja-fa41c.appspot.com',
    iosClientId: '237804505250-tu5krucveh1crgldbdknhmv17ntm9fd7.apps.googleusercontent.com',
    iosBundleId: 'com.example.codelab',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBaD_49LXD7I-Vpyf4mED9QW9z-X9iyU2M',
    appId: '1:237804505250:ios:6bac9583c78e3cec922ffb',
    messagingSenderId: '237804505250',
    projectId: 'noteninja-fa41c',
    storageBucket: 'noteninja-fa41c.appspot.com',
    iosClientId: '237804505250-0bh3e546db64jdkvkv38gquqajq0t42m.apps.googleusercontent.com',
    iosBundleId: 'com.example.codelab.RunnerTests',
  );
}
