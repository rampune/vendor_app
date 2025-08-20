import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';

import '../../../config/common_functions.dart';
import '../../../config/routes.dart';
import '../../../config/theme.dart';
import '../../../data/source/local/hive_box.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/overlay_loading_progress.dart';

class OtpModel{
  String otp,mobileNumber;
  OtpModel({required this.otp,
  required this.mobileNumber});
}
class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key,required this.otpModel});
final OtpModel otpModel;


  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
   String userEnteredOtp="";
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  30.height(),
                  Text(
                    "OTP Verification",
                    textAlign: TextAlign.center,
                    style: context.titleLarge()?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  12.height(),

                  Text(
                    "Code sent to +91 ${widget.otpModel.mobileNumber}",
                    style: context.bodyMedium()?.copyWith(
                      color: AppColors.darkGray,
                      fontSize: 14,
                    ),
                  ),

                  30.height(),


                  OtpTextField(
                    numberOfFields: 4,
                    borderRadius: BorderRadius.circular(12),
                    showFieldAsBox: true,
                    borderWidth: 1.5,
                    fieldWidth: 55,
                    fieldHeight: 55,
                    handleControllers: (controllers) {
                     userEnteredOtp="";
                      for (var controller in controllers) {
                        print(controller?.text);
                        userEnteredOtp+="${controller?.text}";
                      }
                    },
                  filled: true,
                    fillColor: AppColors.transparent,
                    cursorColor: theme.primaryColor,
                    focusedBorderColor: theme.primaryColor,
                    onCodeChanged: (code) {},
                    onSubmit: (String verificationCode) {



                      //
                      // showDialog(
                      //   context: context,
                      //   builder: (context) {
                      //
                      //
                      //
                      //     return AlertDialog(
                      //       title: const Text("Verification Code"),
                      //       content: Text('Code entered is $verificationCode'),
                      //     );
                      //
                      //
                      //   },
                      // );
                    },
                  ),

                  20.height(),
                  InkWell(
                    onTap: (){
                      hideKeyboard();
                      Navigator.pop(context);
                    },
                    child: Text(
                      "wrong number? or resent Otp",
                      style: context.bodySmall()?.copyWith(color: AppColors.blue),
                    ),
                  ),
                  30.height(),


                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: context.bodySmall(),
                      children: [
                        const TextSpan(text: "By continuing, you agree to the "),
                        TextSpan(
                          text: "Terms of Use",
                          style: context.bodySmall()?.copyWith(color: AppColors.blue),
                        ),
                        const TextSpan(text: " and "),
                        TextSpan(
                          text: "Privacy Policy",
                          style: context.bodySmall()?.copyWith(color: AppColors.blue),
                        ),
                      ],
                    ),
                  ),

                  40.height(),


                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: CustomButton(
                      buttonColor: theme.primaryColor,
                      buttonText: "Confirm",
                      onPress: () {
                        hideKeyboard();
if(userEnteredOtp.length!=4){
  showToast("please Enter 4 digit otp");
}else if(userEnteredOtp==widget.otpModel.otp){

  MyHiveBox.instance.getBox().put(AppStr.loginPhoneOrEmail, widget.otpModel.mobileNumber);
 Navigator.pushNamedAndRemoveUntil(context, AppRoutes.businessDetailsScreen,
     (u)=>false);


}else{
}
print("${userEnteredOtp}");
                      //  Navigator.pushNamed(context, AppRoutes.businessDetailsScreen);
                      },
                    ),
                  ),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
