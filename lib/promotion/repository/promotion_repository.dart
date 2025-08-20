

import '../../data/source/network/api_result_handler.dart';
import '../../data/source/network/dio_client.dart';
import '../../data/source/network/end_points.dart';

class PromotionRepository{
 static Future<ApiResults> getPromotionCardRepository()async{
return DioClient(baseUrl:  EndPoints.baseUrl)
    .getData(endPoint: "promotion/");
  }

}