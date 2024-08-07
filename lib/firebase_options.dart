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
    apiKey: 'AIzaSyDqf5XAyMmVW5DVK_Cs9B3tTDz7nme48-Q',
    appId: '1:487453644062:web:dc6b68356c2a9751fae50f',
    messagingSenderId: '487453644062',
    projectId: 'general-app-5c35a',
    authDomain: 'general-app-5c35a.firebaseapp.com',
    storageBucket: 'general-app-5c35a.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCVQ6jqeM8t6Oo_ajMZmEob0CyEqkx4rZY',
    appId: '1:487453644062:android:748d3a2463374d9efae50f',
    messagingSenderId: '487453644062',
    projectId: 'general-app-5c35a',
    storageBucket: 'general-app-5c35a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB9u34ixidxjDSiQeBsW5JI373D47pGRHk',
    appId: '1:487453644062:ios:4b528b3ac3ee1f4efae50f',
    messagingSenderId: '487453644062',
    projectId: 'general-app-5c35a',
    storageBucket: 'general-app-5c35a.appspot.com',
    iosBundleId: 'com.aponwola.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB9u34ixidxjDSiQeBsW5JI373D47pGRHk',
    appId: '1:487453644062:ios:4b528b3ac3ee1f4efae50f',
    messagingSenderId: '487453644062',
    projectId: 'general-app-5c35a',
    storageBucket: 'general-app-5c35a.appspot.com',
    iosBundleId: 'com.aponwola.app',
  );
}
