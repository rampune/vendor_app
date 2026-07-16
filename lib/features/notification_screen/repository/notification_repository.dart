
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';

class NotificationRepository {
  NotificationRepository._private();
  static final instance = NotificationRepository._private();
  factory NotificationRepository() => instance;

  Future<ApiResults?> getVendorNotifications({required String vendorId}) async {
    try {
      final response = await DioClient(baseUrl: EndPoints.baseUrl).getData(
        endPoint: 'store_notifications/vendor/$vendorId/',
      );
      return response;
    } catch (e, s) {
      print('Notification Error: $e');
      return ApiResults(null, null, e.toString());
    }
  }
}