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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDduwQzF_jIzyF09fU67ZRPRf4N79wR3Bk',
    appId: '1:926620492815:android:511f33b8604b17ee746f7a',
    messagingSenderId: '926620492815',
    projectId: 'taskmanagement-3ebde',
    storageBucket: 'taskmanagement-3ebde.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCptkrfg1SA385C_y700zkPaifOhgH91QU',
    appId: '1:926620492815:ios:0ce7a99ae8204e9c746f7a',
    messagingSenderId: '926620492815',
    projectId: 'taskmanagement-3ebde',
    storageBucket: 'taskmanagement-3ebde.appspot.com',
    iosClientId: '926620492815-6qrrciitdohnutodujerfeu914mbcs1f.apps.googleusercontent.com',
    iosBundleId: 'com.digiwrecks.cphflyt',
  );
}
