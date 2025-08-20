import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/navigation_util.dart';
import 'package:new_pubup_partner/config/theme.dart';


import 'package:url_launcher/url_launcher.dart';

import '../features/common_widgets/custom_group_toggle_btn.dart';
import 'assets.dart';



RegExp alphanumericRegEx = RegExp(r'[^a-zA-Z0-9 ]');

String getCurrentDate() {
  return DateFormat('dd/MM/yyyy HH:mm:ss').format(DateTime.now()).toString();
}

Future<void> openMap(double latitude, double longitude) async {
  String googleUrl =
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

  final Uri launchUri = Uri.parse(googleUrl);
  await launchUrl(launchUri, mode: LaunchMode.externalApplication);
}






Future<void> dialNumber(String phoneNumber) async {
  final Uri launchUri = Uri(
    scheme: 'tel',
    path: phoneNumber,
  );
  await launchUrl(launchUri);
}

Future<void> openUrl(String url, {bool? isLaunchModeApp = false}) async {
  final Uri launchUri = Uri.parse(url);
  await launchUrl(launchUri,
      mode: isLaunchModeApp == true
          ? LaunchMode.inAppWebView
          : LaunchMode.externalApplication);
}



showSuccessAlert({
  required BuildContext context,
  required String title,
  GestureTapCallback? callBack,
  bool? barrierDismissible,
}) {
  showDialog(
    barrierDismissible: barrierDismissible ?? false,
    context: context,
    builder: (_) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        elevation: 12,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              Lottie.asset(
                AppAssetsPath.successAnimation,
                repeat: false,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 24),
              Text(
                title,
                textAlign: TextAlign.center,
                style: context.titleMedium()?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  color: AppColors.greenDark,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.themeColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    elevation: 6,
                  ),
                  onPressed: callBack ??
                          () {
                        Navigator.pop(context);
                      },
                  child: Text(
                    "OK",
                    style: context.titleMedium()?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}



void showAlert(BuildContext context, String message,
    {Function()? callback,
      EdgeInsets? insetPadding,
      bool barrierDismissible = false}) {
  Future.delayed(Duration.zero, () {
    showDialog(
        barrierDismissible: barrierDismissible,
        context: context,
        builder: (context) => PopScope(
          canPop: barrierDismissible,
          onPopInvokedWithResult: (bool didPop, Object? result) {
            if (didPop) return;
          },
          child: AlertDialog(
            insetPadding: insetPadding,
            contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)),
            surfaceTintColor: AppColors.themeColor,
            content: Text(
              message,

              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  key: ValueKey('yes'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    Theme.of(context).primaryColor, // background
                    // foreground
                  ),
                  onPressed: callback ??
                          () {
context.pop();
                      },
                  child: Text(

                    "OK",
                  ),
                ),
              ),
            ],
          ),
        ));
  });
}


