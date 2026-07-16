import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
class KycRepository{

  static saveKycRepo({
    required List<ImageUploadModel> imageModelList,
    required Map<String, dynamic> mapData,
    ProgressCallback? uploadProgress,
  }) async {
    log("\n\nkyc data  ${jsonEncode(mapData)} \n\n\n  \n\n\n");
    return DioClient(
      baseUrl: "https://adminapi.perseverancetechnologies.com/",
      connectTimeout: const Duration(minutes: 5),
      receiveTimeout: const Duration(minutes: 5),
      sendTimeout: const Duration(minutes: 5),
    ).uploadImagesWithData(
      imageFiles: imageModelList,
      data: mapData,
      endPoint: "vendor_details/",
      uploadProgress: uploadProgress,
    );
  }
}