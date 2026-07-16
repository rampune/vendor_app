import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_pubup_partner/config/theme_bloc/theme_bloc.dart';
import 'package:new_pubup_partner/firebase_options.dart';
import 'package:new_pubup_partner/services/notification/notification_services.dart';
import 'app.dart';
import 'config/string.dart';
import 'config/theme.dart';
import 'dart:io' show Platform;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: AppColors.transparent, // Your desired color
      statusBarIconBrightness: Brightness.light, // Icon color (light/dark)
    ),
  );
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown, // (Optional) Also allow upside down
  ]);
  try {
    if (Platform.isAndroid) {
      await Firebase.initializeApp();
    } else if (Platform.isIOS) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    }
  } catch (exception) {
    print("something wrong");
  }
  await Hive.initFlutter();
  await Hive.openBox(AppStr.hiveBoxName);
Box hiveBox= await Hive.openBox(AppStr.hiveBoxName);
  // await hiveBox.clear();

  // ✅ Register background handler FIRST
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  final sendNotification = SendNotification();
  await sendNotification.initialize();


  runApp(BlocProvider(
    create: (context) => ThemeBloc(),
    child: App(),
  ));
}



@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print('🔥 Background/Terminated message received: ${message.messageId}');
  print('Data: ${message.data}');
  print('Notification: ${message.notification?.title}');

  // Optional: show a local notification when app is backgrounded
  final FlutterLocalNotificationsPlugin localNotifications =
  FlutterLocalNotificationsPlugin();

  const AndroidNotificationDetails androidDetails = AndroidNotificationDetails(
    'high_importance_channel',
    'High Importance Notifications',
    channelDescription: 'Used for important notifications.',
    importance: Importance.high,
    priority: Priority.high,
  );

  const NotificationDetails details = NotificationDetails(
    android: androidDetails,
  );

  await localNotifications.show(
    DateTime.now().millisecondsSinceEpoch.remainder(100000),
    message.data['title'] ?? message.notification?.title ?? 'No Title',
    message.data['body'] ?? message.notification?.body ?? 'No Body',
    details,
  );
}

