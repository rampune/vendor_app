import 'dart:convert';
import 'dart:developer';
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
  Future<ApiResults?> patchBusinessDetails({
    required Map<String, dynamic> mapData,
    required String vendorId,
  }) async {
    log("vender dat\n\n${jsonEncode(mapData)}\n\n");
    
    // Check if the payload targets vendor_details fields
    final isVendorDetails = mapData.containsKey('pub_cafe_fine_dinning_description') ||
                            mapData.containsKey('pub_cafe_fine_dinning_name') ||
                            mapData.containsKey('isPubPause');
    final endPoint = isVendorDetails 
        ? "vendor_details/$vendorId/" 
        : "vendor_register/$vendorId/";

    return DioClient(baseUrl: EndPoints.baseUrl).patchData(
      endPoint: endPoint,
      data: mapData,
    );
  }


}