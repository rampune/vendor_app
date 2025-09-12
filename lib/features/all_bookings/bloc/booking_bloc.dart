import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/logger.dart';
import 'package:new_pubup_partner/features/all_bookings/event/booking_events.dart';
import 'package:new_pubup_partner/features/all_bookings/model/booking_model.dart';
import 'package:new_pubup_partner/features/all_bookings/repository/booking_repository.dart';
import 'package:new_pubup_partner/features/all_bookings/state/booking_state.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<FetchBookings>(_onFetchBookings);
  }

  Future<void> _onFetchBookings(FetchBookings event, Emitter<BookingState> emit) async {
    emit(BookingLoading());
    try {
      final response = await BookingRepository.getBookings(vendorId: event.vendorId);
      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        final bookingResponse = BookingResponse.fromJson(response.data);
        if (bookingResponse.status == 'success') {
          emit(BookingLoaded(bookings: bookingResponse.data));
        } else {
          emit(BookingError(message: 'Failed to load bookings: ${bookingResponse.status}'));
        }
      } else {
        emit(BookingError(message: '${response.message} (Status: ${response.statusCode})'));
      }
    } catch (e, s) {
      logger('Error fetching bookings: $e\nStackTrace: $s');
      emit(BookingError(message: 'Error fetching bookings: $e'));
    }
  }
}