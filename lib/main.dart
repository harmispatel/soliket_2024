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
      apiKey: "AIzaSyDw5SH6yvHgoNhezjf4WcutgyILIPd7kzc",
      appId: "1:921695559318:android:97d1fdfdd8893728946cb7",
      messagingSenderId: "921695559318",
      projectId: "soliket-df75a",
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
