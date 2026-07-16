import '../../../data/source/network/api_result_handler.dart';
import '../../../data/source/network/dio_client.dart';
import '../../../data/source/network/end_points.dart';

class PubCafeGalleryRepository {
  /// First time upload (Case 1)
  static Future<ApiResults?> uploadPubCafeGalleryRepository({
    required List<ImageUploadModel> listImages,
    required Map<String, String> mapData,
  }) async {
    return DioClient(baseUrl: EndPoints.baseUrl).uploadImagesWithData(
      imageFiles: listImages,
      data: mapData,
      endPoint: "gallery/",
    );
  }

  /// Update existing images (Case 2 & 3)
  /// Keys: image_index_0, image_index_1, etc.
  static Future<ApiResults?> updateGalleryImagesRepository({
    required List<ImageUploadModel> listImages,
    required String vendorId,
  }) async {
    return DioClient(baseUrl: EndPoints.baseUrl).uploadImagesWithData(
      imageFiles: listImages,
      data: {},
      endPoint: "gallery_update/$vendorId/",
      isUpdate: true, // Changed to PATCH to avoid 405 Method Not Allowed
    );

  }

  /// Add new images (Case 3 & 4)
  static Future<ApiResults?> patchPubCafeGalleryRepository({
    required List<ImageUploadModel> listImages,
    required String vendorId,
  }) async {
    return DioClient(baseUrl: EndPoints.baseUrl).uploadImagesWithData(
      imageFiles: listImages,
      data: {},
      endPoint: "gallery/$vendorId/",
      isUpdate: true, // PATCH
    );
  }

  /// Fetch existing gallery for a vendor
  static Future<ApiResults?> fetchGalleryRepository({required String vendorId}) async {
    return DioClient(baseUrl: EndPoints.baseUrl)
        .getData(endPoint: "gallery/$vendorId/");
  }

  /// Delete a specific image from the gallery (by index)
  static Future<ApiResults?> deleteGalleryImageRepository({
    required String vendorId,
    required int index,
  }) async {
    return DioClient(baseUrl: EndPoints.baseUrl).deleteData(
      endPoint: "gallery_update/$vendorId/",
      queryParameters: {"index": index},
    );
  }
}