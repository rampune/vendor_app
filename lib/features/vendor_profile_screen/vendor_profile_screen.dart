import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import 'package:new_pubup_partner/features/vendor_profile_screen/state/vendor_all_details_state.dart';

import 'bloc/vendor_all_details_bloc.dart';
import 'event/vendor_all_details_event.dart';

class VendorProfileScreen extends StatelessWidget {
  String vendorId;
VendorProfileScreen({super.key,required this.vendorId});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
        create: (context) => VendorAllDetailsBloc()..add(FetchVendorAllDetailsEvent(vendorId: vendorId)),

      child:Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
        ),
      ),

        body: BlocBuilder<VendorAllDetailsBloc, VendorAllDetailsState>(
          builder: (context, state) {
            if (state is VendorAllDetailsLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VendorAllDetailsErrorState) {
              return Center(child: Text(state.errorMsg));
            } else if (state is VendorAllDetailsSuccessState) {
              final vendor = state.vendorAllDetailsData;

             return ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 24, // Adjust size as needed
                        child: vendor.vendorDetails?.logo != null &&
                            vendor.vendorDetails!.logo!.isNotEmpty
                            ? ClipOval(
                          child: Image.network(
                            '${EndPoints.baseUrl}${vendor.vendorDetails!.logo!}',
                            fit: BoxFit.cover,
                            width: 48, // Match CircleAvatar size
                            height: 48,
                            errorBuilder: (context, error, stackTrace) {
                              // Fallback for invalid or failed image load
                              return const Icon(
                                Icons.store,
                                color: Colors.white,
                                size: 24,
                              );
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return const CircularProgressIndicator(
                                strokeWidth: 2,
                              );
                            },
                          ),
                        )
                            : const Icon(
                          Icons.store,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      title: Text(
                        vendor.businessRegistrationName ?? 'Unknown Business',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(vendor.phoneNo ?? 'No phone number'),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("About"),
                      subtitle: Text(
                        vendor.vendorDetails?.pubCafeFineDinningDescription != null &&
                            vendor.vendorDetails!.pubCafeFineDinningDescription!.length > 150
                            ? '${vendor.vendorDetails!.pubCafeFineDinningDescription!.substring(0, 150)}...'
                            : vendor.vendorDetails?.pubCafeFineDinningDescription ?? 'No description',
                      ),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                      //   onPressed: () {},
                      // ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Owner E-Mail ID"),
                      subtitle:  Text(vendor.email!),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                      //   onPressed: () {},
                      // ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Website"),
                      subtitle:  Text(vendor.website!),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                      //   onPressed: () {},
                      // ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Operational Hours"),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                      //   onPressed: () {},
                      // ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Menu"),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                      //   onPressed: () {},
                      // ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Gallery"),
                      // trailing: IconButton(
                      //   icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                      //   onPressed: () {},
                      // ),
                    ),
                    const Divider(),

                    const SizedBox(height: 20),



                    CustomButton(buttonText: 'Logout', onPress: (){

                    })
                  ],
                );
              }
            return Container(); // Default case
          },
        ),

    )

    );

  }
}
