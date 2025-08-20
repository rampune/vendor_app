import 'dart:convert';
import 'dart:io';

import '../../../data/source/network/dio_client.dart';

class SponsorAdsRepo{
  static uploadRepo({required Map<String,dynamic> data,
    required File imgFile
  })async {
    print("\n\n\n data  \n${jsonEncode(data)}");
    return DioClient(baseUrl: "https://adminapi.perseverancetechnologies.com/")
        .uploadImagesWithData(imageFiles: [ImageUploadModel(file: imgFile!,
        fileName: "image")], data:data,endPoint: "promotion/");
  }
}