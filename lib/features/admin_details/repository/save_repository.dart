import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import '../../../data/source/network/api_result_handler.dart';
import '../../../data/source/network/dio_client.dart';
import '../../../data/source/network/end_points.dart';

class SaveRepository{

  SaveRepository._private();
 static  SaveRepository instance=  SaveRepository._private();
  factory SaveRepository()=>instance;

 Future<ApiResults?> saveBusinessDetails({required Map<String,dynamic> mapData})async{

   log("vender dat\n\n${jsonEncode(mapData)}\n\n");
    return DioClient(baseUrl: EndPoints.baseUrl)
        .postData(endPoint: "vendor_register/",data: mapData
   );
  }
  Future<ApiResults?> patchBusinessDetails({required Map<String,dynamic> mapData,
    required String vendorId})async{

    log("vender dat\n\n${jsonEncode(mapData)}\n\n");
    return DioClient(baseUrl: EndPoints.baseUrl)
        .patchData(endPoint: "vendor_register/$vendorId/",data: mapData
       );
  }


}