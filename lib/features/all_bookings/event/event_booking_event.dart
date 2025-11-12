
abstract class EventBookingEvent {}

class FetchEventBookings extends EventBookingEvent {
  final String vendorId;
  FetchEventBookings({required this.vendorId});

}

// Updated event_booking_event.dart (add/update the CancelEventBooking class)
class CancelEventBooking extends EventBookingEvent {
  final String bookingId;
  final String vendorId;
  final String userId;
  final int refundAmount;
 CancelEventBooking(
     this.bookingId,
     this.vendorId,
     this.userId,
     this.refundAmount,
     );
}