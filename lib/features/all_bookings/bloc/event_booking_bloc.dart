// bloc/event_booking_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/all_bookings/event/event_booking_event.dart';
import 'package:new_pubup_partner/features/all_bookings/repository/event_booking_repository.dart';
import 'package:new_pubup_partner/features/all_bookings/state/event_booking_state.dart';


class EventBookingBloc extends Bloc<EventBookingEvent, EventBookingState> {
  final EventBookingRepository repository = EventBookingRepository();

  EventBookingBloc() : super(EventBookingInitial()) {
    on<FetchEventBookings>(_onFetchEventBookings);
  }

  Future<void> _onFetchEventBookings(FetchEventBookings event, Emitter<EventBookingState> emit) async {
    emit(EventBookingLoading());
    try {
      final response = await repository.fetchEventBookingsByVendor(event.vendorId);
      if (response?.status == 'success' && response?.data != null) {
        emit(EventBookingLoaded(response!.data!));
      } else {
        emit(EventBookingError('No bookings found'));
      }
    } catch (e) {
      emit(EventBookingError(e.toString()));
    }
  }
}