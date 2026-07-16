import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SendNotification {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  static String? tokenForMessages;

  // Local notifications plugin
  static final FlutterLocalNotificationsPlugin _localNotifications =
  FlutterLocalNotificationsPlugin();

  String? get token => tokenForMessages;

  Future<void> initialize() async {
    // Request permissions
    await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    // Get token
    tokenForMessages = await _firebaseMessaging.getToken();
    print('FirebaseMessaging token: $tokenForMessages');

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Foreground message handler (app is open)
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received foreground message: ${message.notification?.title}');
      final data = message.data;
      if (data['type'] == 'call') {
        _handleMessage(message);  // Direct for calls
      } else {
        _showLocalNotification(message);  // Normal
      }
    });

    // Handle when user taps a notification (app was backgrounded)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notification tapped: ${message.notification?.title}');
      _handleMessage(message);
    });

    // Handle initial message (app launched from terminated state via notification)
    RemoteMessage? initialMessage = await _firebaseMessaging.getInitialMessage();
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }
  }

  // Initialize local notifications (platform-specific setup)
  Future<void> _initializeLocalNotifications() async {
    const AndroidInitializationSettings androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const InitializationSettings initSettings = InitializationSettings(
      android: androidInit,
      iOS: iosInit,
    );
    await _localNotifications.initialize(initSettings);
  }

  Future<void> _showLocalNotification(RemoteMessage message) async {
    try {
      // Debug: Log full message
      print('Full FCM message to show local notif:');
      print('  Notification: ${message.notification?.toMap()}');
      print('  Data: ${message.data}');

      const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
        'high_importance_channel',
        'High Importance Notifications',
        channelDescription: 'This channel is used for important app notifications.',
        importance: Importance.high,
        priority: Priority.high,
        showWhen: true,
      );

      const DarwinNotificationDetails iosDetails = DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      );

      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      final String title = message.notification?.title ?? message.data['title'] ?? 'Untitled Notification';
      final String body = message.notification?.body ?? message.data['body'] ?? 'No details provided';

      await _localNotifications.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title,
        body,
        platformDetails,
        payload: jsonEncode(message.data),
      );

      print('Local notification shown: $title - $body');
    } catch (e) {
      print('Error showing local notification: $e');
    }
  }

  void _handleMessage(RemoteMessage message) {
    print('Handling message: ${message.data}');
    final data = message.data;

  }

}







