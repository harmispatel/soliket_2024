import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:solikat_2024/view/app/app_view.dart';

import 'database/app_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBrFgGr8-QaZhUrWQF3lIny7FgrZblWGMk",
      appId: "1:919834426763:android:053c5935e55e2dfa67438e",
      messagingSenderId: "919834426763",
      projectId: "activeecommerce-8ec99",
    ),
  );
  Provider.debugCheckInvalidValueType = null;

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await AppPreferences.initPref();
  await Future.delayed(const Duration(milliseconds: 300));
  runApp(App());
}
// check update
