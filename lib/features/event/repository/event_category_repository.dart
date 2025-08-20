import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';

class EventCategoryRepository{
  static Future<ApiResults> getEventCategory() async {
    return DioClient(baseUrl: EndPoints.baseUrl).getData(endPoint: "event_category/");
  }
}