import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
import 'package:new_pubup_partner/features/all_bookings/model/event_booking_model.dart';

class EventBookingRepository {
  Future<EventBookingsResponse?> fetchEventBookingsByVendor(String vendorId) async {
    try {
      final response = await DioClient().getData(
        endPoint: "${EndPoints.baseUrl}booking/vendor_id/$vendorId/",
      );

      if (response.statusCode == 200 || response.statusCode== 201) {
        final Map<String, dynamic> jsonData = response.data ?? {};
        return EventBookingsResponse.fromJson(jsonData);
      } else {
        throw Exception(response.message ?? 'Failed to fetch bookings');
      }
    } catch (e) {
      throw Exception('Error fetching event bookings: $e');
    }
  }
}