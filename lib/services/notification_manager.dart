import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';

class NotificationManager {
  final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  Future<void> setUp() async {
    NotificationHandler.initNotification();
    await firebaseCloudMessagingListener();

    _messaging.getToken().then((value) {
      Logger().d('token: $value');
    });
  }

  Future firebaseCloudMessagingListener() async {
    await _messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      sound: true,
      provisional: false,
    );

    FirebaseMessaging.onMessage.listen((remoteMessage) {
      showNotification(
        remoteMessage.notification!.title,
        remoteMessage.notification!.body,
      );
    });
  }

  static Future showNotification(String? title, String? body) async {
    const androidChannel = AndroidNotificationDetails(
      'com.example.clustergo',
      'new message',
      autoCancel: true,
      ongoing: true,
      importance: Importance.max,
      priority: Priority.max,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );
    const iOS = DarwinNotificationDetails();

    const platform = NotificationDetails(android: androidChannel, iOS: iOS);
    await NotificationHandler.flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platform,
      payload: 'my payload',
    );
  }
}

class NotificationHandler {
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initNotification() {
    const initAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const initIOS = DarwinInitializationSettings();
    const initSettings = InitializationSettings(
      android: initAndroid,
      iOS: initIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initSettings);
  }
}
