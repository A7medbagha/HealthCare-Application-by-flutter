
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPZSpa0uZl2ASKg2VGbYpbZiNVdc6c5rA',
    appId: '1:101537051407:android:3f51e2c1eee30d023e447a',
    messagingSenderId: '101537051407',
    projectId: 'syaah-hospital',
    storageBucket: 'syaah-hospital.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC1nWUeDwZObKIjAD6dqor0gdK17ESg_u0',
    appId: '1:101537051407:ios:52a7bd30a1b0c06d3e447a',
    messagingSenderId: '101537051407',
    projectId: 'syaah-hospital',
    storageBucket: 'syaah-hospital.appspot.com',
    iosBundleId: 'com.example.syaahhospitalsystem',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC1nWUeDwZObKIjAD6dqor0gdK17ESg_u0',
    appId: '1:101537051407:ios:b04012f17a8b0b923e447a',
    messagingSenderId: '101537051407',
    projectId: 'syaah-hospital',
    storageBucket: 'syaah-hospital.appspot.com',
    iosBundleId: 'com.example.syaahhospitalsystem.RunnerTests',
  );
}
