import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/local/hive_box.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_file_picker_container.dart';
import 'package:new_pubup_partner/utils/save_and_retrive_file.dart';
class AllBookings extends StatefulWidget {
  const AllBookings({super.key});

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> {
  TextEditingController controller=TextEditingController();
  File? file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("All Bookings"),),

      body: Column(

//         children: [
//           100.height(),
//         CustomFilePickerContainer(title: "sdfsdf", controller: controller),
//
//
//
//         CustomButton(buttonText: "submit",
//
//               onPress: ()async {
// file =await loadFile(fileName: controller.text);
//
//             if(file!=null){
//  ApiResults? result= await DioClient(baseUrl: "${EndPoints.baseUrl}").patchUploadImageWithDataAid(
//         listUploadModel: [ImageUploadModel(file: file!, fileName: "menu")], mapData: {
//           "vendor_data":"VND2FE68DBC"
//
//     }, vendorId: 'VND2FE68DBC',
//   endPoint: "menu");
//
//
//  print("${result?.data}");
//               return;
//             }
//
// // uploadMenu(file: file!);
//
//
//
//
//               })
//
//         ],

    ),);
  }


  Future<void> uploadMenu({required File file}) async {
    final dio = Dio();

    try {
      FormData formData = FormData.fromMap({
        "vendor_data": BusinessProfileData.vendorId(), // pass actual vendor_id here
      });

      formData.files.add(
        MapEntry(
         "menu", // field name, backend should accept 'images' or 'images[]'
          await MultipartFile.fromFile(file.path,
              filename: file.path.split('/').last),
        ),
      );


      final response = await dio.patch(
        "https://adminapi.perseverancetechnologies.com/menu/${BusinessProfileData.vendorId()}/",
        data: formData,
        options: Options(
          headers: {
            "Content-Type": "multipart/form-data",
            "Authorization": "Bearer YOUR_TOKEN", // if needed
          },
        ),
      );

      print("Status Code: ${response.statusCode}");
      print("Response Data: ${response.data}");
    } on DioException catch (e) {
      print("Error Status: ${e.response?.statusCode}");
      print("Error Data: ${e.response?.data}");
    }
  }


}
