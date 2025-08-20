import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';


import '../../config/common_functions.dart';
import '../../config/theme.dart' show AppColors;
import '../../utils/pickers/pickers.dart';
import '../../utils/save_and_retrive_file.dart';
class CustomFilePickerContainer extends StatefulWidget {
  const CustomFilePickerContainer({super.key,
  required this.title, required this.controller,this.titleBold,this.validator});
final String title;
final bool ?titleBold;
final TextEditingController controller;
final String? Function(String?) ?validator;

  @override
  State<CustomFilePickerContainer> createState() => _CustomFilePickerContainerState();
}

class _CustomFilePickerContainerState extends State<CustomFilePickerContainer> {
  @override
  Widget build(BuildContext context) {

    if(widget.controller.text.isEmpty){
      widget.controller.text=AppStr.filePickerDefaultText;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.title,style:context.titleSmall()?.copyWith(
          fontWeight: widget.titleBold!=null?FontWeight.bold:null
        ) ,),
        12.height(),
        DottedBorder(
          options: RectDottedBorderOptions(
            color: AppColors.darkGray,
            dashPattern: [5, 5],
            strokeWidth: 1.5,
            padding: EdgeInsets.all(10),
          ),
          child: Container(
            decoration: BoxDecoration(
                color: AppColors.white
            ),
            child: Row(
              children: [
                5.width(),
                Icon(Icons.backup_outlined),
                10.width(),
                Expanded(
                  child:
                  TextFormField(

                    onTap: (){
                      AppPickers.showFilePickerOption(context,
                              (File ?file){

                            final int fileSize = file?.lengthSync()??0; // in bytes
                            if (fileSize <= 3*1024 * 1024) {

                              String?  fileName=file?.path.split('/').last;
                              saveFile(fileName: fileName??'',file: file);
                              widget.controller.text=fileName??'';
                              setState(() {

                              });

                            } else {
                              showToast("File is larger than 1MB");
                            }



                          });
                    },
                    validator: widget.validator,
                    maxLines: 2,
                    controller: widget.controller,
                    readOnly: true,
                    style: context.bodySmall()?.copyWith(
                        color:widget.controller.text==AppStr.filePickerDefaultText? AppColors.redLight:AppColors.darkGray
                    ),
                    decoration: InputDecoration(

                        enabledBorder:OutlineInputBorder(

                          borderSide: BorderSide(color: AppColors.transparent),


                        ) ,
                        focusedErrorBorder: OutlineInputBorder(

                          borderSide: BorderSide(color: AppColors.transparent),


                        ),
                        errorBorder:OutlineInputBorder(

                            borderSide: BorderSide(color: AppColors.transparent)),




                        focusedBorder:OutlineInputBorder(

                          borderSide: BorderSide(color: AppColors.transparent),

                        ) ,
                        border: OutlineInputBorder(

                          borderSide: BorderSide(color: AppColors.transparent),

                        )
                    ),

                  ),

                )

              ],
            ),
          ),
        )

      ],
    );
  }
}
