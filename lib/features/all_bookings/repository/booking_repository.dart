// booking_repository.dart
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';


class BookingRepository {
  static Future<ApiResults> getBookings({String? vendorId}) async {
    final dioClient = DioClient(baseUrl: EndPoints.baseUrl);
    return await dioClient.getData(
      endPoint: vendorId != null
          ? "${EndPoints.bookings}vendor_id/$vendorId/"
          : EndPoints.bookings,
    );
  }
}

