import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/admin_details/model/business_resister_model.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/kyc/blocs/KycBloc.dart';
import 'package:new_pubup_partner/features/kyc/models/all_kyc_model.dart';
import 'package:new_pubup_partner/features/kyc/views/bank_kyc.dart';
import 'package:new_pubup_partner/features/kyc/views/business_kyc.dart';
import 'package:new_pubup_partner/features/kyc/views/owner_kyc.dart';
import 'package:new_pubup_partner/features/kyc/views/upload_kyc.dart';
import 'package:new_pubup_partner/utils/save_and_retrive_file.dart';
import '../../config/common_functions.dart';
import '../../config/routes.dart';
import '../../config/string.dart';
import '../../config/theme.dart';
import '../../data/source/local/blocs/hive_bloc.dart';
import '../../data/source/local/hive_box.dart';
import '../common_widgets/custom_button.dart';
import '../common_widgets/custom_view_pager.dart';
import 'kyc_controller/kyc_controller.dart';
import 'models/bank_kyc_model.dart';
import 'models/business_kyc_model.dart';
import 'models/owner_details_kyc_model.dart';
import 'models/upload_kyc_model.dart';
class Kyc extends StatefulWidget {
  const Kyc({super.key});

  @override
  State<Kyc> createState() => _KycState();
}

class _KycState extends State<Kyc> {
  PageController pageController=PageController();
  HiveBloc hiveBloc=HiveBloc();

  KycBloc kycBloc=KycBloc();

