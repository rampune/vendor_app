import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
import 'package:new_pubup_partner/features/all_bookings/model/booking_model.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';

class BookingDetailsScreen extends StatelessWidget {
  final BookingData booking;

  const BookingDetailsScreen({super.key, required this.booking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Custom AppBar with gradient background
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Booking #${booking.bookingId}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              background: Container(
                decoration:  BoxDecoration(
                  gradient: LinearGradient(
                    colors: [AppColors.themeColor, Colors.tealAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Hero(
                    tag: 'booking-${booking.bookingId}',
                    child: Icon(
                      Icons.event_available,
                      size: 80,
                      color: Colors.white.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: AppColors.themeColor,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          // Main content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Booking Details Card
                  _buildSectionCard(
                    title: 'Booking Details',
                    children: [
                      _buildDetailRow(
                        icon: Icons.confirmation_number,
                        label: 'Booking ID',
                        value: booking.bookingId,
                      ),
                      _buildDetailRow(
                        icon: Icons.calendar_today,
                        label: 'Date',
                        value: booking.bookingDate,
                      ),
                      _buildDetailRow(
                        icon: Icons.today,
                        label: 'Day',
                        value: booking.bookingDay,
                      ),
                      // _buildDetailRow(
                      //   icon: Icons.group,
                      //   label: 'Guests',
                      //   value: booking.guestCount.toString(),
                      // ),
                      // _buildDetailRow(
                      //   icon: Icons.monetization_on,
                      //   label: 'Amount Paid',
                      //   value: '₹${booking.amountPaid}',
                      // ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Vendor Details Card
                  _buildSectionCard(
                    title: 'Vendor Details',
                    children: [
                      _buildDetailRow(
                        icon: Icons.store,
                        label: 'Name',
                        value: booking.vendorData.businessRegistrationName,
                      ),
                      _buildDetailRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: booking.vendorData.phoneNo ?? 'N/A',
                      ),
                      _buildDetailRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: booking.vendorData.email ?? 'N/A',
                      ),
                      // if (booking.vendorData.logo != null &&
                      //     booking.vendorData.logo!.isNotEmpty)
                      //   _buildImageRow(
                      //     label: 'Logo',
                      //     imageUrl:
                      //     '${EndPoints.baseUrl}${booking.vendorData.logo}',
                      //   ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // User Details Card
                  _buildSectionCard(
                    title: 'Guest Details',
                    children: [
                      _buildDetailRow(
                        icon: Icons.person,
                        label: 'Name',
                        value: booking.userData.name,
                      ),
                      _buildDetailRow(
                        icon: Icons.phone,
                        label: 'Phone',
                        value: booking.userData.mobileNo ?? 'N/A',
                      ),
                      _buildDetailRow(
                        icon: Icons.email,
                        label: 'Email',
                        value: booking.userData.email ?? 'N/A',
                      ),
                      if (booking.userData.image != null &&
                          booking.userData.image!.isNotEmpty)
                        _buildImageRow(
                          label: 'Profile Image',
                          imageUrl:
                          '${EndPoints.baseUrl}${booking.userData.image}',
                        ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // Action Button
                  Center(
                    child: CustomButton(
                      buttonText: 'Contact Guest',
                      onPress: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Contacting ${booking.userData.name} at ${booking.userData.mobileNo?? 'N/A'}',
                            ),
                          ),
                        );
                      },

                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for section cards
  Widget _buildSectionCard(
      {required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  // Helper widget for detail rows
  Widget _buildDetailRow(
      {required IconData icon, required String label, required String value}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.teal, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isNotEmpty ? value : 'N/A',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper widget for image rows
  Widget _buildImageRow({required String label, required String imageUrl}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 50,
                color: Colors.grey,
              ),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }
}