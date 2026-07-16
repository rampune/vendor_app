// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_pubup_partner/config/common_functions.dart';
// import 'package:new_pubup_partner/config/extensions.dart';
// import 'package:new_pubup_partner/config/theme.dart';
// import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
// import 'package:new_pubup_partner/features/admin_details/bloc/save_details_bloc.dart';
// import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
// import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
// import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
// import 'package:new_pubup_partner/features/common_widgets/custom_text_field.dart';
// class EditProfile extends StatefulWidget {
//   const EditProfile({super.key, required this.editType});
//   final String editType;
//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }
// class _EditProfileState extends State<EditProfile> {
//   SaveDetailsBloc saveDetailsBloc = SaveDetailsBloc();
//   TextEditingController emailOrWebsiteController = TextEditingController();
//   bool isEmailEdit = false;
//   String emailOrWebsite = "";
//   GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   @override
//   void initState() {
//     if (widget.editType.toLowerCase() == "email") {
//       isEmailEdit = true;
//     }
//     if (isEmailEdit) {
//       emailOrWebsite =
//           BusinessProfileData.getBusinessRegistrationData()
//               ?.businessData
//               ?.email ??
//           '';
//     } else {
//       emailOrWebsite =
//           BusinessProfileData.getBusinessRegistrationData()
//               ?.businessData
//               ?.website ??
//           '';
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Column(
//           children: [
//             Text("Edit ${widget.editType}"),
//             10.height(),
//             Text(
//               emailOrWebsite,
//               style: context.bodySmall()?.copyWith(
//                 color: AppColors.white,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: BlocBuilder<SaveDetailsBloc, SaveDetailsState>(
//           bloc: saveDetailsBloc,
//           builder: (context, state) {
//             if (state is SaveLoadingState) {
//               return CustomLoadingWidget();
//             } else if (state is SaveBusinessDetailAlreadyFillState) {
//               return Center(
//                 child: Text(
//                   "Your ${widget.editType} Updated successfully\n\n"
//                   "updated ${widget.editType} - ${isEmailEdit ? BusinessProfileData.getBusinessRegistrationData()?.businessData?.email : BusinessProfileData.getBusinessRegistrationData()?.businessData?.website}",
//                textAlign: TextAlign.center,
//                   style: context.titleSmall()?.copyWith(
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               );
//             } else if (state is SaveErrorState) {
//
//               return CustomErrorWidget(retryCallBack: (){
//                 saveDetailsBloc.add(
//                   SaveBusinessDetailsPatchFieldEvent(
//                     mapData: {
//                       widget.editType.toLowerCase():
//                       emailOrWebsiteController.text,
//                     },
//                     vendorId: BusinessProfileData.vendorId() ?? '',
//                   ),
//                 );
//               },);
//             }
//
//             return Form(
//               key: formKey,
//               autovalidateMode: AutovalidateMode.onUserInteraction,
//               child: Column(
//                 children: [
//                   20.height(),
//                   CustomTextField(
//                     textController: emailOrWebsiteController,
//                     title: "Enter new ${widget.editType}",
//                     validator: (String? data) {
//                       if (isEmailEdit) {
//                         if (!(data?.isValidEmail() ?? false)) {
//                           return "Enter Valid ${widget.editType}";
//                         }
//                       } else {
//                         if (!(data?.isValidWebsite() ?? false)) {
//                           return "Enter Valid ${widget.editType}";
//                         }
//                       }
//                     },
//                   ),
//
//                   10.height(),
//
//                   CustomButton(
//                     buttonText: "Update",
//                     onPress: () {
//
//                       if(formKey.currentState?.validate()??false){
//                         saveDetailsBloc.add(
//                           SaveBusinessDetailsPatchFieldEvent(
//                             mapData: {
//                               widget.editType.toLowerCase():
//                               emailOrWebsiteController.text,
//                             },
//                             vendorId: BusinessProfileData.vendorId() ?? '',
//                           ),
//                         );
//                       }else{
//                       //  showToast("Enter valid ${widget.editType}");
//                       }
//
//                     },
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/features/admin_details/bloc/save_details_bloc.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_text_field.dart';
import 'package:new_pubup_partner/features/common_widgets/dialogs/success_dialog.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key, this.editType}); // now optional, will use arguments

  final String? editType;

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late SaveDetailsBloc saveDetailsBloc;
  late TextEditingController controller;
  late String currentValue;
  late String fieldName;
  late String fieldKey;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    saveDetailsBloc = SaveDetailsBloc();
    controller = TextEditingController();
    // Do NOT read arguments here!
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_isInitialized) {
      final args = ModalRoute.of(context)?.settings.arguments;
      
      String? initialValueFromArgs;
      
      if (args is Map<String, dynamic>) {
        fieldName = args['fieldName'] ?? 'Unknown';
        initialValueFromArgs = args['initialValue']?.toString();
      } else {
        fieldName = args as String? ?? widget.editType ?? 'Unknown';
      }

      final businessData = BusinessProfileData.getBusinessRegistrationData()?.businessData;

      switch (fieldName.toLowerCase()) {
        case 'email':
          fieldKey = 'email';
          currentValue = initialValueFromArgs ?? businessData?.email ?? '';
          break;
        case 'website':
          fieldKey = 'website';
          currentValue = initialValueFromArgs ?? businessData?.website ?? '';
          break;
        case 'approx price for 2 person':
          fieldKey = 'approx_price';
          currentValue = initialValueFromArgs ?? businessData?.approxPrice?.toString() ?? '';
          break;
        case 'about':
          fieldKey = 'pub_cafe_fine_dinning_description';
          currentValue = initialValueFromArgs ?? businessData?.pubCafeFineDinningDescription ?? '';
          break;
        case 'business name':
          fieldKey = 'pub_cafe_fine_dinning_name';
          currentValue = initialValueFromArgs ?? businessData?.pubCafeFineDinningName ?? '';
          break;
        default:
          fieldKey = fieldName.toLowerCase().replaceAll(' ', '_');
          currentValue = initialValueFromArgs ?? '';
      }

      controller.text = currentValue;
      _isInitialized = true; // Prevent running again
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  String? _validator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }

    if (fieldKey == 'approx_price') {
      final int? num = int.tryParse(value.trim());
      if (num == null || num <= 0) {
        return 'Please enter a valid price greater than 0';
      }
    } else if (fieldKey == 'email') {
      if (!value.isValidEmail()) return 'Enter a valid email address';
    } else if (fieldKey == 'website') {
      if (!value.isValidWebsite()) return 'Enter a valid website URL';
    }
    return null;
  }

  void _submit() {
    final String input = controller.text.trim();
    dynamic valueToSend = input;
    if (fieldKey == 'approx_price') {
      valueToSend = int.tryParse(input);
    }

    saveDetailsBloc.add(
      SaveBusinessDetailsPatchFieldEvent(
        mapData: {fieldKey: valueToSend},
        vendorId: BusinessProfileData.vendorId() ?? '',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isNumberField = fieldKey == 'approx_price';

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Text("Edit $fieldName"),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: BlocProvider.value(
          value: saveDetailsBloc,
          child: BlocConsumer<SaveDetailsBloc, SaveDetailsState>(
            listener: (context, state) {
              if (state is SaveBusinessDetailAlreadyFillState) {
                SuccessDialog.show(
                  context,
                  title: "Update Successfully",
                  content: "$fieldName has been updated",
                  onOk: () {
                    Navigator.of(context).pop();
                  },
                );
              }
            },
            builder: (context, state) {
              if (state is SaveLoadingState) return const CustomLoadingWidget();

              if (state is SaveErrorState) {
                return CustomErrorWidget(retryCallBack: _submit);
              }

              return Form(
                key: formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      textController: controller,
                      title: "Enter new $fieldName",
                      isNumber: isNumberField,
                      maxLines: fieldKey == 'pub_cafe_fine_dinning_description' ? 8 : 1,
                      minLines: fieldKey == 'pub_cafe_fine_dinning_description' ? 5 : 1,
                      validator: _validator,
                    ),
                    30.height(),
                    CustomButton(
                      buttonText: "Update",
                      onPress: () {
                        if (formKey.currentState!.validate()) {
                          _submit();
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}