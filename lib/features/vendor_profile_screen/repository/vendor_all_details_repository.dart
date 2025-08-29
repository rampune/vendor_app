import '../../../data/source/network/api_result_handler.dart';
import '../../../data/source/network/dio_client.dart';
import '../../../data/source/network/end_points.dart';

class VendorAllDetailsRepository{
  Future<ApiResults?> fetchVendorAllDetailsById(String vendorId) async {
    return DioClient(baseUrl: EndPoints.baseUrl)
        .getData(endPoint: "vendors/$vendorId/");
  }
}