import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/navigation_util.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_text_field.dart';
import 'dart:core';

import '../../../../config/theme.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({super.key,required this.controller,
    required this.listCustomDropDownModel,
    this.heading,this.title,required this.onSelect,
    this.validator,
    this.placeHolder

  });
  final TextEditingController controller;
  final String ? placeHolder;
  final List<CustomDropDownModel> listCustomDropDownModel;
  final String ?heading,title;
  final String ?Function(String?)? validator;
  final Function(CustomDropDownModel ) onSelect;

  @override
  Widget build(BuildContext context) {
    return  CustomTextField(
      focusColor: AppColors.darkGray,
      placeHolderText:placeHolder,
      validator: validator,
      title: title,


      onTap: (){
showDialog(context: context, builder: (_){
  return Dialog(
    clipBehavior: Clip.antiAlias,
    insetPadding: EdgeInsets.symmetric(
        horizontal:  40, vertical: 24),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0)),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12, left: 12),
          child: Text(heading??'', style: context.bodyMedium()),
        ),
        const Divider(height: 3, thickness: 1),
        Flexible(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount:listCustomDropDownModel.length ,
            itemBuilder: (_, index) {
              return ListTile(
                dense: true,
                onTap: () {
                  controller.text=listCustomDropDownModel[index].name;
                  onSelect(CustomDropDownModel(name:listCustomDropDownModel[index].name,
                      id:listCustomDropDownModel[index].id));
                  context.pop();
                },
                title: Text(listCustomDropDownModel[index].name,
                    style: context.bodyMedium()),
              );
            },
          ),
        )
      ],
    ),
  );

});



      },
      textController: controller,

    readOnly: true,

      suffix: Icon(Icons.arrow_drop_down_circle_rounded,

      color: AppColors.darkGray,),
    );
  }
}

class CustomDropDownModel{
  String name;
  int ?id;
  String? imgUrl;


  CustomDropDownModel({required this.name, this.id,this.imgUrl});
}




