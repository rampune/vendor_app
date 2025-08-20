import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


enum DeviceType { isPhone, isTablet }

DeviceType getDeviceType() {
  final data = MediaQueryData.fromView(
      WidgetsBinding.instance.platformDispatcher.views.single);
  return data.size.shortestSide < 550
      ? DeviceType.isPhone
      : DeviceType.isTablet;
}

bool isiPad = getDeviceType() == DeviceType.isTablet ? true : false;

class AppSizes {
  static double logoWidth=120;
  static double logoHeight=120;
  static double welComeTitleSize=30;


  static double loginLogoSize = isiPad ? 200 : 200;
  static double sidePadding = isiPad ? 180 : 20;
  static const double widgetSidePadding = 20;
  static const double buttonRadius = 10;
  static double menuBarIconSize = isiPad ? 35 : 25.0;
  static double minVerticalPaddingMenuBar = isiPad ? 20 : 15.0;
}

class AppColors {

  static Color themeColor = Color(0xFFDFB61A);
  //static const themeColor = Color(0xFFF10202);
  static const darkThemeColor = Color(0xFF2C2C2C);
  static const themeBackgroundColor = Color(0xFFFFFFFF);
  static const darkThemeBackgroundColor = Color(0xFF000000);

  static const red = Color(0xFFDB3022);
  static const redLight = Color(0xFFE35247);
  static const blue = Color(0xFF0C02A8);
  static const black = Color(0xFF222222);
  static const lightGray = Color(0xFF9B9B9B);
  static const lighterGray = Color.fromARGB(242, 244, 248, 255);
  static const darkGray = Color(0xFF979797);
  static const white = Color(0xFFFFFFFF);
  static const greenLight = Color(0xFF02FB53);
  static const green = Color(0xFF2AA952);
  static const greenDark = Color(0xFF042518);
  static const orange = Color(0xFFFFBA49);
  static const background = Color(0xFFE5E5E5);
  static const transparent = Color(0x00000000);
  static const textFieldBorderColor = Colors.black;
}

class CustomTextStyle {
  static TextStyle displayMedium(BuildContext context) {
    return GoogleFonts.workSans(
        fontSize: isiPad ? 20.0 : 17.0, fontStyle: FontStyle.normal);
  }

  static TextStyle displayMediumForCustomkey(BuildContext context) {
    return GoogleFonts.workSans(
        fontSize: isiPad ? 20 : 17, fontWeight: FontWeight.w600);
  }

  static TextStyle displayLoginRichText(
      BuildContext context, Color color, bool isbold) {
    return GoogleFonts.workSans(
        fontSize: isiPad ? 20 : 18,
        fontWeight: isbold == true ? FontWeight.bold : FontWeight.normal,
        color: color);
  }

  static TextStyle displayButtonText(BuildContext context, Color color) {
    return GoogleFonts.workSans(
        fontSize: isiPad ? 20 : 16, fontWeight: FontWeight.w400, color: color);
  }
}

class DeviceSize {
  static double screenWidth(BuildContext context) {
    return MediaQuery.sizeOf(context).width;
  }

  static double screenHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height;
  }
}