void askConfirmationState(
    BuildContext context,

    final String message, {

      Function()? confirmCallBack,
      GestureTapCallback? cancelCallBack,
      EdgeInsets? insetPadding,

      bool barrierDismissible = false,
      Widget? heading
    }) {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => PopScope(
        canPop: barrierDismissible,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (didPop) return;
        },
        child: Dialog(
          insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white.withOpacity(0.95),
          elevation: 16,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 30,
                  spreadRadius: 1,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                heading?? Icon(Icons.help_outline_rounded,
                    color: AppColors.themeColor, size: 48),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.titleSmall()?.copyWith(

                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPremiumButton(
                      title: "Cancel",
                      textColor: Colors.red,
                      borderColor: Colors.red.withOpacity(0.4),
                      onTap:cancelCallBack?? () => context.pop(),
                    ),
                    _buildPremiumButton(
                      title: "Confirm",
                      textColor: AppColors.green,
                      borderColor: AppColors.green.withOpacity(0.4),
                      onTap: () {
                        context.pop();
                        if (confirmCallBack != null) confirmCallBack();

                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });
}

void askConfirmation(
    BuildContext context,

   final String message, {
      Function()? confirmCallBack,
      EdgeInsets? insetPadding,

      bool barrierDismissible = true,
      Widget? heading
    }) {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) => PopScope(
        canPop: barrierDismissible,
        onPopInvokedWithResult: (bool didPop, Object? result) {
          if (didPop) return;
        },
        child: Dialog(
          insetPadding: insetPadding ?? EdgeInsets.symmetric(horizontal: 24),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Colors.white.withOpacity(0.95),
          elevation: 16,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.9),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 30,
                  spreadRadius: 1,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
           heading?? Icon(Icons.help_outline_rounded,
                    color: AppColors.themeColor, size: 48),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: context.titleSmall()?.copyWith(

                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPremiumButton(
                      title: "Cancel",
                      textColor: Colors.red,
                      borderColor: Colors.red.withOpacity(0.4),
                      onTap: () => context.pop(),
                    ),
                    _buildPremiumButton(
                      title: "Confirm",
                      textColor: AppColors.green,
                      borderColor: AppColors.green.withOpacity(0.4),
                      onTap: () {
                        context.pop();
                        if (confirmCallBack != null) confirmCallBack();

                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  });
}
Widget _buildPremiumButton({
  required String title,
  required Color textColor,
  required Color borderColor,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: borderColor, width: 1.5),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: borderColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
    ),
  );
}


// void askConfirmation(BuildContext context, String message,
//     {Function()? confirmCallBack,
//     EdgeInsets? insetPadding,
//     bool barrierDismissible = true}) {
//   Future.delayed(Duration.zero, () {
//     showDialog(
//         barrierDismissible: barrierDismissible,
//         context: context,
//         builder: (context) => PopScope(
//               canPop: barrierDismissible,
//               onPopInvokedWithResult: (bool didPop, Object? result) {
//                 if (didPop) return;
//               },
//               child: AlertDialog(
//                 insetPadding: insetPadding,
//                 contentPadding: EdgeInsets.fromLTRB(16, 16, 16, 0),
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0)),
//                 surfaceTintColor: AppColors.themeColor,
//                 content: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       message,
//
//                       textAlign: TextAlign.center,
//                       style: context.bodySmall()?.copyWith(
//
//                         fontSize: 15
//                       ),
//                     ),
//                     20.height(),
//                   ],
//                 ),
//                 actions: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
// SimpleOutlineButton(title: "Cancel",
// textColor: AppColors.red,
// onTap: (){
//   context.pop();
// },),
//                       SimpleOutlineButton(title: "Confirm",
//                         textColor: AppColors.green,
//                         onTap: (){
//                         if(confirmCallBack!=null){
//                           confirmCallBack();
//                         }
//
//                           context.pop();
//                         },)
//
//                   ],)
//
//                 ],
//               ),
//             ));
//   });
// }

void showAlertAndPop(BuildContext context, String message,
    {Function()? callback}) {
  Future.delayed(Duration.zero, () {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => PopScope(
              canPop: false,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                surfaceTintColor: AppColors.themeColor,
                content: Text(
                  message,

                  textAlign: TextAlign.center,
                ),
                actions: <Widget>[
                  Center(
                    child: ElevatedButton(
                      key: ValueKey('yes'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).primaryColor, // background
                        // foreground
                      ),
                      onPressed: callback ??
                          () {

                          },
                      child: Text(

                        "strAppOK",
                      ),
                    ),
                  ),
                ],
              ),
            ));
  });
}




// hide keyboard whenever needed
void hideKeyboard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

bool isImage(String fileExtension) {
  return ['png', 'jpg', 'jpeg', 'bmp', 'bitmap', 'gif'].contains(fileExtension);
}

