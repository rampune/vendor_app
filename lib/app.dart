import 'package:flutter/material.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/local/secure_storage/secure_vendor_storage.dart';
import 'package:new_pubup_partner/features/admin_details/model/business_resister_model.dart';
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
  // _getHome() {
  //   String? isLogin = MyHiveBox.instance.getBox().get(
  //     "login",
  //     defaultValue: null,
  //   );
  //   return isLogin == null
  //       ? SplashScreen()
  //       : BusinessProfileData.getBusinessRegistrationData()
  //                 ?.businessData
  //                 ?.businessRegistrationName ==
  //             null
  //       ? BusinessDetails()
  //       : DashboardScreen();
  // }



  _getHome() {
    return FutureBuilder<String?>(
      future: SecureVendorStorage().getLoginIdentifier(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.data == null) {
          return const SplashScreen(); // Not logged in
        }

        // User is logged in → Check if profile is complete
        return FutureBuilder<BusinessRegisterModel?>(
          future: SecureVendorStorage().getBusinessProfile(),
          builder: (context, profileSnapshot) {
            if (profileSnapshot.connectionState == ConnectionState.waiting) {
              return const Scaffold(body: Center(child: CircularProgressIndicator()));
            }

            final profile = profileSnapshot.data;

            if (profile?.businessData?.businessRegistrationName == null ||
                profile!.businessData!.businessRegistrationName!.isEmpty) {
              return const BusinessDetails(); // Force complete profile
            }

            return const DashboardScreen(); // Fully logged in
          },
        );
      },
    );
  }




}
