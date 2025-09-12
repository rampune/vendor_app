import 'package:equatable/equatable.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object?> get props => [];
}

class FetchBookings extends BookingEvent {
  final String? vendorId;

  const FetchBookings({this.vendorId});

  @override
  List<Object?> get props => [vendorId];
}