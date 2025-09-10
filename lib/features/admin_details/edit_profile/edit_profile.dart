import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/features/admin_details/bloc/save_details_bloc.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_text_field.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({super.key, required this.editType});
  final String editType;
  @override
  State<EditProfile> createState() => _EditProfileState();
}
class _EditProfileState extends State<EditProfile> {
  SaveDetailsBloc saveDetailsBloc = SaveDetailsBloc();
  TextEditingController emailOrWebsiteController = TextEditingController();
  bool isEmailEdit = false;
  String emailOrWebsite = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    if (widget.editType.toLowerCase() == "email") {
      isEmailEdit = true;
    }
    if (isEmailEdit) {
      emailOrWebsite =
          BusinessProfileData.getBusinessRegistrationData()
              ?.businessData
              ?.email ??
          '';
    } else {
      emailOrWebsite =
          BusinessProfileData.getBusinessRegistrationData()
              ?.businessData
              ?.website ??
          '';
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Edit ${widget.editType}"),
            10.height(),
            Text(
              emailOrWebsite,
              style: context.bodySmall()?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: BlocBuilder<SaveDetailsBloc, SaveDetailsState>(
          bloc: saveDetailsBloc,
          builder: (context, state) {
            if (state is SaveLoadingState) {
              return CustomLoadingWidget();
            } else if (state is SaveBusinessDetailAlreadyFillState) {
              return Center(
                child: Text(
                  "Your ${widget.editType} Updated successfully\n\n"
                  "updated ${widget.editType} - ${isEmailEdit ? BusinessProfileData.getBusinessRegistrationData()?.businessData?.email : BusinessProfileData.getBusinessRegistrationData()?.businessData?.website}",
               textAlign: TextAlign.center,
                  style: context.titleSmall()?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            } else if (state is SaveErrorState) {

              return CustomErrorWidget(retryCallBack: (){
                saveDetailsBloc.add(
                  SaveBusinessDetailsPatchFieldEvent(
                    mapData: {
                      widget.editType.toLowerCase():
                      emailOrWebsiteController.text,
                    },
                    vendorId: BusinessProfileData.vendorId() ?? '',
                  ),
                );
              },);
            }

            return Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  20.height(),
                  CustomTextField(
                    textController: emailOrWebsiteController,
                    title: "Enter new ${widget.editType}",
                    validator: (String? data) {
                      if (isEmailEdit) {
                        if (!(data?.isValidEmail() ?? false)) {
                          return "Enter Valid ${widget.editType}";
                        }
                      } else {
                        if (!(data?.isValidWebsite() ?? false)) {
                          return "Enter Valid ${widget.editType}";
                        }
                      }
                    },
                  ),

                  10.height(),

                  CustomButton(
                    buttonText: "Update",
                    onPress: () {

                      if(formKey.currentState?.validate()??false){
                        saveDetailsBloc.add(
                          SaveBusinessDetailsPatchFieldEvent(
                            mapData: {
                              widget.editType.toLowerCase():
                              emailOrWebsiteController.text,
                            },
                            vendorId: BusinessProfileData.vendorId() ?? '',
                          ),
                        );
                      }else{
                      //  showToast("Enter valid ${widget.editType}");
                      }

                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
