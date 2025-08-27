import '../../../data/source/network/api_result_handler.dart';
import '../../../data/source/network/dio_client.dart';
import '../../../data/source/network/end_points.dart';

class PubCafeGalleryRepository{
  static Future<ApiResults?> uploadPubCafeGalleryRepository({required
  List<ImageUploadModel> listImages,
    required Map<String ,String> mapData
  })async{
    return DioClient(baseUrl: EndPoints.baseUrl,

    ).uploadImagesWithData(
        imageFiles: listImages,
        data: mapData,
        endPoint: "gallery/");
  }

  static Future<ApiResults?> patchPubCafeGalleryRepository({required
  List<ImageUploadModel> listImages,
    required String vendorId
  })async{
    return DioClient(baseUrl: EndPoints.baseUrl,
    ).
    patchMultipartData(
        endPoint: "gallery", listUploadModel:listImages, mapData: {}, vendorId:vendorId);
  }
}