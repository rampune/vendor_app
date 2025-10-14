
abstract class EventBookingEvent {}

class FetchEventBookings extends EventBookingEvent {
  final String vendorId;
  FetchEventBookings({required this.vendorId});
}