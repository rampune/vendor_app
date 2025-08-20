import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/local/hive_box.dart';
import 'package:new_pubup_partner/features/admin_details/widget/custom_drop_down/custom_drop_down.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_file_picker_container.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_text_field.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/sponsor_ads_screen/SponsorController.dart';
import 'package:new_pubup_partner/features/sponsor_ads_screen/bloc/sponsor_ads_bloc.dart';
import 'package:new_pubup_partner/features/sponsor_ads_screen/model/ads_model.dart';
import 'package:new_pubup_partner/utils/save_and_retrive_file.dart';
import '../../utils/pickers/pickers.dart';

class SponsorAdsScreen extends StatelessWidget {
  const SponsorAdsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Center(
            child: SingleChildScrollView(
              child: Form(
                key: SponsorController.formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        askConfirmation(
                          context,
                          "Are you sure exit Sponsor Ads ?",
                          confirmCallBack: () {
                            Navigator.pop(context);
                          },
                        );
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Icon(Icons.close, color: AppColors.red),
                      ),
                    ),
                    10.height(),

                    Text(
                      "Put Your Party in the Spotlight",
                      style: context.titleLarge(),
                    ),
                    20.height(),
                    Text(
                      "Build your Business profile and Mange Everything from One Dashboard",
                      style: context.titleSmall(),
                    ),
                    20.height(),
                    CustomTextField(
                      textController: SponsorController.adsName,
                      title: "AdvertisementName",

                      validator: (String? data) {
                        if (data?.isEmpty ?? true) {
                          return "Please Enter Advertisement Name";
                        }
                      },
                    ),

                    20.height(),
                    CustomDropDown(
                      heading: "choose duration",
                      title: "Ad Duration",
                      validator: (String? data) {
                        if (data?.isEmpty ?? true) {
                          return "Please Choose Ad Duration";
                        }
                      },

                      controller: SponsorController.adDuration,
                      listCustomDropDownModel: [
                        CustomDropDownModel(name: "1 Week"),
                        CustomDropDownModel(name: "2 Weeks"),
                        CustomDropDownModel(name: "3 Weeks"),
                        CustomDropDownModel(name: "1 Month"),
                      ],
                      onSelect: (CustomDropDownModel model) {},
                    ),

                    20.height(),
                    CustomDropDown(
                      heading: "promotion type",
                      title: "Promotion Type",
                      validator: (String? data) {
                        if (data?.isEmpty ?? true) {
                          return "Please Choose Promotion type";
                        }
                      },

                      controller: SponsorController.promotionType,
                      listCustomDropDownModel: [
                        CustomDropDownModel(name: "Business Promotion"),
                        CustomDropDownModel(name: "Event Promotion"),
                        CustomDropDownModel(name: "Other"),
                      ],
                      onSelect: (CustomDropDownModel model) {},
                    ),
                    20.height(),
                    CustomTextField(
                      textController: SponsorController.adStartDate,
                      title: "Ad Start Date",
                      validator: (String? data) {
                        if (data?.isEmpty ?? true) {
                          return "Please Choose Start Date";
                        }
                      },

                      readOnly: true,
                      onTap: () async {
                        SponsorController.adStartDate.text =
                            await AppPickers.datePicker(context);
                      },
                      suffix: Icon(
                        Icons.calendar_month_outlined,
                        color: AppColors.black,
                        size: 35,
                      ),
                    ),
                    20.height(),
                    CustomFilePickerContainer(
                      title: "Banner Photo",
                      controller: SponsorController.bannerPhoto,
                      validator: (String? data) {
                        if (data == AppStr.filePickerDefaultText) {
                          return "Please Pick a file";
                        }
                      },
                    ),
                    30.height(),
                    CustomButton(
                      buttonText: "Submit",
                      onPress: () async {
                        if (SponsorController.formKey.currentState
                                ?.validate() ??
                            false) {
                          File? file = await loadFile(
                            fileName: SponsorController.bannerPhoto.text,
                          );
                          SponsorController.sponsorAdsBloc.add(
                            SponsorAdsUploadDataEvent(
                              data: AdsModel(
                                vendorId: BusinessProfileData.vendorId(),
                                //"${MyHiveBox().getBox().get(AppStr.vendorId)}"
                                name: SponsorController.adsName.text,
                                duration: SponsorController.adDuration.text,
                                promotion_type:
                                    SponsorController.promotionType.text,
                                start_date: SponsorController.adStartDate.text,
                              ).toJson(),
                              imgFile: file!,
                            ),
                          );
                        } else {
                        }
                      },
                    ),

                    BlocListener<SponsorAdsBloc, SponsorAdsState>(
                      bloc: SponsorController.sponsorAdsBloc,
                      listener: (BuildContext context, SponsorAdsState state) {
                        state is SponsorAdsLoadingState
                            ? OverlayLoadingProgress.start(context)
                            : OverlayLoadingProgress.stop();
                        if (state is SponsorAdsSuccessState) {
                          showSuccessAlert(context: context, title:  "Your sponsor ad request has been submitted successfully! Our team will review and get back to you shortly.",
                          callBack: (){
                            SponsorController.clearSponsorController();

                            Navigator.pop(context);
                            Navigator.pop(context);
                          });
                 

                        } else if (state is SponsorAdsErrorState) {
                          showAlert(context, "${state.errorMsg}");
                        }
                      },
                      child: SizedBox.shrink(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
