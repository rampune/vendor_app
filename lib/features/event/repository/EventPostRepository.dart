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


  static Future<ApiResults?> pauseEventRepo({
    required int eventId,
    required bool isPaused,
  }) async {

    final updateData = {'isEventPause': isPaused};
    ApiResults? results = await DioClient(baseUrl: EndPoints.baseUrl).
    patchData(
      endPoint: "event_manage/$eventId/",
      data: updateData,
    );
    return results;
  }


  static Future<ApiResults?> deleteEventRepo({
    required int eventId,
  }) async {
    ApiResults? results = await DioClient(baseUrl: EndPoints.baseUrl)
        .deleteData(endPoint: "event_manage/$eventId/");
    return results;
  }


  static Future<ApiResults?> updateEventRepo({
    required int eventId,
    required Map<String, dynamic> mapData,
    required List<ImageUploadModel> listImgUploadModel,
    required List<int> listCategory,
  }) async {
    ApiResults? results = await DioClient(baseUrl: EndPoints.baseUrl).
    uploadImagesWithData(imageFiles: listImgUploadModel, data: mapData, endPoint: "event_manage/$eventId/");
    return results;
  }


}