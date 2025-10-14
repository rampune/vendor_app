// bloc/event_booking_state.dart
import 'package:new_pubup_partner/features/all_bookings/model/event_booking_model.dart';

abstract class EventBookingState {}

class EventBookingInitial extends EventBookingState {}

class EventBookingLoading extends EventBookingState {}

class EventBookingLoaded extends EventBookingState {
  final List<EventBookingModel> bookings;
  EventBookingLoaded(this.bookings);
}

class EventBookingError extends EventBookingState {
  final String message;
  EventBookingError(this.message);
}