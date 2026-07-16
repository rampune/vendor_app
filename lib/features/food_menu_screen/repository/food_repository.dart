import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';

class FoodMenuRepository {
  /// First time upload
  static Future<ApiResults?> uploadFoodMenuRepository({
    required List<ImageUploadModel> listImages,
    required Map<String, String> mapData,
  }) async {
    return DioClient(baseUrl: EndPoints.baseUrl).uploadImagesWithData(
      imageFiles: listImages,
      data: mapData,
      endPoint: "menu/",
    );
  }

  /// Update existing images
  /// Keys: image_index_0, image_index_1, etc.
  static Future<ApiResults?> updateFoodMenuImagesRepository({
    required List<ImageUploadModel> listImages,
    required String vendorId,
  }) async {
    return DioClient(baseUrl: EndPoints.baseUrl).uploadImagesWithData(
      imageFiles: listImages,
      data: {},
      endPoint: "menu_update/$vendorId/",
      isUpdate: true,
    );
  }

  /// Add new images
  static Future<ApiResults?> patchFoodMenuRepository({
    required List<ImageUploadModel> listImages,
    required String vendorId,
  }) async {
    return DioClient(baseUrl: EndPoints.baseUrl).uploadImagesWithData(
      imageFiles: listImages,
      data: {},
      endPoint: "menu/$vendorId/",
      isUpdate: true,
    );
  }

  /// Fetch existing menu for a vendor
  static Future<ApiResults?> fetchMenuRepository({required String vendorId}) async {
    return DioClient(baseUrl: EndPoints.baseUrl)
        .getData(endPoint: "menu/$vendorId/");
  }

  /// Delete a specific image from the menu (by index)
  static Future<ApiResults?> deleteMenuImageRepository({
    required String vendorId,
    required int index,
  }) async {
    return DioClient(baseUrl: EndPoints.baseUrl).deleteData(
      endPoint: "menu_update/$vendorId/",
      queryParameters: {"index": index},
    );
  }
}