import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import '../../../config/assets.dart';
import '../../../config/common_functions.dart';
import '../../../config/routes.dart';
import '../../../config/theme.dart';
import '../../../data/source/local/hive_box.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_scaffold.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../common_widgets/overlay_loading_progress.dart';
import '../bloc/login_bloc.dart';
import '../google_log_in/google_login.dart';
import 'otp_screen.dart';
class MobileLoginScreen extends StatefulWidget {
  const MobileLoginScreen({super.key});
  @override
  State<MobileLoginScreen> createState() => _MobileLoginScreenState();
}

class _MobileLoginScreenState extends State<MobileLoginScreen> {
  LoginBloc loginBloc=LoginBloc();
  TextEditingController mobileController=TextEditingController();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        child: Center(
          child: SingleChildScrollView(
            child: Column(children: [

              BlocListener<LoginBloc,LoginState>(
                  bloc:loginBloc ,
                  listener: (BuildContext context,
                  LoginState state){
                    state is LoginLoadingState?OverlayLoadingProgress.start(context):OverlayLoadingProgress.stop();

                   if(state is LoginOtpSentState){
hideKeyboard();

                     Navigator.pushNamed(context,  AppRoutes.otpScreen,arguments: OtpModel(otp: "${state.otp}",
                         mobileNumber: state.mobileNumber));
                     mobileController.clear();
                   }else if(state is LoginErrorState){
                     mobileController.clear();
                     showToast('something wrong try again');
                   }

                  },
              child: SizedBox(),),

              SizedBox(
                  height: 200,
                  width: 200,
                  child: Image.asset(AppAssetsPath.logo,)),
              30.height(),
              Form(
                key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: CustomTextField(
                          isNumber: true,
                  textController:mobileController ,
                placeHolderText: "Continue with mobile number",
                title:"Continue with mobile number" ,
                prefix: SizedBox(
                    width: 80,
                    child: Center(child: Text(" 🇮🇳 +91",
                          style: context.titleSmall()?.copyWith(color: AppColors.black),

                    ))),

                  length:10,
                  validator: (String? data){
                            if(data?.length!=10){
                return "Enter valid mobile Number";
                            }
                  },

                ),
              ),
              20.height(),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: CustomButton(
                    buttonColor: Theme.of(context).primaryColor,
                    buttonText: "Continue", onPress: (){
hideKeyboard();
if(formKey.currentState?.validate()??false){
  loginBloc.add(LoginSendOtpEvent(mobileNumber: mobileController.text));
}

                              }),
              ),
              20.height(),
            Text("Continue with social media",

            style: context.bodySmall()?.copyWith(

            ),
            ),
              20.height(),
              InkWell(
                onTap: ()async{
                  hideKeyboard();
             User? user=    await AuthService.signInWithGoogle();
             if(user!=null){
               MyHiveBox.instance.getBox().put(AppStr.loginPhoneOrEmail, user.email);


               Navigator.pushNamedAndRemoveUntil(context, AppRoutes.businessDetailsScreen,
                       (u)=>false);
             }else{
               showToast("something wrong try again");
             }
                },
                child: Container(
                  width: double.infinity,
                  height:50,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: Center(
                    child: Row(
                    mainAxisSize: MainAxisSize.min,
                      children: [
                      SizedBox(
                          height: 30,
                          width: 30,
                          child: Image.asset(AppAssetsPath.roundGoogle)),
                        10.width(),
                        Text("Continue with Google",
                        style: context.bodyMedium()?.copyWith(
                          color: AppColors.white,
                          fontWeight: FontWeight.bold
                        ),)
                              ],),
                  ),),
              )
            ],),
          ),
        ),
      ),

    );
  }
}
