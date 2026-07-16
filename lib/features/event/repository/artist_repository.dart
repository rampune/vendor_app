import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';

class ArtistRepository{

  Future<ApiResults?> postArtistData({required Map<String,dynamic> mapData,
    required ImageUploadModel imgModel})async{
    return DioClient(baseUrl: EndPoints.baseUrl).uploadImagesWithData(endPoint: "event_artists/",
        imageFiles: [imgModel],
        data: mapData);
  }

  Future<ApiResults?> getArtistData()async{
    return DioClient(baseUrl: EndPoints.baseUrl).getData(endPoint: "event_artists/");
  }

  Future<ApiResults> deleteArtist({required int artistId}) async {
    return DioClient(baseUrl: EndPoints.baseUrl)
        .deleteData(endPoint: "event_artists/$artistId/");
  }

}