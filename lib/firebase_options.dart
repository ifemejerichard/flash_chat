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
    apiKey: 'AIzaSyAc0VXN1UZptf1scUwCF26u-ilDcEXGp6w',
    appId: '1:973612146242:web:cd72f6927a1c96881c57db',
    messagingSenderId: '973612146242',
    projectId: 'flash-chat-68748',
    authDomain: 'flash-chat-68748.firebaseapp.com',
    storageBucket: 'flash-chat-68748.appspot.com',
    measurementId: 'G-VK2HLKM3Q2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB32cgZsyV4vb_otjYDUgvn7FKKXuFAdIU',
    appId: '1:973612146242:android:912358a8e8a717481c57db',
    messagingSenderId: '973612146242',
    projectId: 'flash-chat-68748',
    storageBucket: 'flash-chat-68748.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAXq-Xn4_exSalAvG7yzIA10rHJrky5kbA',
    appId: '1:973612146242:ios:0e35aebbb96f93271c57db',
    messagingSenderId: '973612146242',
    projectId: 'flash-chat-68748',
    storageBucket: 'flash-chat-68748.appspot.com',
    iosBundleId: 'com.example.flashChat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAXq-Xn4_exSalAvG7yzIA10rHJrky5kbA',
    appId: '1:973612146242:ios:3ab40e007efde41d1c57db',
    messagingSenderId: '973612146242',
    projectId: 'flash-chat-68748',
    storageBucket: 'flash-chat-68748.appspot.com',
    iosBundleId: 'com.example.flashChat.RunnerTests',
  );
}