  int screen=0;
  @override
  void initState() {
    if (MyHiveBox.instance.getBox().get(AppStr.businessKyc) != null) {
      hiveBloc.add(HiveGetBusinessKycEvent());
    }
    if (MyHiveBox.instance.getBox().get(AppStr.bankKyc) != null) {
      hiveBloc.add(HiveGetBankKycEvent());
    }
    if (MyHiveBox.instance.getBox().get(AppStr.ownerKyc) != null) {
      hiveBloc.add(HiveGetOwnerKycEvent());
    }
    if (MyHiveBox.instance.getBox().get(AppStr.uploadKyc) != null) {
      hiveBloc.add(HiveGetUploadKycEvent());
    }
    //TODO:here autofill
    if (MyHiveBox.instance.getBox().get(AppStr.businessRegistration) != null) {
      BusinessRegisterModel? model = BusinessProfileData
          .getBusinessRegistrationData();
      KycController.businessName.text =
          model?.businessData?.businessRegistrationName ?? '';
      KycController.constitution.text = model?.businessData?.constitution ?? '';
      KycController.ownerEmailId.text =
          model?.businessData?.businessRegistrationName ?? 'test@gmai.com';

      KycController.ownerEmailId.text = BusinessProfileData
          .getBusinessRegistrationData()
          ?.businessData
          ?.email ?? "test@gmail.com";

      super.initState();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:
      SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
         Align(
           alignment: Alignment.topRight,
           child: InkWell(
               onTap: (){

                 askConfirmation(context, "Are you sure exit Kyc ?",
                     confirmCallBack: (){
                       Navigator.pop(context);
                     });

               },
               child: Icon(Icons.close_sharp,
               color: AppColors.redLight,)),
         ),

              Expanded(
                child: CustomViewPager
                  (

                    callBack: (int index){
                        setState(() {
                          screen=index;
                        });

                    },
                    listScreens: [BusinessKyc(),

                      BankKyc(),
                      OwnerKyc(),
                      UploadKyc()
                    ],
                    controller: pageController),
              ),
              CustomButton(buttonText:

             screen==3?"Submit": "Save & Next",
                  onPress: ()async{
                hideKeyboard();



            if(screen==0){
                  print("KycController.checkPhoto.text ${KycController.checkPhoto.text}");
                  hiveBloc.add(HiveSaveBusinessKycEvent
                    (businessKycModel: BusinessKycModel(
                      businessType: KycController.selectedTypeIndex,
                      vendorName: KycController.vendorName.text,
                      businessRegistrationName: KycController.businessName.text,
                      constitution: KycController.constitution.text,
                      gstNumber: KycController.gst.text,
                      panCard: KycController.panCard.text,
                      fssaiLicense: KycController.fssai.text,


                  )));

                }else if(screen==1){
                  hiveBloc.add(HiveSaveBankKycEvent(bankKycModel:
                  BankKycModel(
                    bankName: KycController.bankName.text??'',
                    accountNumber: KycController.accountNumber.text??'',
                    accountName: KycController.accountName.text,
                    ifscCode: KycController.ifscCode.text??'',
                    checkImageUrl: KycController.checkPhoto.text??''

                  )));


                }else if(screen==2){

                  hiveBloc.add(HiveSaveOwnerKycEvent(ownerKycModel:
             OwnerKycModel(
               ownerName: KycController.ownerName.text,
               ownerEmailId: KycController.ownerEmailId.text,
               ownerContactNumber: KycController.ownerContactNumber.text,
               logoUrl: KycController.logoPhoto.text,
               businessPhotoUrl: KycController.businessLogoPhoto.text
             )));


                }

                if(screen==3){

                  hiveBloc.add(HiveSaveUploadKycEvent
                    (uploadKycModel: UploadKycModel(
                      businessRegistrationProof: KycController.businessProofPhoto.text,
                      gstCertificate: KycController.gstCertificatePhoto.text,
                      panCard: KycController.panCertificatePhoto.text,
                      fssaiLicense: KycController.fssaiCertificatePhoto.text
                  )));


                  if(!(KycController.businessKycFormKey.currentState?.validate()??false)){
print("kjfslfs");
                    setState(() {

                      screen=0;
                      moveTo(screen);
                    });
                    return;
                  }else  if(!(KycController.bankKycFormKey.currentState?.validate()??false)){
                    setState(() {

                      screen=1;
                      moveTo(screen);
                    });
                    return;
                  }else  if(!(KycController.ownerKycFormKey.currentState?.validate()??false)){
                    setState(() {

                      screen=2;
                      moveTo(screen);
                    });
                    return;
                  } else if(!(KycController.uploadKycFormKey.currentState?.validate()??false)){
showToast("please upload images");

                  }else{

                    List<ImageUploadModel> imageModelList=await imageModelFilled();
                    AllKycModel model=allKycModelFilled(id: BusinessProfileData.vendorId()??'');
                    kycBloc.add(KycUploadEvent(data: model.toJson(),
                        imgUploadModelList: imageModelList));




                  }





                }



screen++;

               moveTo(screen);

                  }),
              10.height(),
              BlocListener<HiveBloc,HiveState>(
                bloc: hiveBloc,
                listener: (BuildContext context,HiveState state){
                  if(state is HiveGetBusinessKycState){
                    KycController.businessName.text=state.businessKycModel.businessRegistrationName??'';
                    KycController.constitution.text=state.businessKycModel.constitution??'';
                    KycController.gst.text=state.businessKycModel.gstNumber??'';
                    KycController.panCard.text=state.businessKycModel.panCard??'';
                    KycController.fssai.text=state.businessKycModel.fssaiLicense??'';
                    KycController.vendorName.text=state.businessKycModel.vendorName??'';
                  }else if(state is HiveGetBankKycState){
                    KycController.bankName.text=state.bankKycModel.bankName??'';
                    KycController.
                  accountNumber.text=state.bankKycModel.accountNumber??'';
                    KycController.accountName.text=state.bankKycModel.accountName??'';
                    KycController.ifscCode.text=state.bankKycModel.ifscCode??'';
                    KycController.checkPhoto.text=state.bankKycModel.checkImageUrl??'';
                  }else if (state is HiveGetOwnerKycState){
                    KycController.ownerName.text=state.ownerKycModel.ownerName??'';
                    KycController.ownerEmailId.text=state.ownerKycModel.ownerEmailId??'';
                    KycController.ownerContactNumber.text=state.ownerKycModel.ownerContactNumber??'';

               KycController.logoPhoto.text=state.ownerKycModel.logoUrl??'';
               KycController.businessLogoPhoto.text=state.ownerKycModel.businessPhotoUrl??'';
                  }else if(state is HiveGetUploadKycState){
                    KycController.businessProofPhoto.text=state.uploadKycModel.businessRegistrationProof??'';
                    KycController.gstCertificatePhoto.text=state.uploadKycModel.businessRegistrationProof??'';
                  KycController.panCertificatePhoto.text=state.uploadKycModel.panCard??'';
                  KycController.fssaiCertificatePhoto.text=state.uploadKycModel.fssaiLicense??'';
                  }
                  showToast("${state}");

                },
                child: SizedBox(),
              ),




              BlocListener<KycBloc,KycState>(

                  bloc: kycBloc,
                  listener: (BuildContext context,KycState state){
                    state is KycLoadingState ?OverlayLoadingProgress.start(context):OverlayLoadingProgress.stop();

if(state is KycSuccessState){
  showSuccessAlert(context: context, title: "Your business details and KYC have been submitted successfully. Profile activation is under review. Thank you!",callBack: (){
    Navigator.pop(context);
    Navigator.pop(context);
  });
}else if(state is KycErrorState){
  showAlert(context, state.errorMsg);
}

                  },child: SizedBox.shrink(),)





            ],
          ),
        ),
      )
      ,);


  }

   Future<List<ImageUploadModel> > imageModelFilled()async{
    List<ImageUploadModel> imageModelList=[];
    await addImage(listModel: imageModelList, controller: KycController.checkPhoto, fileName: 'cancelled_cheque');
    await addImage(listModel: imageModelList, controller: KycController.logoPhoto, fileName: 'logo');await addImage(listModel: imageModelList, controller: KycController.businessLogoPhoto, fileName: 'business_photo');
    await addImage(listModel: imageModelList, controller: KycController.businessProofPhoto, fileName: 'business_registration_proof');
    await addImage(listModel: imageModelList, controller: KycController.gstCertificatePhoto, fileName: 'gst_certificate');
    await addImage(listModel: imageModelList, controller: KycController.panCertificatePhoto, fileName: 'pan_card_file');
    await addImage(listModel: imageModelList, controller: KycController.fssaiCertificatePhoto, fileName: 'fssai_license_file');
return imageModelList;

  }
  AllKycModel allKycModelFilled({required String id}){


    AllKycModel model=AllKycModel(
      vendorData: id,
      pubCafeFineDinningName: KycController.vendorName.text,

      businessRegistrationName:KycController.businessName.text,
      constitution:KycController.constitution.text,
      gstIn: KycController.gst.text,
      panCardNumber:KycController.panCard.text,
      fssaiLicenseNumber:KycController.fssai.text,
      bankName:KycController.bankName.text,
      accountName:KycController.accountName.text,
      accountNumber:KycController.accountNumber.text,
      ifscCode:KycController.ifscCode.text,
      ownerName:KycController.ownerName.text,
      ownerEmail:KycController.ownerEmailId.text,
      ownerContact:KycController.ownerContactNumber.text,

    );
    return model;
  }

  addImage({required List<ImageUploadModel> listModel,
    required TextEditingController controller,required String fileName})async{
    File ? file=
    await loadFile(fileName: controller.text);
    if(file!=null){
      listModel.add(ImageUploadModel(file: file,
          fileName:fileName));
    }
  }
  moveTo(int index){
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }
}
