import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';

import '../../../config/theme.dart';
import '../../../utils/pickers/pickers.dart';
import '../../common_widgets/custom_text_field.dart';
class SlotWidget extends StatelessWidget {
  const SlotWidget({super.key,
  required this.title,this.deleteCallBack,
    required this.startTimeController,required this.endTimeController,this.validator,this.timeGapInMinute=1});
  final String title;
  final GestureTapCallback? deleteCallBack;
  final String? Function(String?) ?validator;
  final int timeGapInMinute;

final TextEditingController startTimeController,endTimeController;

  @override
  Widget build(BuildContext context) {
    return  Row(

      children: [
        Expanded(child: CustomTextField(
          validator: validator,
            onTap: ()async{



              String ?timeData= await AppPickers.timePicker(context,);
              if(timeData!=null){
                startTimeController.text =timeData;
              }


            },
            readOnly: true,

            suffix: Icon(Icons. lock_clock,
              color: AppColors.darkGray,),
            title: "Start Time",
            placeHolderText: "start time",
            focusColor: AppColors.darkGray,

            textController: startTimeController)),
        10.width(),
        Expanded(child: CustomTextField(
          validator: validator,
            onTap: ()async{
              if(startTimeController.text.isEmpty){
                showToast("Please select start time first");
                return;
              }
              final parsedDateTime = DateFormat('HH:mm').parse(startTimeController.text);
              final timeOfDay = TimeOfDay(hour: parsedDateTime.hour, minute: parsedDateTime.minute+timeGapInMinute);

 String ?timeData= await AppPickers.timePicker(context,startTime: timeOfDay);
 if(timeData!=null){
   endTimeController.text =timeData;
 }


            },

            readOnly: true,
            focusColor: AppColors.darkGray,
            suffix: Icon(Icons. lock_clock ,
              color: AppColors.darkGray,),
            title: "End Time",

            placeHolderText: "end time",
            textController: endTimeController))

      ],);
  }
}
