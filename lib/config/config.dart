
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/theme.dart';


const int splashTimeInSecond=3;
const String urlTemplateForMap = "https://tile.openstreetmap.org/{z}/{x}/{y}.png";
const String userAgentPackageNameForMap = "com.rajcop.official";
bool isDark(BuildContext context){
  var brightness = MediaQuery.of(context).platformBrightness;
  bool isDarkMode = brightness == Brightness.dark;
  return isDarkMode;
}
scaffoldThemeBackgroundColor(BuildContext context){
  return isDark(context)?AppColors.darkThemeBackgroundColor:AppColors.themeColor;
}
dynamicThemeColor(BuildContext context){
  return isDark(context)?AppColors.darkThemeColor:AppColors.themeColor;
}
dynamicTextFieldTheme(BuildContext context){
  return isDark(context)?AppColors.lightGray:AppColors.white;

}
dynamicWhiteBtnTheme(BuildContext context){
  return isDark(context)?AppColors.lightGray:AppColors.white;

}