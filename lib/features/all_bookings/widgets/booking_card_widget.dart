
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/features/all_bookings/booking_details_screen.dart';
import 'package:new_pubup_partner/features/all_bookings/model/booking_model.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';

class BookingCardWidget extends StatelessWidget {
  final BookingData booking;

  const BookingCardWidget({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  booking.vendorData.businessRegistrationName,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,

                  ),
                ),
                Chip(
                  label: Text(
                    booking.bookingDay,

                  ),
                  backgroundColor: AppColors.themeColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Booking ID: ${booking.bookingId}',
              style: const TextStyle(fontSize: 16, ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.person, ),
                const SizedBox(width: 8),
                Text(
                  'Guest: ${booking.userData.name}',
                  style: const TextStyle(fontSize: 16,),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.group,),
                const SizedBox(width: 8),
                Text(
                  'Guests: ${booking.guestCount}',
                  style: const TextStyle(fontSize: 16,),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.monetization_on,),
                const SizedBox(width: 8),
                Text(
                  'Amount Paid: ₹${booking.amountPaid}',
                  style: const TextStyle(fontSize: 16,),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today,),
                const SizedBox(width: 8),
                Text(
                  'Date: ${booking.bookingDate}',
                  style: const TextStyle(fontSize: 16,),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: CustomButton(
                buttonText: 'View Details',
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingDetailsScreen(booking: booking),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}