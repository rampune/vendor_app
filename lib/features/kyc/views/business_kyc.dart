import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import '../../../data/source/local/blocs/hive_bloc.dart';
import '../../admin_details/widget/custom_drop_down/custom_drop_down.dart';
import '../../common_widgets/custom_text_field.dart';
import '../kyc_controller/kyc_controller.dart';
class BusinessKyc extends StatefulWidget {
  const BusinessKyc({super.key});
  @override
  State<BusinessKyc> createState() => _BusinessKycState();
}
class _BusinessKycState extends State<BusinessKyc> with AutomaticKeepAliveClientMixin{
  HiveBloc hiveBloc=HiveBloc();


  TextEditingController constitutionController=TextEditingController();

  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  @override
  void initState() {
    constitutionController.text="Select Constitution";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return  SingleChildScrollView(
      child: Form(
        key: KycController.businessKycFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Business Registration",
              style: context.titleLarge(),),
            20.height(),
            Text("Build your Business profile and Mange Everything from One Dashboard",
              style: context.titleSmall(),),
            20.height(),
            //    Pub/Cafe/Fine Dinning Name
            CustomTextField(textController: KycController.vendorName,
              title: "Pub/Cafe/Fine Dinning Name",
              validator: (String ?data){
                if("$data".length<4){
                  return "Enter Valid Pub/Cafe/Fine Dinning Name";
                }
              },
            ),
            20.height(),
            CustomTextField(textController: KycController.businessName,
              title: "Business Registration Name",
              validator: (String ?data){
                if("$data".length<4){
                  return "Enter Valid Business Name";
                }
              },
            ),
            20.height(),
            CustomDropDown(
              title: "Constitution",
              controller: KycController.constitution,

              listCustomDropDownModel: [
                CustomDropDownModel(name: "Proprietorship"),
                CustomDropDownModel(name: "Partnership"),
                CustomDropDownModel(name: "OPC"),
                CustomDropDownModel(name: "Private Limited AOP"),
                CustomDropDownModel(name: "BOI"),
                CustomDropDownModel(name: "Any Other")
              ],
              heading: "Select Constitution",

              onSelect: (CustomDropDownModel onSelect){
                print("\n\n\n$onSelect \n\n");
                KycController.constitution.text=onSelect.name;
              },
              validator: (String? data){
                if(data?.isEmpty??true){
                  return "Please choose Constitution";
                }
              },
            ),

            20.height(),
            CustomTextField(textController: KycController.businessDescription,
              title: "Business Description",
              validator: (String? data){
                if("$data".length<500){

                }else{
                  return "Enter Valid Business Description";
                }
              },

            ),


            20.height(),
            CustomTextField(textController: KycController.gst,
              title: "GST IN",
              length: 15,
              validator: (String? data){
                if(data?.length==15){

                }else{
                  return "Enter Valid GST NUMBER";
                }
              },

            ),
            20.height(),
            CustomTextField(textController: KycController.panCard,
              title: "Pan Card".toUpperCase(),
              length: 10,
              validator: (String? data){
                if(data?.length==10){

                }else{
                  return "Enter Valid Pan Number";
                }
              },
            ),
            20.height(),
            CustomTextField(textController: KycController.fssai,
              title: "FSSAI License",

            ),
            20.height(),


          ],),
      ),



    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}