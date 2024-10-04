// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:taylor_made_2023/utils/common_utils.dart';
//
// import '../database/app_preferences.dart';
//
// Future<void> handleBackgroundMessage(RemoteMessage message) async {
//   log('(handleBackground) Title: ${message.notification?.title}');
//   log('(handleBackground) Body: ${message.notification?.body}');
//   log('(handleBackground) Payload: ${message.data}');
// }
//
// class NotificationService {
//   final _firebaseMessaging = FirebaseMessaging.instance;
//   final _localNotificationsPlugin = FlutterLocalNotificationsPlugin();
//
//   Future<void> initService() async {
//     _firebaseMessaging.requestPermission();
//     final fCMToken = await _firebaseMessaging.getToken();
//     log('FCM Token :: $fCMToken');
//     if (fCMToken != null) {
//       AppPreferences.instance.setFCMToken(fCMToken);
//     }
//     initPushNotifications();
//     initLocalNotification();
//   }
//
//   Future initPushNotifications() async {
//     await FirebaseMessaging.instance
//         .setForegroundNotificationPresentationOptions(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//     FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
//     FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
//     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
//     FirebaseMessaging.onMessage.listen(handleListenMessage);
//   }
//
//   Future initLocalNotification() async {
//     const android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     const ios = DarwinInitializationSettings();
//     const setting = InitializationSettings(android: android, iOS: ios);
//     await _localNotificationsPlugin.initialize(setting,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notificationResponse) {
//       if (notificationResponse.payload != null) {
//         Map<String, dynamic> payloadMap =
//             jsonDecode(notificationResponse.payload!)['data'];
//         redirectNotificationScreen(payload: payloadMap);
//       }
//     });
//   }
//
//   void handleMessage(RemoteMessage? message) {
//     log('(handleMessage) Title :: ${message?.notification?.title}');
//     log('(handleMessage) Body :: ${message?.notification?.body}');
//     log('(handleMessage) Payload :: ${message?.data}');
//     if (message == null) return;
//     redirectNotificationScreen(payload: message.data);
//   }
//
//   void handleListenMessage(RemoteMessage? message) {
//     print(message!.data);
//     if (message == null) return;
//     final notification = message.notification;
//     if (notification == null) return;
//     _localNotificationsPlugin.show(
//       notification.hashCode,
//       notification.title,
//       notification.body,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           "high_importance_channel",
//           "High Importance Notifications",
//           channelDescription:
//               "This channel is used for important notifications.",
//           importance: Importance.high,
//           icon: '@mipmap/ic_launcher',
//         ),
//         iOS: DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       ),
//       payload: jsonEncode(message.toMap()),
//     );
//   }
// }
