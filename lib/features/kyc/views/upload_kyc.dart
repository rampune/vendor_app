import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';


import '../../../config/string.dart';
import '../../admin_details/controller/admin_controller.dart';
import '../../common_widgets/custom_file_picker_container.dart';
import '../../common_widgets/custom_text_field.dart';
import '../kyc_controller/kyc_controller.dart';
class UploadKyc extends StatefulWidget {
  const UploadKyc({super.key});
  @override
  State<UploadKyc> createState() => _UploadKycState();
}

class _UploadKycState extends State<UploadKyc> with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: KycController.uploadKycFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Upload KYC",
              style: context.titleLarge(),),
            10.height(),
            Text("Upload Business Documents to  Verify & Active  your Membership.",
              style: context.titleSmall(),),
            20.height(),
            CustomFilePickerContainer
              (title: "Business Registration Proof",
            controller: KycController.businessProofPhoto,
                validator: (String? data){
      if(data==AppStr.filePickerDefaultText){
      return "Please pick file";
      }
      }
            ),
            20.height(),
            CustomFilePickerContainer
              (title: "GST IN Certificate",
            controller: KycController.gstCertificatePhoto
                ,validator: (String? data){
      if(data==AppStr.filePickerDefaultText){
      return "Please pick file";
      }
      }
            ),
            20.height(),
            CustomFilePickerContainer
              (title: "Pan Card",
            controller: KycController.panCertificatePhoto
                ,validator: (String? data){
      if(data==AppStr.filePickerDefaultText){
      return "Please pick file";
      }
      }),
            20.height(),
            CustomFilePickerContainer
              (title: "FSSAI Licence",
            controller: KycController.fssaiCertificatePhoto
                ,validator: (String? data){
                  if(data==AppStr.filePickerDefaultText){
                    return "Please pick file";
                  }
                }),
          ],),
      ),
    );
  }
  @override
  bool get wantKeepAlive => true;
}
