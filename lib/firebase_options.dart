import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) return web;
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.windows:
        return windows;
      default:
        throw UnsupportedError('Platform không được hỗ trợ');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDlsRqf4Nr_1RioiiXtQ_v7HR5FI1PeSSY',
    appId: '1:242871488197:web:c44f13e799b9110793aaac',
    messagingSenderId: '242871488197',
    projectId: 'coffe-b2f92',
    authDomain: 'coffe-b2f92.firebaseapp.com',
    storageBucket: 'coffe-b2f92.firebasestorage.app',
    measurementId: 'G-04J82PXKZS',
  );

  // Dùng chung Web config cho Windows desktop
  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDlsRqf4Nr_1RioiiXtQ_v7HR5FI1PeSSY',
    appId: '1:242871488197:web:c44f13e799b9110793aaac',
    messagingSenderId: '242871488197',
    projectId: 'coffe-b2f92',
    authDomain: 'coffe-b2f92.firebaseapp.com',
    storageBucket: 'coffe-b2f92.firebasestorage.app',
    measurementId: 'G-04J82PXKZS',
  );

  // Nếu bạn có Android app, thay bằng giá trị từ google-services.json
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlsRqf4Nr_1RioiiXtQ_v7HR5FI1PeSSY',
    appId: '1:242871488197:web:c44f13e799b9110793aaac',
    messagingSenderId: '242871488197',
    projectId: 'coffe-b2f92',
    storageBucket: 'coffe-b2f92.firebasestorage.app',
  );

  // Nếu bạn có iOS app, thay bằng giá trị từ GoogleService-Info.plist
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDlsRqf4Nr_1RioiiXtQ_v7HR5FI1PeSSY',
    appId: '1:242871488197:web:c44f13e799b9110793aaac',
    messagingSenderId: '242871488197',
    projectId: 'coffe-b2f92',
    storageBucket: 'coffe-b2f92.firebasestorage.app',
    iosBundleId: 'com.example.coffee',
  );
}