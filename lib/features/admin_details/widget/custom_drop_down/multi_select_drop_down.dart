import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_text_field.dart';
import 'dart:core';
import '../../../../config/theme.dart';
import '../../../common_widgets/custom_check_box.dart';
import 'custom_drop_down.dart';
class MultiSelectDropDown extends StatefulWidget {
  const MultiSelectDropDown({super.key, required this.controller,
    required this.listCustomDropDownModel,
    this.heading, this.title, required this.onSelect,
    this.validator,
    this.placeHolder
  });
  final TextEditingController controller;
  final String ? placeHolder;
  final List<CustomDropDownModel> listCustomDropDownModel;
  final String ?heading, title;
  final String ?Function(String?)? validator;
  final Function(List<CustomDropDownModel>) onSelect;
  @override
  State<MultiSelectDropDown> createState() => _MultiSelectDropDownState();
}
class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
   List<CustomDropDownModel> listData=[];
  @override
  Widget build(BuildContext context) {
    return  CustomTextField(
      focusColor: AppColors.darkGray,
      placeHolderText:widget.placeHolder,
      validator: widget.validator,
      title: widget.title,
      onTap: (){
        showDialog(
            //barrierDismissible: false,
            context: context, builder: (_){
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
                  child: Text(widget.heading??'',
                      style: context.bodyMedium()),
                ),
                const Divider(height: 3, thickness: 1),
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:widget.listCustomDropDownModel.length ,
                    itemBuilder: (_, index) {
                      return CustomCheckBox(
                        callBack: (bool result){
                          if(result){
                         listData.add(widget.listCustomDropDownModel[index]);
                          }else{
                          listData.remove(widget.listCustomDropDownModel[index]);
                          }
                        },title: widget.listCustomDropDownModel[index].name,
                        imgUrl: "https://adminapi.perseverancetechnologies.com${widget.listCustomDropDownModel[index].imgUrl}",
                      );
                    },
                  ),
                ),
               Container(
                   margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                   child: CustomButton(buttonText: "Select", onPress: (){
                     widget.onSelect(listData);
                     listData.clear();
                     Navigator.pop(context);

                   }))
              ],
            ),
          );
        });
        },
      textController: widget.controller,
      readOnly: true,
      suffix: Icon(Icons.arrow_drop_down_circle_rounded,
        color: AppColors.darkGray,),
    );
  }
}