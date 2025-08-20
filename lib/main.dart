import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:new_pubup_partner/config/theme_bloc/theme_bloc.dart';
import 'package:new_pubup_partner/firebase_options.dart';
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
  await hiveBox.clear();

  runApp(BlocProvider(
    create: (context) => ThemeBloc(),
    child: App(),
  ));
}

