import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.yellow[700], // Matches the yellow app bar
        actions: [
          IconButton(
            icon: const Icon(Icons.person, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),

      // body: ListView(
      //   padding: const EdgeInsets.all(16.0),
      //   children: [
      //     ListTile(
      //       leading: const CircleAvatar(
      //         backgroundColor: Colors.grey,
      //         child: Icon(Icons.person, color: Colors.white),
      //       ),
      //       title: const Text(
      //         "Maxgen Pvt. Ltd.",
      //         style: TextStyle(fontWeight: FontWeight.bold),
      //       ),
      //       subtitle: const Text("+91 9879722455"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.edit, color: Colors.blue),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text("About"),
      //       subtitle: const Text("A cozy pub & cafe with good ambiance"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text("Owner E-Mail ID"),
      //       subtitle: const Text("komalmagen@gmail.com"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text("Website"),
      //       subtitle: const Text("www.maxgenttechnologies.com"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text("Operational Hours"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text("Menu"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text("Gallery"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text("About PubUp"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text("Privacy Policy"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const Divider(),
      //     ListTile(
      //       title: const Text("Term & Conditions"),
      //       trailing: IconButton(
      //         icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
      //         onPressed: () {},
      //       ),
      //     ),
      //     const SizedBox(height: 20),
      //
      //
      //
      //     CustomButton(buttonText: 'Logout', onPress: (){
      //
      //     })
      //   ],
      // ),





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
                      leading: const CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                      title:  Text(
                        vendor.businessRegistrationName!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(vendor.phoneNo!),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("About"),
                      subtitle:  Text(vendor.vendorDetails?.pubCafeFineDinningDescription ?? ''),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Owner E-Mail ID"),
                      subtitle:  Text(vendor.email!),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Website"),
                      subtitle:  Text(vendor.website!),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Operational Hours"),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Menu"),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Gallery"),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("About PubUp"),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Privacy Policy"),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                        onPressed: () {},
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      title: const Text("Term & Conditions"),
                      trailing: IconButton(
                        icon: const Icon(Icons.arrow_forward_ios, color: Colors.blue, size: 16),
                        onPressed: () {},
                      ),
                    ),
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
