import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/logger.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/common_widgets/yes_no_toggle_small.dart';
import '../../../config/common_functions.dart';
import '../../../config/routes.dart';
import '../../../config/theme.dart';
import '../../../services/lat_log_to_address.dart';
import '../../../services/location_service.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../bloc/save_details_bloc.dart';
import '../controller/admin_controller.dart';
import '../model/business_resister_model.dart';
import '../state_picker/select_city.dart';
import '../state_picker/select_state.dart';
import '../widget/custom_drop_down/custom_drop_down.dart';
class BusinessDetails extends StatefulWidget {
  const BusinessDetails({super.key});


  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  String ?stateId;
  TextEditingController constitutionController=TextEditingController();
SaveDetailsBloc saveDetailsBloc=SaveDetailsBloc();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
 static  BusinessData businessDataModel=BusinessData();
bool manualLocationOff=true;
  @override
  void initState() {
    AdminController.emailController.text=BusinessProfileData.getProfilePhoneOrEmail().phoneOrEmail;
saveDetailsBloc.add(GetBusinessDetailsEvent(emailOrPhone:BusinessProfileData.getProfilePhoneOrEmail().phoneOrEmail));

    super.initState();
  }
  @override
  Widget build(BuildContext context) {



    return  Scaffold(
      body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(20.0),
      child:


      BlocBuilder<SaveDetailsBloc,SaveDetailsState>(
        bloc: saveDetailsBloc,
        builder: (BuildContext context,
            SaveDetailsState state){


if(   state is SaveLoadingState){
  return CustomLoadingWidget();
}else if(state is SaveBusinessDetailAlreadyFillState){
           // showToast("Successfully Save Data");
            Future.delayed(Duration(microseconds: 100),(){
              Navigator.pushReplacementNamed(context, AppRoutes.dashboardScreen);
            });
          }else if(state is SaveDetailsFreshUserSuccessState){

   return businessRegistrationView(state: state);

          }

          else if (state is SaveErrorState){
            return CustomErrorWidget(
              msg: state.errorMsg,
              retryCallBack: (){
              AdminController.emailController.text=BusinessProfileData.getProfilePhoneOrEmail().phoneOrEmail;
              saveDetailsBloc.add(GetBusinessDetailsEvent(emailOrPhone:BusinessProfileData.getProfilePhoneOrEmail().phoneOrEmail));
            },);
          }
          return  SizedBox.shrink();
        },
       )

      ,
    )),);
  }

 Widget businessRegistrationView({
  required  SaveDetailsFreshUserSuccessState state
}){
   TextEditingController controller=TextEditingController();
    logger("amra-0009\n\n\n${state.businessRegisterModel.toJson()}\n\n");
    businessDataModel.status=state.businessRegisterModel.businessData?.status??"pending";
    businessDataModel.id=state.businessRegisterModel.businessData?.id??111;
    businessDataModel.phoneNo=state.businessRegisterModel.businessData?.phoneNo??"1234567890";
    businessDataModel.vendorId=state.businessRegisterModel.businessData?.vendorId;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child:


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Select the category you want to register",
                    style: context.titleLarge(),),

                  20.height(),
                  CustomDropDown(
                    validator: (String ? data){
                      if(data?.isEmpty??true){
                        return "Choose Business Type";
                      }

                    },
                    title: "Business Type",
                    controller: AdminController.vendorType,
                    listCustomDropDownModel: [
                      CustomDropDownModel(name: "Pub"),
                      CustomDropDownModel(name: "Cafe"),
                      CustomDropDownModel(name: "Fine Dinning"),],
                    heading: "Select Constitution",
                    onSelect: (CustomDropDownModel onSelect){
                      print("\n\n\n$onSelect \n\n");
                      AdminController.vendorType.text=onSelect.name;
                    },
                  ),

                  10.height(),
                  CustomTextField(textController: AdminController.businessNameController,
                    title: "Business Registration Name",
                    validator: (String ?data){
                      if("$data".length<4){
                        return "Enter Valid Business Name";
                      }
                    },
                  ),
                  10.height(),
                  CustomDropDown(
                    validator: (String ? data){
                      if(data?.isEmpty??true){
                        return "select constitution";
                      }

                    },
                    title: "Constitution",
                    controller: AdminController.constitutionController,
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
                      AdminController.constitutionController.text=onSelect.name;
                    },
                  ),

                  10.height(),

                  CustomTextField(
                    isNumber:  !BusinessProfileData.getProfilePhoneOrEmail().
                    isPhone,
                    textController: AdminController.phoneOrEmailController,

                    title:
                    BusinessProfileData.getProfilePhoneOrEmail().
                    isPhone?
                    "Email Id":"Phone Number",
                    length:  BusinessProfileData.getProfilePhoneOrEmail().
                    isPhone?36:10,
                    validator: (String?data){
                      if(BusinessProfileData.getProfilePhoneOrEmail().
                      isPhone){
                        if(!(data?.isValidEmail()??false)){
                          return "Enter valid email id";
                        }

                      }else{
                        if(data?.length!=10){
                          return "Enter valid phone number";
                        }
                      }

                    },
                  ),

                  10.height(),
                  CustomTextField(
                  //  readOnly: true,
                    textController: AdminController.emailController,
                    title: BusinessProfileData.getProfilePhoneOrEmail().
                    isPhone?"phone no":"Email ID",
                  ),
                  10.height(),
                  CustomTextField(
                    textController: AdminController.websiteController,
                    title: "Website",
                    validator: (String? data){
if(!"$data".isValidWebsite()){
  return "Enter valid website url";
}
                    },
                  ),

                  10.height(),

                  Row(
                    children: [
                      Text("Enter Manual Location "),
                      10.width(),
                      OnOffToggleSmall(isOff: manualLocationOff,
                      callBack: (){
                        setState(() {
                          manualLocationOff=!manualLocationOff;
                        });
                      },
                      ),
                    ],
                  ),
                  10.height(),




                  ///AmraRam old Code
                  // if(manualLocationOff)    CustomTextField(
                  //
                  //   focusColor: AppColors.darkGray,
                  //   readOnly: true,
                  //   onTap: ()async{
                  //     OverlayLoadingProgress.start(context);
                  //     Position? position=await   LocationService().getPosition(context,timeoutSecond: 30);
                  //     double  lat=position?.latitude??0;
                  //     double  log=position?.longitude??0;
                  //     String ? address=await getAddressFromLatLng(position?.latitude??0.0, position?.longitude??0.0,timeOutSecond: 20);
                  //     if(address!=null){
                  //       AdminController.addressController.text=jsonEncode({
                  //         "address":address,
                  //         "lat":lat,
                  //         "log":log
                  //       });
                  //     }else if(position!=null){
                  //
                  //       AdminController.addressController.text="lat : ${position.latitude} log : ${position.longitude}";
                  //     }
                  //     OverlayLoadingProgress.stop();
                  //   },
                  //   placeHolderText: "Select Location",
                  //   suffix: Icon(Icons.arrow_drop_down_sharp),
                  //   textController:AdminController.addressController,
                  //   title: "Address",
                  //   validator: (String ? data){
                  //     if(data?.isEmpty??true){
                  //       return "Please Select Address";
                  //     }
                  //   },
                  // ),


                  ///Saransh new code
                  if(manualLocationOff)
                    CustomTextField(
                    focusColor: AppColors.darkGray,
                    readOnly: true,
                    onTap: () async {
                      OverlayLoadingProgress.start(context);
                      try {
                        // Get the current position
                        Position? position = await LocationService().getPosition(context, timeoutSecond: 30);
                        double lat = position?.latitude ?? 0.0;
                        double lng = position?.longitude ?? 0.0;

                        // Fetch detailed address using geocoding package
                        List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng).timeout(Duration(seconds: 20));
                        Placemark placemark = placemarks.first;

                        // Extract address components
                        String? street = placemark.street;
                        String? locality = placemark.locality; // City
                        String? administrativeArea = placemark.administrativeArea; // State
                        String? postalCode = placemark.postalCode; // Pincode
                        String? subLocality = placemark.subLocality; // Landmark or neighborhood
                        String? name = placemark.name; // Building or specific place name

                        // Combine building, landmark, and street for address field
                        String formattedAddress = [
                          name ?? '',
                          street ?? '',
                          subLocality ?? '',
                        ].where((element) => element.isNotEmpty).join(', ');

                        // Update controllers
                        if (formattedAddress.isNotEmpty) {
                          AdminController.addressController.text = formattedAddress;
                          AdminController.cityController.text = locality ?? '';
                          AdminController.stateController.text = administrativeArea ?? '';
                          AdminController.pinController.text = postalCode ?? '';

                          // Optionally store full data in JSON for reference
                          AdminController.addressController.text = formattedAddress; // Only building, street, landmark
                        } else if (position != null) {
                          AdminController.addressController.text = "lat: ${position.latitude}, lng: ${position.longitude}";
                          AdminController.cityController.text = '';
                          AdminController.stateController.text = '';
                          AdminController.pinController.text = '';
                        }
                      } catch (e) {
                        debugPrint("Error fetching address: $e");
                      } finally {
                        OverlayLoadingProgress.stop();
                      }
                    },
                    placeHolderText: "Select Location",
                    suffix: Icon(Icons.arrow_drop_down_sharp),
                    textController: AdminController.addressController,
                    title: "Address",
                    validator: (String? data) {
                      if (data?.isEmpty ?? true) {
                        return "Please Select Address";
                      }
                      return null;
                    },
                  ),


                  if(!manualLocationOff)    10.height(),
                  if(!manualLocationOff)     CustomTextField(textController: AdminController.addressController,
                    title: "Address",
                  validator: (String? data){
                    if(data?.isEmpty??true){
                      return "Enter valid Address";
                    }
                  },
                  ),
                  10.height(),
                  if(!manualLocationOff)      Row(children: [
                    Expanded(child: SelectState(

                      callBack: (String selected) {
                        setState(() {
                          stateId=selected;
                        });

                      },
                      controller: AdminController.stateController,
                      validator: (String? data){
                        if(data?.isEmpty??true){
                          return "Please choose State";
                        }
                      },
                    )),
                    20.width(),
                    if(stateId!=null)  Expanded(child: SelectCity(
                      controller: AdminController.cityController,
                      stateId: stateId!,
                      validator: (String? data){
                        if(data?.isEmpty??true){
                          return "Please choose city";
                        }
                      },
                      callBack: (String selectedItemCode){

                      },
                    ),

                    ),

                  ],),

                  10.height(),

                  if(!manualLocationOff)   Row(children: [
                    Expanded(child: CustomTextField
                      (textController: controller,title: "Country",
                      placeHolderText: "INDIA",
                      readOnly: true,
                    )),
                    20.width(),
                    Expanded(child: CustomTextField(
                      isNumber: true,
                      textController: AdminController.pinController,title: "Pin Code",
                      length: 6,
                      validator: (String?data){
                        if(data?.length!=6){
                          return "Enter Valid Pin";
                        }
                      },
                    )),
                  ],),

                  10.height(),

                ],),
            ),
          ),
        ),


        CustomButton(buttonText:
        "Submit",
            onPress: (){
              hideKeyboard();
              if(!(formKey.currentState?.validate()??false)){
                showAlert(context, "Please Enter valid data");
                return;
              }
              businessDataModel. businessType=AdminController.vendorType.text ;
              businessDataModel. businessRegistrationName=AdminController.businessNameController.text;
              businessDataModel.  constitution=AdminController.constitutionController.text;
              BusinessProfileData.getProfilePhoneOrEmail().isPhone?  businessDataModel.email=
              AdminController.phoneOrEmailController.text:businessDataModel.phoneNo=AdminController.phoneOrEmailController.text;
              businessDataModel.  website= AdminController.websiteController.text;
              businessDataModel.    address= AdminController.addressController.text;
              businessDataModel. state=AdminController.stateController.text;
              businessDataModel. city= AdminController.cityController.text;
              businessDataModel. pinCode= AdminController.pinController.text;
              businessDataModel.   country= "INDIA";
              saveDetailsBloc.add(SaveBusinessDetailsEvent(businessData:businessDataModel,
              vendorId: businessDataModel.vendorId??""));

            }

            ),
        10.height(),



      ],
    );

  }

}
