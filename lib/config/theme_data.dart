import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_pubup_partner/config/theme.dart';


ThemeData theme = ThemeData(
    useMaterial3: false,
    brightness: Brightness.light,
    primaryColor: AppColors.themeColor,
    indicatorColor: Colors.white,
    buttonTheme: ButtonThemeData(buttonColor: Colors.white),
    primaryColorLight: AppColors.themeColor,
    scaffoldBackgroundColor: AppColors.themeBackgroundColor,
    hintColor: Colors.black54,
    appBarTheme: AppBarTheme(
      iconTheme: IconThemeData(
        color: Colors.white, //change your color here
      ),
      backgroundColor: AppColors.themeColor,
      actionsIconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.roboto(
          fontSize: 18, fontStyle: FontStyle.normal, color: Colors.white),
    ),
    cardColor: Colors.white,

    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.red, // selectionColor: Colors.green,
      selectionHandleColor: AppColors.red,
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    listTileTheme: const ListTileThemeData(
      iconColor: Colors.black,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.black54),
      suffixIconColor: AppColors.themeColor,
      prefixIconColor: AppColors.themeColor,
      focusColor: Colors.white54,
      contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 9.0),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.red)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: AppColors.textFieldBorderColor),
      ),
      border: OutlineInputBorder(
          borderSide:
              BorderSide(width: 1, color: AppColors.textFieldBorderColor)),
      fillColor: AppColors.white,
      filled: true,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
            iconColor: WidgetStateProperty.all(AppColors.themeColor))),
    textTheme: TextTheme(
      titleMedium: GoogleFonts.roboto(
          fontSize: isiPad ? 25 : 20,
          fontWeight: FontWeight.w400,
          color: Colors.black),
      titleSmall: GoogleFonts.roboto(
          fontSize: isiPad ? 22 : 16,
          fontWeight: FontWeight.w400,
          color: Colors.black),
      bodySmall: GoogleFonts.roboto(
          fontSize: isiPad ? 15 : 12,
          fontWeight: FontWeight.w400,
          color: Colors.black),
      bodyMedium: GoogleFonts.roboto(
          fontSize: isiPad ? 20 : 16,
          fontStyle: FontStyle.normal,
          color: Colors.black),
      labelSmall: GoogleFonts.roboto(
          fontSize: isiPad ? 20 : 13,
          fontWeight: FontWeight.w500,
          color: Colors.black),
      labelMedium: GoogleFonts.roboto(
          fontSize: isiPad ? 23 : 15,
          fontWeight: FontWeight.w500,
          color: Colors.black),
    ),
    dialogBackgroundColor: Colors.white,
    expansionTileTheme: ExpansionTileThemeData(
        backgroundColor: Colors.white,
        iconColor: AppColors.themeColor,
        collapsedIconColor: Colors.black,
        collapsedBackgroundColor: Colors.white,
        textColor: Colors.black),
    checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppColors.themeColor;
          } else {
            return Colors.transparent;
          }
        }),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
    bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.white),
    progressIndicatorTheme: ProgressIndicatorThemeData(
        refreshBackgroundColor: AppColors.themeColor),
    segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return AppColors.themeColor;
                }
                return Colors.white;
              },
            ),
            foregroundColor:
                WidgetStateColor.resolveWith((Set<WidgetState> states) {
              return states.contains(WidgetState.selected)
                  ? Colors.white
                  : Colors.black;
            }),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
            side: WidgetStateProperty.all(
                BorderSide(color: Colors.black, width: 1)))));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    canvasColor: const Color(0xFF1F1F1F),
    primaryColor: AppColors.darkThemeColor,
    buttonTheme: ButtonThemeData(buttonColor: Colors.black),
    indicatorColor: Colors.white54,
    primaryColorDark: Colors.white54,
    scaffoldBackgroundColor:AppColors.darkThemeBackgroundColor,
    hintColor: Colors.white54,
    appBarTheme: AppBarTheme(

      backgroundColor: const Color(0x991F1F1F),
      actionsIconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.roboto(
          fontSize: 18, fontStyle: FontStyle.normal, color: Colors.white),
    ),
    cardColor: const Color(0xFF1E1E1E),


    bottomSheetTheme:
        BottomSheetThemeData(backgroundColor: const Color(0xFF1E1E1E)),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: AppColors.red, // selectionColor: Colors.green,
      selectionHandleColor: AppColors.red,
    ),
    listTileTheme: const ListTileThemeData(
        iconColor: Colors.white,
        tileColor: Color(0xFF1E1E1E),
        style: ListTileStyle.list),
    radioTheme:
        RadioThemeData(fillColor: WidgetStateProperty.all(Colors.white54)),
    iconTheme: const IconThemeData(color: Colors.white54),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white54),
      suffixIconColor: Colors.white54,
      focusColor: Colors.white54,
      errorStyle: TextStyle(color: Colors.red),
      contentPadding: EdgeInsets.symmetric(vertical: 9.0, horizontal: 9.0),
      errorBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: AppColors.red)),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Color(0xFF969696)),
      ),
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xFF5B5B5B))),
      border: OutlineInputBorder(
          borderSide: BorderSide(width: 1, color: Color(0xFF969696))),
      fillColor: Color(0xFF2D2D2D),
      filled: true,
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(iconColor: WidgetStateProperty.all(Colors.white54))),
    textTheme: TextTheme(
        titleMedium: GoogleFonts.roboto(
            fontSize: isiPad ? 25 : 20,
            fontWeight: FontWeight.w400,
            color: Colors.white54),
        titleSmall: GoogleFonts.roboto(
            fontSize: isiPad ? 22 : 16,
            fontWeight: FontWeight.w400,
            color: Colors.white54),
        bodySmall: GoogleFonts.roboto(
            fontSize: isiPad ? 15 : 12,
            fontWeight: FontWeight.w400,
            color: Colors.white54),
        bodyMedium: GoogleFonts.roboto(
            fontSize: isiPad ? 20 : 16,
            fontStyle: FontStyle.normal,
            color: Colors.white54),
        labelSmall: GoogleFonts.roboto(
            fontSize: isiPad ? 20 : 13,
            fontWeight: FontWeight.w500,
            color: Colors.white),
        labelMedium: GoogleFonts.roboto(
            fontSize: isiPad ? 23 : 15,
            fontWeight: FontWeight.w500,
            color: Colors.white)),
    dialogBackgroundColor: const Color(0xFF363636),
    expansionTileTheme: const ExpansionTileThemeData(
        backgroundColor: Color(0xFF363636),
        iconColor: Colors.white54,
        collapsedIconColor: Colors.white54,
        collapsedBackgroundColor: Color(0xFF1E1E1E)),
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.all(Colors.white54),
    ),
    progressIndicatorTheme:
        ProgressIndicatorThemeData(refreshBackgroundColor: Colors.white54),
    segmentedButtonTheme: SegmentedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith<Color>(
              (Set<WidgetState> states) {
                if (states.contains(WidgetState.selected)) {
                  return Colors.white54;
                }
                return Colors.white;
              },
            ),
            foregroundColor:
                WidgetStateColor.resolveWith((Set<WidgetState> states) {
              return states.contains(WidgetState.selected)
                  ? Colors.white
                  : Colors.black;
            }),
            shape: WidgetStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4))),
            side: WidgetStateProperty.all(
                BorderSide(color: Colors.black, width: 1)))));
