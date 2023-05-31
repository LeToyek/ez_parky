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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBOOTyhrWT_JsSr1YX5M_kb7VCrMZivGEU',
    appId: '1:705319478880:android:71eef0698e18dfd2bb0505',
    messagingSenderId: '705319478880',
    projectId: 'ez-parky',
    storageBucket: 'ez-parky.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB1MMCQ1ihW_cbxk0SeONFS2lPvsWrPZlo',
    appId: '1:705319478880:ios:f29b5de4cbddb385bb0505',
    messagingSenderId: '705319478880',
    projectId: 'ez-parky',
    storageBucket: 'ez-parky.appspot.com',
    androidClientId: '705319478880-u2jg43te52ciinv6sd5q0ejpaovjc1dl.apps.googleusercontent.com',
    iosClientId: '705319478880-u6u0up24m4smtvf7q6hd03i96ppifen5.apps.googleusercontent.com',
    iosBundleId: 'com.example.ezParky',
  );
}
