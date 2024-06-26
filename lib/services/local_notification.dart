import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification,
      ),
    );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {}

  static void display(RemoteMessage message) async {
    try {
      Random random = Random();
      int id = random.nextInt(10000);
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
        playSound: true,
        'main_channel',
        'Main channel notifications',
        importance: Importance.max,
        priority: Priority.high,
      ));

      await _flutterLocalNotificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
      );
    } on Exception catch (e) {
      debugPrint('$e');
    }
  }
}
