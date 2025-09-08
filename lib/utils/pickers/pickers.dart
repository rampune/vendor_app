import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:new_pubup_partner/config/common_functions.dart';

import '../../config/theme.dart';
import '../../features/common_widgets/custom_icon_with_title.dart';

class AppPickers {
  static Future<String> datePicker(BuildContext context,{DateTime ?startDate}) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:startDate?? DateTime(1950),
      lastDate: DateTime(2101),
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.themeColor,        // Header background color
              onPrimary: Colors.white,     // Header text color
              onSurface: Colors.black,     // Body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: AppColors.themeColor, // Button text color
              ),
            ),
            dialogBackgroundColor: Colors.white, // Background of the dialog
          ),
          child: child!,
        );
      },
    );

    if (pickedDate == null) {
      return "Select Birthday";
    }

    return  DateFormat('dd-MM-yyyy').format(pickedDate);
  }



/// Old code of Amra Ram
//   static Future<String?> timePicker(BuildContext context,{TimeOfDay?startTime}) async {
//    TimeOfDay timeOfDay= TimeOfDay.now();
//   final TimeOfDay? pickedTime = await showTimePicker(
//   context: context,
//   initialTime: startTime??timeOfDay,
//   builder: (BuildContext context, Widget? child) {
//     return MediaQuery(
//       data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//       child: _timePickerTheme(context, child),
//     );
//   },
//   );
// if(startTime!=null){
//   if(((startTime.hour*60)+startTime.minute)>((pickedTime?.hour??0)*60+(pickedTime?.minute??0))){
//     showToast("select after start time");
//     return null;
//   }
//
// }
//   if (pickedTime == null) {
//   return null;
//   }
//
//   final now = DateTime.now();
//   final formattedTime = DateFormat('HH:mm').format(
//   DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute),
//   );
//
//
//
//   return formattedTime;
//   }



  ///New code of Saransh Shukla
  static Future<String?> timePicker(BuildContext context,{TimeOfDay?startTime}) async {
    TimeOfDay timeOfDay= TimeOfDay.now();
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime??timeOfDay,
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: _timePickerTheme(context, child),
        );
      },
    );
    if(startTime!=null && pickedTime != null){
      int startMinutes = (startTime.hour * 60) + startTime.minute;
      int pickedMinutes = (pickedTime.hour * 60) + pickedTime.minute;
      if (pickedMinutes < startMinutes) {
        // Assume wrap-around to next day
        pickedMinutes += 24 * 60;
      }
      if (pickedMinutes <= startMinutes) {
        showToast("select after start time");
        return null;
      }
    }
    if (pickedTime == null) {
      return null;
    }

    final now = DateTime.now();
    final formattedTime = DateFormat('HH:mm').format(
      DateTime(now.year, now.month, now.day, pickedTime.hour, pickedTime.minute),
    );



    return formattedTime;
  }



  static _timePickerTheme(context,child){
    return  Theme(
      data: Theme.of(context).copyWith(
        timePickerTheme: TimePickerThemeData(
          backgroundColor: AppColors.white,
          hourMinuteTextColor: AppColors.themeColor,
          dialHandColor: AppColors.themeColor,
          dialBackgroundColor: AppColors.themeColor.withOpacity(0.1),
        ),
        colorScheme: ColorScheme.light(
          primary: AppColors.themeColor, // Dial and OK/Cancel color
          onPrimary: Colors.white,
          onSurface: AppColors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.themeColor,
          ),
        ),
      ),
      child: child,
    );
  }





static Future<File?>  pickFromFile()async{
  final ImagePicker picker = ImagePicker();
  final XFile? file = await picker.pickImage(source: ImageSource.gallery);

  if(file!=null){
    return   File(file.path);
  }
  return null;
  }
 static Future<File?> openCamera()async{
    final ImagePicker picker = ImagePicker();
    final XFile? photo = await picker.pickImage(source: ImageSource.camera);

    if(photo!=null){
   return   File(photo.path);
    }
 return null;

  }

static addStringDialog({required BuildContext context,
String? title,required Function(String) callBack}){
TextEditingController controller=TextEditingController();
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: Text(
         title?? 'Add Item',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: "Enter ${title??''}",
            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        actionsPadding: EdgeInsets.only(right: 12, bottom: 8),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel", style: TextStyle(color: Colors.grey[600])),
          ),
          ElevatedButton(
            onPressed: () {
              //  final text = _controller.text.trim();
              if(controller.text.isNotEmpty){
                callBack(controller.text);
              }

Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text("Add"),
          ),
        ],
      );
    },
  );

}

  static  showFilePickerOption(BuildContext context,Function(File?) callBack){
    showDialog(context: context, builder: (BuildContext context){
      return AlertDialog(
        content: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.min,
            children: [

             CustomIconWithTitle(iconData: Icons.camera_alt,
                 title: "Camera",
             onTap: ()async{
           File? file=  await   AppPickers.openCamera();
               Navigator.pop(context);
               callBack(file);

             },
             ),
              CustomIconWithTitle(iconData: Icons.file_copy,
                  title: "File",
              onTap: ()async{
               File? file=await  AppPickers.pickFromFile();
                Navigator.pop(context);
               callBack(file);
              },)
            ],
          ),
        ),
      );

    });
  }
}
