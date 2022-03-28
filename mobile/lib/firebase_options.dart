// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
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
    // ignore: missing_enum_constant_in_switch
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
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAjFg8Zu9WeQPRwsxcpJIpdZfyq9WPmUTU',
    appId: '1:302449687825:web:856005b37fbcfca7cd20b0',
    messagingSenderId: '302449687825',
    projectId: 'teamapp-92962',
    authDomain: 'teamapp-92962.firebaseapp.com',
    storageBucket: 'teamapp-92962.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCfksSz-lzqoCX99HQrAtXIfWU7ghVngQI',
    appId: '1:302449687825:android:27aaf9c7b379006acd20b0',
    messagingSenderId: '302449687825',
    projectId: 'teamapp-92962',
    storageBucket: 'teamapp-92962.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCl2Kvsj5gKp7IDXAD-MgtwLSxbQiaE7Xg',
    appId: '1:302449687825:ios:897e4fa9353ffc73cd20b0',
    messagingSenderId: '302449687825',
    projectId: 'teamapp-92962',
    storageBucket: 'teamapp-92962.appspot.com',
    iosClientId: '302449687825-77f8fk83lae5k46hin89shpgejdhfis6.apps.googleusercontent.com',
    iosBundleId: 'com.dkatalis.teamapp',
  );
}