MimeTypeRajCop getMimeType(String mimeType) {
  if (mimeType.endsWith('.jpg') ||
      mimeType.endsWith('.jpeg') ||
      mimeType.endsWith('.png') ||
      mimeType.endsWith('.bmp')) {
    return MimeTypeRajCop.IMAGE;
  } else if (mimeType.endsWith('.mp4') ||
      mimeType.endsWith('.mpeg') ||
      mimeType.endsWith('.mpe') ||
      mimeType.endsWith('.mpg') ||
      mimeType.endsWith('.mpg4') ||
      mimeType.endsWith('.m4v') ||
      mimeType.endsWith('.mov')) {
    return MimeTypeRajCop.VIDEO;
  }
  return MimeTypeRajCop.NONE;
}



enum MimeTypeRajCop { VIDEO, IMAGE, TEXT, NONE }

String getGenderByCode(code, {String lang = 'hi'}) {
  String strGender = '';
  switch (code) {
    case 1:
      strGender = lang == 'hi' ? "हिजड़ा" : 'Transgender';
      break;
    case 2:
      strGender = lang == 'hi' ? "स्त्री" : 'Female';
      break;
    case 3:
      strGender = lang == 'hi' ? "पुरुष" : 'Male';
      break;
    case 4:
      strGender = lang == 'hi' ? "अन्य" : 'Unknown';
      break;
  }
  return strGender;
}

String getGenderCodeByGenter(String gender) {
  String strGenderCd = '';
  switch (gender.toLowerCase().trim()) {
    case 'transgender':
      strGenderCd = '1';
      break;
    case 'female':
      strGenderCd = '2';
      break;
    case 'male':
      strGenderCd = '3';
      break;
    case 'unknown':
      strGenderCd = '4';
      break;
  }
  return strGenderCd;
}



enum EnumOfficeType {
  none,
  CircleOffice,
  CIDOffice,
  RangeOffice,
  DistrictOffice,
  PoliceStation
}





Widget getTitleWithAction(
    {required BuildContext ctx,
    required String title,
    Function()? callBack,
    double? bottomSpace,
    double? topSpace,
    String? boldText,
    TextStyle? style,
    Color? color}) {
  return Padding(
    padding: EdgeInsets.only(bottom: bottomSpace ?? 0.0, top: topSpace ?? 0.0),
    child: InkWell(
      onTap: callBack ?? null,
      child: Text.rich(
        TextSpan(
          children: <TextSpan>[
            new TextSpan(
                text: boldText,
                style: style?.copyWith(
                  color: color == null
                      ? Theme.of(ctx).brightness == Brightness.light
                          ? AppColors.themeColor
                          : AppColors.white
                      : color,
                  fontSize: style.fontSize,
                  fontWeight: FontWeight.w800,
                )),
            TextSpan(
                text: title,
                style: style?.copyWith(
                  color: color == null
                      ? Theme.of(ctx).brightness == Brightness.light
                          ? AppColors.themeColor
                          : AppColors.white
                      : color,
                  fontSize: style.fontSize,
                ))
          ],
        ),
      ),
    ),
  );
}

String getFileNameFromPath(String filePath) {
  String fileName = '';
  var pathForwardSlash = filePath.split('/');
  if (pathForwardSlash.length > 1) {
    fileName = pathForwardSlash.last;
  }
  if (fileName.isEmpty) {
    var pathBackwardSlash = filePath.split('\\');
    if (pathBackwardSlash.length > 1) {
      fileName = pathBackwardSlash.last;
    }
  }
  return fileName;
}

showToast(String msg,{Color? backgroundColor,Color?textColor}){
  Fluttertoast.showToast(msg: msg,backgroundColor: backgroundColor,textColor: textColor);
}
Future<bool> isInternetAvailable() async {
  try {
    final foo = await InternetAddress.lookup('google.com');
    return foo.isNotEmpty && foo[0].rawAddress.isNotEmpty ? true : false;
  } catch (e) {
    return false;
  }
}
