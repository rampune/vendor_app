import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';

class FoodMenuRepository{
  static Future<ApiResults?> uploadFoodMenuRepository({required
  List<ImageUploadModel> listImages,
    required Map<String ,String> mapData
  })async{
    return DioClient(baseUrl: EndPoints.baseUrl,

    ).uploadImagesWithData(imageFiles: listImages,

        data: mapData,
        endPoint: "menu/");
  }

  static Future<ApiResults?> patchFoodMenuRepository({required
  List<ImageUploadModel> listImages,

    required String vendorId
  })async{
    return DioClient(baseUrl: EndPoints.baseUrl,
    ).
    patchMultipartData(
        endPoint: "menu/", listUploadModel:listImages, mapData: {}, vendorId:vendorId);
  }
}