import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:new_pubup_partner/features/all_bookings/bloc/booking_bloc.dart';
import 'package:new_pubup_partner/features/all_bookings/event/booking_events.dart';
import 'package:new_pubup_partner/features/all_bookings/state/booking_state.dart';
import 'package:new_pubup_partner/features/all_bookings/widgets/booking_card_widget.dart';

class AllBookings extends StatelessWidget {
  final String vendorId;

  const AllBookings({super.key, required this.vendorId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookingBloc()..add(FetchBookings(vendorId: vendorId)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Bookings"),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<BookingBloc>().add(FetchBookings(vendorId: vendorId));
          },
          child: BlocBuilder<BookingBloc, BookingState>(
            builder: (context, state) {
              if (state is BookingLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is BookingError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Error: ${state.message}'),
                      ElevatedButton(
                        onPressed: () {
                          context.read<BookingBloc>().add(FetchBookings(vendorId: vendorId));
                        },
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                );
              } else if (state is BookingLoaded && state.bookings.isEmpty) {
                return const Center(child: Text('No bookings found'));
              } else if (state is BookingLoaded) {
                final bookings = state.bookings;
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: bookings.length,
                  itemBuilder: (context, index) {
                    final booking = bookings[index];
                    return BookingCardWidget(booking: booking);
                  },
                );
              }
              return const Center(child: Text('Please wait...'));
            },
          ),
        ),
      ),
    );
  }
}
