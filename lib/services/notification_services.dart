import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'local_notification.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future _handleIosNotificationPermission() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

  Future initFirebasePushNotification(context) async {
    await _handleIosNotificationPermission();
    // await FirebaseAuth.instance.signInAnonymously();

    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     Routes.notificationScreenRoute, (route) => false);
    }

    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) async =>
          LocalNotificationService.display(message),
    );

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      print(message.notification?.title);
      print(message.notification?.body);
      // Navigator.of(context).pushNamedAndRemoveUntil(
      //     Routes.notificationScreenRoute, (route) => false);
    });
  }

  Future<bool?> checkingPermission() async {
    bool? accepted;
    await _fcm
        .getNotificationSettings()
        .then((NotificationSettings settings) async {
      if (settings.authorizationStatus == AuthorizationStatus.authorized ||
          settings.authorizationStatus == AuthorizationStatus.provisional) {
        accepted = true;
      } else {
        accepted = false;
      }
    });
    return accepted;
  }
}
