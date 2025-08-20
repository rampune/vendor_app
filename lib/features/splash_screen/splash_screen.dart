import 'package:flutter/material.dart';
import 'package:new_pubup_partner/features/splash_screen/widget/splash_logo.dart';
import '../../config/assets.dart';
import '../../config/config.dart';
import '../../config/routes.dart';
import '../common_widgets/custom_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
 Future.delayed(Duration(seconds: 3),(){

  Navigator.pushReplacementNamed(context, AppRoutes.partnerLogin);
 });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      backgroundColor: scaffoldThemeBackgroundColor(context),
      body: SplashLogo(
        logoUrl: AppAssetsPath.logo,
      ));
  }
}
