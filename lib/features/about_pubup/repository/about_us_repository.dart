// repository/AboutUsRepository.dart
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';

class AboutUsRepository {
  static Future<ApiResults?> getAboutUsRepo() async {
    ApiResults? results = await DioClient(baseUrl: EndPoints.baseUrl)
        .getData(endPoint: "about_us/");
    return results;
  }
}