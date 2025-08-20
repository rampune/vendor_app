import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
class EventPostRepository{
  static Future<ApiResults?> postEventRepo({required Map<String,dynamic> mapData,
  required List<ImageUploadModel> listImgUploadModel,
 required List<int> listCategory
  })async{
    ApiResults ?results=await DioClient(baseUrl: EndPoints.baseUrl).
    uploadImagesWithData(imageFiles: listImgUploadModel, data:mapData
        , endPoint: "event_manage/");
  return results;
  }
  static Future<ApiResults?> getEventRepo({
  required String vendorId})async{
    ApiResults ?results=await DioClient(baseUrl: EndPoints.baseUrl).
    getData(endPoint: "event_manage/vendor_id/$vendorId/");
    return results;
  }
}