import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:solikat_2024/view/app/app_view.dart';

import 'database/app_preferences.dart';

// Initialize FlutterLocalNotificationsPlugin
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyDw5SH6yvHgoNhezjf4WcutgyILIPd7kzc",
      appId: "1:921695559318:android:97d1fdfdd8893728946cb7",
      messagingSenderId: "921695559318",
      projectId: "soliket-df75a",
    ),
  );

  // Request notification permission
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission();
  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print("User granted notification permission.");
  }

  // Initialize local notifications
  var androidInitialize =
      const AndroidInitializationSettings('@mipmap/ic_launcher');
  // var iosInitialize = const IOSInitializationSettings();
  var initSettings = InitializationSettings(
    android: androidInitialize,
    // iOS: iosInitialize,
  );
  await flutterLocalNotificationsPlugin.initialize(initSettings);

  // Handle notifications when app is in the foreground
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Notification received: ${message.notification?.title}");

    // Show notification
    var androidDetails = const AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    var notificationDetails = NotificationDetails(android: androidDetails);
    flutterLocalNotificationsPlugin.show(
      0,
      message.notification?.title,
      message.notification?.body,
      notificationDetails,
    );
  });

  // Handle background notifications
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Handle notification when app is launched from a notification click
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print("Notification tapped: ${message.notification?.title}");
    // Navigate to specific screen based on notification data
    // Example: Navigator.pushNamed(context, '/someScreen');
  });

  // Handle notification when app is fully terminated
  FirebaseMessaging messagingInstance = FirebaseMessaging.instance;
  messagingInstance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      print(
          "App opened from terminated state by notification: ${message.notification?.title}");
      // You can perform navigation here if needed
    }
  });

  // Set preferred orientations and other app settings
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await AppPreferences.initPref();
  await Future.delayed(const Duration(milliseconds: 300));
  runApp(App());
}

// Background message handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  // Perform tasks here such as navigation or background updates
}

// Handle notification selection (when the user taps the notification)
Future<void> onSelectNotification(String? payload) async {
  // Handle navigation or specific action on notification tap
  print("Notification tapped with payload: $payload");
  // You can navigate to a specific screen if required
  // Example: Navigator.pushNamed(context, '/someScreen');
}
