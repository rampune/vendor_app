import 'dart:convert';

import 'package:flutter/material.dart';
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


  Future<void> cancelEventBooking(String bookingId) async {
    try {
      print('Cancelling booking with ID: $bookingId'); // Debug log
      final response = await DioClient().patchData(
        endPoint: "${EndPoints.baseUrl}booking/$bookingId/",
        data: {"booking_status": "cancelled"},
      );
      debugPrint('Cancel response status: ${response.statusCode}'); // Debug log
      debugPrint('Cancel response data: ${jsonEncode(response.data)}'); // Debug log: Print full response data
      debugPrint('Cancel response message: ${response.message}'); // Debug log

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.message ?? 'Failed to cancel booking');
      }
      debugPrint('Booking cancellation successful'); // Debug log
    } catch (e) {
      debugPrint('Cancel error: $e'); // Debug log
      throw Exception('Error cancelling event booking: $e');
    }
  }
}