import 'package:flutter/material.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/features/admin_details/view/business_details.dart';
import 'package:new_pubup_partner/ticket_validator/ticket_validator.dart';
import 'config/navigation_util.dart';
import 'config/routes.dart';
import 'config/theme_data.dart';
import 'data/source/local/hive_box.dart';
import 'features/dashboard_screen/dashboard_screen.dart';
import 'features/splash_screen/splash_screen.dart';
class App extends StatefulWidget {
  const App({super.key});
  @override
  State<App> createState() => _AppState();
}
class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _getHome(),
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: theme,
      onGenerateRoute: AppRoutes.generateRoute,
      navigatorKey: NavigationUtil.navigatorKey,
    );
  }
  _getHome() {
    String? isLogin = MyHiveBox.instance.getBox().get(
      "login",
      defaultValue: null,
    );
    return isLogin == null
        ? SplashScreen()
        : BusinessProfileData.getBusinessRegistrationData()
                  ?.businessData
                  ?.businessRegistrationName ==
              null
        ? BusinessDetails()
        : DashboardScreen();
  }
}
