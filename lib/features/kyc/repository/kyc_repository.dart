import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:new_pubup_partner/data/source/network/dio_client.dart';
class KycRepository{

  static saveKycRepo({required List<ImageUploadModel> imageModelList,
  required Map<String,dynamic> mapData
  })async{
log("\n\nkyc data  ${jsonEncode(mapData)} \n\n\n  \n\n\n");
return DioClient(baseUrl: "https://adminapi.perseverancetechnologies.com/").uploadImagesWithData(imageFiles:imageModelList,
    data:mapData, endPoint: "vendor_details/");
  }
}