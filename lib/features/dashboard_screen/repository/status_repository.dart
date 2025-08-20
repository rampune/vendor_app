import 'package:dio/dio.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
class StatusRepository{
static Future<ApiResults?> kycStatusRepo({required String vendorId})async{
  return DioClient(baseUrl: EndPoints.baseUrl)
      .getData(endPoint: "vendor_status/$vendorId/"
  );
}

}