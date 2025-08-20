import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';


import '../../../config/string.dart';
import '../../admin_details/controller/admin_controller.dart';
import '../../common_widgets/custom_file_picker_container.dart';
import '../../common_widgets/custom_text_field.dart';
import '../kyc_controller/kyc_controller.dart';
class OwnerKyc extends StatefulWidget {
  const OwnerKyc({super.key});

  @override
  State<OwnerKyc> createState() => _OwnerKycState();
}

class _OwnerKycState extends State<OwnerKyc> with AutomaticKeepAliveClientMixin {
  GlobalKey<FormState> formKey=GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return   SingleChildScrollView(
      child: Form(
        key: KycController.ownerKycFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Owner Details",
              style: context.titleLarge(),),
            10.height(),
            Text("Build your Business profile and Mange Everything from One Dashboard",
              style: context.titleSmall(),),

        20.height(),

            CustomTextField(textController: KycController.ownerName,
              title: "Owner Name",
                validator: (String? data){
                  if(data?.isEmpty??true){
                    return "Enter valid valid ownerName";
                  }
                }),
            20.height(),
            CustomTextField(

                textController: KycController.ownerEmailId,
              title: "Owner E-Mail ID",
                validator: (String? data){
                  if(!(data?.isValidEmail()??false)){
                    return "Enter valid Email ID";
                  }
                }
            ),
            20.height(),
            CustomTextField(textController: KycController.ownerContactNumber,
              title: "Owner Contact No.",isNumber: true
              ,
              length: 10,
                validator: (String? data){
                  if(data?.length!=10){
                    return "Enter valid Contact Number";
                  }
                }


              ),

          20.height(),
            CustomFilePickerContainer(
              title: "Logo",
              controller: KycController.logoPhoto
                ,validator: (String? data){
      if(data==AppStr.filePickerDefaultText){
      return "Please pick file";
      }
      }
            ),
            20.height(),

            CustomFilePickerContainer(
              title: "Business Photo",
              controller: KycController.businessLogoPhoto
                ,validator: (String? data){
      if(data==AppStr.filePickerDefaultText){
      return "Please pick file";
      }
      }
            ),


          ],),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive =>
  true;
}
