import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import '../../common_widgets/custom_file_picker_container.dart';
import '../../common_widgets/custom_text_field.dart';
import '../../admin_details/controller/admin_controller.dart' show AdminController;
import '../kyc_controller/kyc_controller.dart';
class BankKyc extends StatefulWidget {
  const BankKyc({super.key});

  @override
  State<BankKyc> createState() => _BankKycState();
}

class _BankKycState extends State<BankKyc> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: KycController.bankKycFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Bank Account Details",
              style: context.titleLarge(),),
             20.height(),
            Text("Build your Business profile and Mange Everything from One Dashboard",
              style: context.titleSmall(),),
            20.height(),
            CustomTextField(textController: KycController.bankName,
              title: "Bank Name",
                length: 25,
                validator: (String? data){
                  if(data?.isEmpty??true){
                    return "Enter Bank Name";
                  }
                },
            ),
             20.height(),
            CustomTextField(textController: KycController.accountNumber,
              title: "Account Number",
            isNumber: true,
              length: 20,
              validator: (String? data){
                if(data?.isEmpty??true){
                  return "Enter valid account number";
                }
              },
            ),
             20.height(),
            CustomTextField(textController: KycController.accountName,
              title: "Account Name",
                length: 25,
                validator: (String? data){
                  if(data?.isEmpty??true){
                    return "Enter valid account Name";
                  }
                }),
             20.height(),
            CustomTextField(textController: KycController.ifscCode,
              title: "IFSC Code",
                length: 19,
                validator: (String? data){
                  if(data?.isEmpty??true){
                    return "Enter valid Ifsc code";
                  }
                }),
             20.height(),
            CustomFilePickerContainer(title: "Cancelled Cheque",
            controller: KycController.checkPhoto
            ,validator: (String? data){
              if(data==AppStr.filePickerDefaultText){
                return "Please pick file";
              }
              },
            )
          ],),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
