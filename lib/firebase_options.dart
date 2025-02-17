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
    apiKey: 'AIzaSyCpC_KuLx_9ZgKb9AWihFZAvdey1OkltTE',
    appId: '1:61267002193:web:69aef5f9682d94f4b44970',
    messagingSenderId: '61267002193',
    projectId: 'socialapp-faa9a',
    authDomain: 'socialapp-faa9a.firebaseapp.com',
    storageBucket: 'socialapp-faa9a.firebasestorage.app',
    measurementId: 'G-KWH4QTJSG6',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyATsRxKfzOCBTCN-EKNfPSioxKyN6bruL0',
    appId: '1:61267002193:android:0ee6f5ae7e6a4fb3b44970',
    messagingSenderId: '61267002193',
    projectId: 'socialapp-faa9a',
    storageBucket: 'socialapp-faa9a.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBiQB4AW8D9ZQPi_-eb3gRHL_Wo_xWjZgM',
    appId: '1:61267002193:ios:c8cec043f38f4001b44970',
    messagingSenderId: '61267002193',
    projectId: 'socialapp-faa9a',
    storageBucket: 'socialapp-faa9a.firebasestorage.app',
    iosBundleId: 'com.example.untitled',
  );
}
