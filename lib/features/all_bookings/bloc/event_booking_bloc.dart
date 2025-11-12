// bloc/event_booking_bloc.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/all_bookings/event/event_booking_event.dart';
import 'package:new_pubup_partner/features/all_bookings/model/event_booking_model.dart';
import 'package:new_pubup_partner/features/all_bookings/repository/event_booking_repository.dart';
import 'package:new_pubup_partner/features/all_bookings/repository/refund_repository.dart';
import 'package:new_pubup_partner/features/all_bookings/state/event_booking_state.dart';


class EventBookingBloc extends Bloc<EventBookingEvent, EventBookingState> {
  final EventBookingRepository repository = EventBookingRepository();
  final RefundRepository refundRepository = RefundRepository();

  EventBookingBloc() : super(EventBookingInitial()) {
    on<FetchEventBookings>(_onFetchEventBookings);
    on<CancelEventBooking>(_onCancelEventBooking);
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






  // Future<void> _onCancelEventBooking(CancelEventBooking event, Emitter<EventBookingState> emit) async {
  //   if (state is! EventBookingLoaded) {
  //     emit(EventBookingError('No bookings loaded'));
  //     return;
  //   }
  //
  //   final currentLoadedState = state as EventBookingLoaded;
  //   final currentBookings = List<EventBookingModel>.from(currentLoadedState.bookings);
  //
  //   emit(EventBookingLoading());
  //
  //   try {
  //     await repository.cancelEventBooking(event.bookingId);
  //
  //     // Local update: Find and update the booking status
  //     final updatedBookings = currentBookings.map((booking) {
  //       if (booking.id == event.bookingId) {
  //         // Create a new instance with updated status
  //         return EventBookingModel(
  //           id: booking.id,
  //           vendorData: booking.vendorData,
  //           userData: booking.userData,
  //           eventData: booking.eventData,
  //           bookingDate: booking.bookingDate,
  //           bookingDay: booking.bookingDay,
  //           bookingType: booking.bookingType,
  //           bookingTime: booking.bookingTime,
  //           guestCount: booking.guestCount,
  //           amountPaid: booking.amountPaid,
  //           bookingStatus: 'cancelled', // Set to cancelled
  //         );
  //       }
  //       return booking;
  //     }).toList();
  //
  //     // Emit updated state to keep the booking in the list with new status
  //     emit(EventBookingLoaded(updatedBookings));
  //
  //     // Optionally refetch to sync with backend (if backend includes cancelled bookings)
  //     // final response = await repository.fetchEventBookingsByVendor(event.vendorId);
  //     // if (response?.status == 'success' && response?.data != null) {
  //     //   emit(EventBookingLoaded(response!.data!));
  //     // }
  //
  //   } catch (e) {
  //     // Revert to previous state on error
  //     emit(currentLoadedState);
  //     emit(EventBookingError(e.toString()));
  //   }
  // }



  Future<void> _onCancelEventBooking(CancelEventBooking event, Emitter<EventBookingState> emit) async {
    if (state is! EventBookingLoaded) {
      emit(EventBookingError('No bookings loaded'));
      return;
    }

    final currentLoadedState = state as EventBookingLoaded;
    final currentBookings = List<EventBookingModel>.from(currentLoadedState.bookings);

    emit(EventBookingLoading());

    try {
      // Step 1: Cancel the booking
      await repository.cancelEventBooking(event.bookingId);

      // Step 2: Process the refund
      await refundRepository.processRefund(event.userId, event.bookingId, event.refundAmount);


      // Step 3: Local update: Find and update the booking status
      final updatedBookings = currentBookings.map((booking) {
        if (booking.id == event.bookingId) {
          // Create a new instance with updated status
          return EventBookingModel(
            id: booking.id,
            vendorData: booking.vendorData,
            userData: booking.userData,
            eventData: booking.eventData,
            bookingDate: booking.bookingDate,
            bookingDay: booking.bookingDay,
            bookingType: booking.bookingType,
            bookingTime: booking.bookingTime,
            guestCount: booking.guestCount,
            amountPaid: booking.amountPaid,
            bookingStatus: 'cancelled', // Set to cancelled
          );
        }
        return booking;
      }).toList();

      // Emit updated state to keep the booking in the list with new status
      emit(EventBookingLoaded(updatedBookings));

    } catch (e) {
      // Revert to previous state on error (either cancel or refund failed)
      emit(currentLoadedState);
      emit(EventBookingError(e.toString()));
    }
  }
}