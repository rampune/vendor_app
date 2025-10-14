// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import 'package:new_pubup_partner/features/all_bookings/bloc/booking_bloc.dart';
// import 'package:new_pubup_partner/features/all_bookings/event/booking_events.dart';
// import 'package:new_pubup_partner/features/all_bookings/state/booking_state.dart';
// import 'package:new_pubup_partner/features/all_bookings/widgets/booking_card_widget.dart';
//
// class AllBookings extends StatelessWidget {
//   final String vendorId;
//
//   const AllBookings({super.key, required this.vendorId});
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => BookingBloc()..add(FetchBookings(vendorId: vendorId)),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("All Bookings"),
//         ),
//         body: RefreshIndicator(
//           onRefresh: () async {
//             context.read<BookingBloc>().add(FetchBookings(vendorId: vendorId));
//           },
//           child: BlocBuilder<BookingBloc, BookingState>(
//             builder: (context, state) {
//               if (state is BookingLoading) {
//                 return const Center(child: CircularProgressIndicator());
//               } else if (state is BookingError) {
//                 return Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Error: ${state.message}'),
//                       ElevatedButton(
//                         onPressed: () {
//                           context.read<BookingBloc>().add(FetchBookings(vendorId: vendorId));
//                         },
//                         child: const Text('Retry'),
//                       ),
//                     ],
//                   ),
//                 );
//               } else if (state is BookingLoaded && state.bookings.isEmpty) {
//                 return const Center(child: Text('No bookings found'));
//               } else if (state is BookingLoaded) {
//                 final bookings = state.bookings;
//                 return ListView.builder(
//                   padding: const EdgeInsets.all(16.0),
//                   itemCount: bookings.length,
//                   itemBuilder: (context, index) {
//                     final booking = bookings[index];
//                     return BookingCardWidget(booking: booking);
//                   },
//                 );
//               }
//               return const Center(child: Text('Please wait...'));
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }







// Updated AllBookings screen
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/all_bookings/bloc/booking_bloc.dart';
import 'package:new_pubup_partner/features/all_bookings/bloc/event_booking_bloc.dart';
import 'package:new_pubup_partner/features/all_bookings/event/booking_events.dart';
import 'package:new_pubup_partner/features/all_bookings/event/event_booking_event.dart';
import 'package:new_pubup_partner/features/all_bookings/model/event_booking_model.dart';
import 'package:new_pubup_partner/features/all_bookings/state/booking_state.dart';
import 'package:new_pubup_partner/features/all_bookings/state/event_booking_state.dart';
import 'package:new_pubup_partner/features/all_bookings/widgets/booking_card_widget.dart';


class AllBookings extends StatefulWidget {
  final String vendorId;

  const AllBookings({super.key, required this.vendorId});

  @override
  State<AllBookings> createState() => _AllBookingsState();
}

class _AllBookingsState extends State<AllBookings> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => BookingBloc()..add(FetchBookings(vendorId: widget.vendorId)),
        ),
        BlocProvider(
          create: (context) => EventBookingBloc()..add(FetchEventBookings(vendorId: widget.vendorId)),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text("All Bookings"),
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(text: "Table Booking"),
              Tab(text: "Ticket Booking"),
              Tab(text: "Fine Dine"),
            ],
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () async {
            context.read<BookingBloc>().add(FetchBookings(vendorId: widget.vendorId));
            context.read<EventBookingBloc>().add(FetchEventBookings(vendorId: widget.vendorId));
          },
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildTableBookingsTab(),
              _buildTicketBookingsTab(),
              _buildFineDineTab(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableBookingsTab() {
    return BlocBuilder<EventBookingBloc, EventBookingState>(
      builder: (context, state) {
        if (state is EventBookingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EventBookingError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<EventBookingBloc>().add(FetchEventBookings(vendorId: widget.vendorId));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is EventBookingLoaded) {
          final tableBookings = state.bookings.where((booking) => booking.bookingType == 'Table Booking').toList();
          if (tableBookings.isEmpty) {
            return const Center(child: Text('No table bookings found'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: tableBookings.length,
            itemBuilder: (context, index) {
              final booking = tableBookings[index];
              return EventBookingCardWidget(booking: booking); // Adjust widget as needed
            },
          );
        }
        return const Center(child: Text('Please wait...'));
      },
    );
  }

  Widget _buildTicketBookingsTab() {
    return BlocBuilder<EventBookingBloc, EventBookingState>(
      builder: (context, state) {
        if (state is EventBookingLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EventBookingError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: ${state.message}'),
                ElevatedButton(
                  onPressed: () {
                    context.read<EventBookingBloc>().add(FetchEventBookings(vendorId: widget.vendorId));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is EventBookingLoaded) {
          final ticketBookings = state.bookings.where((booking) => booking.bookingType == 'Ticket Booking').toList();
          if (ticketBookings.isEmpty) {
            return const Center(child: Text('No ticket bookings found'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: ticketBookings.length,
            itemBuilder: (context, index) {
              final booking = ticketBookings[index];
              return EventBookingCardWidget(booking: booking); // Adjust widget as needed
            },
          );
        }
        return const Center(child: Text('Please wait...'));
      },
    );
  }

  Widget _buildFineDineTab() {
    return BlocBuilder<BookingBloc, BookingState>(
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
                    context.read<BookingBloc>().add(FetchBookings(vendorId: widget.vendorId));
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        } else if (state is BookingLoaded && state.bookings.isEmpty) {
          return const Center(child: Text('No fine dine bookings found'));
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
    );
  }
}



class EventBookingCardWidget extends StatelessWidget {
  final EventBookingModel booking;

  const EventBookingCardWidget({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Booking Type
            Row(
              children: [
                Icon(
                  booking.bookingType?.toLowerCase().contains('table') == true
                      ? Icons.table_restaurant
                      : Icons.confirmation_number,
                  color: Colors.orange,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  booking.bookingType ?? 'Booking',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            // Date and Time
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Date: ${booking.bookingDate ?? ''} (${booking.bookingDay ?? ''})'),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.access_time, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Time: ${booking.bookingTime ?? ''}'),
              ],
            ),
            const SizedBox(height: 8),
            // Guest Count
            Row(
              children: [
                const Icon(Icons.people, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Guests: ${booking.guestCount ?? 0}'),
              ],
            ),
            const SizedBox(height: 8),
            // Amount
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Amount: '),
                Text(
                  '₹${booking.amountPaid ?? 0}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            // User Info
            Row(
              children: [
                const Icon(Icons.person, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'User ID: ${booking.userData.id ?? 'N/A'}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
            // Event ID
            Row(
              children: [
                const Icon(Icons.event, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Text('Event: ${booking.eventData.eventName ?? 'N/A'}'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}