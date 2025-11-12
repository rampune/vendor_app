// New Refund Repository
import 'package:new_pubup_partner/data/source/network/dio_client.dart';

class RefundRepository {
  Future<void> processRefund(String userId, String bookingId, int refundAmount) async {
    try {
      final response = await DioClient().postData(
        endPoint: "https://adminapi.perseverancetechnologies.com/user_refund_wallet/",
        data: {
          "user_data": userId,
          "booking_data": bookingId,
          "refund_amount": refundAmount,
        },
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception(response.message ?? 'Failed to process refund');
      }
    } catch (e) {
      throw Exception('Error processing refund: $e');
    }
  }
}

