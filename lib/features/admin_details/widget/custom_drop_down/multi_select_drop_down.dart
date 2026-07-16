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
    this.placeHolder,
    this.selectedIds
  });
  final TextEditingController controller;
  final String ? placeHolder;
  final List<CustomDropDownModel> listCustomDropDownModel;
  final String ?heading, title;
  final String ?Function(String?)? validator;
  final Function(List<CustomDropDownModel>) onSelect;
  final List<int>? selectedIds;
  @override
  State<MultiSelectDropDown> createState() => _MultiSelectDropDownState();
}
class _MultiSelectDropDownState extends State<MultiSelectDropDown> {
   List<CustomDropDownModel> listData=[];

   @override
   void initState() {
     super.initState();
     _updateSelectedList();
   }

   void _updateSelectedList() {
     if (widget.selectedIds != null) {
       listData = widget.listCustomDropDownModel
           .where((element) => widget.selectedIds!.contains(element.id))
           .toList();
     }
   }

   @override
   void didUpdateWidget(covariant MultiSelectDropDown oldWidget) {
     super.didUpdateWidget(oldWidget);
     if (oldWidget.selectedIds != widget.selectedIds || oldWidget.listCustomDropDownModel != widget.listCustomDropDownModel) {
       _updateSelectedList();
     }
   }
  @override
  Widget build(BuildContext context) {
    return  CustomTextField(
      focusColor: AppColors.darkGray,
      placeHolderText:widget.placeHolder,
      validator: widget.validator,
      title: widget.title,
      onTap: (){
        // Create a copy of listData to use within the dialog
        List<CustomDropDownModel> dialogListData = List.from(listData);
        
        showDialog(
            context: context, builder: (context){
          return StatefulBuilder(
            builder: (context, setModalState) {
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
                          final item = widget.listCustomDropDownModel[index];
                          final isSelected = dialogListData.any((element) => element.id == item.id);
                          
                          return CustomCheckBox(
                            initialValue: isSelected,
                            callBack: (bool result){
                              setModalState(() {
                                if(result){
                                  if (!dialogListData.any((e) => e.id == item.id)) {
                                    dialogListData.add(item);
                                  }
                                }else{
                                  dialogListData.removeWhere((element) => element.id == item.id);
                                }
                              });
                            },
                            title: item.name ?? '',
                            imgUrl: "https://adminapi.perseverancetechnologies.com${item.imgUrl}",
                          );
                        },
                      ),
                    ),
                   Container(
                       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                       child: CustomButton(buttonText: "Select", onPress: (){
                         setState(() {
                           listData = List.from(dialogListData);
                         });
                         widget.onSelect(listData);
                         Navigator.pop(context);
                       }))
                  ],
                ),
              );
            }
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