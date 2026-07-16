import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/routes.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/vendor_profile_screen/state/vendor_all_details_state.dart';
import 'package:new_pubup_partner/utils/pickers/pickers.dart';

import 'bloc/vendor_all_details_bloc.dart';
import 'event/vendor_all_details_event.dart';

class VendorProfileScreen extends StatelessWidget {
  final String vendorId;
  VendorProfileScreen({super.key,required this.vendorId});

  Future<void> _updateBusinessPhoto(BuildContext context, String vendorId) async {
    AppPickers.showFilePickerOption(context, (File? file) async {
      if (file == null) return;

      OverlayLoadingProgress.start(context);
      try {
        final client = DioClient(baseUrl: EndPoints.baseUrl);
        final result = await client.patchMultipartData(
          listUploadModel: [
            ImageUploadModel(file: file, fileName: 'business_photo'),
          ],
          mapData: {},
          vendorId: vendorId,
          endPoint: 'vendor_details',
        );

        OverlayLoadingProgress.stop();
        if (result != null && (result.statusCode == 200 || result.statusCode == 201)) {
          showToast("Business photo updated successfully");
          if (context.mounted) {
            context.read<VendorAllDetailsBloc>().add(FetchVendorAllDetailsEvent(vendorId: vendorId));
          }
        } else {
          showToast("Failed to update business photo: ${result?.message ?? 'Unknown error'}");
        }
      } catch (e) {
        OverlayLoadingProgress.stop();
        showToast("Error updating business photo: $e");
      }
    });
  }

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
                      leading: GestureDetector(
                        onTap: () {
                          if (vendor.vendorId != null && vendor.vendorId!.isNotEmpty) {
                            _updateBusinessPhoto(context, vendor.vendorId!);
                          } else if (vendorId.isNotEmpty) {
                            _updateBusinessPhoto(context, vendorId);
                          } else {
                            showToast("Vendor ID not found");
                          }
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.grey,
                              radius: 24, // Adjust size as needed
                              child: vendor.vendorDetails?.businessPhoto != null &&
                                      vendor.vendorDetails!.businessPhoto!.isNotEmpty
                                  ? ClipOval(
                                      child: Image.network(
                                        '${EndPoints.baseUrl}${vendor.vendorDetails!.businessPhoto!}',
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
                            Positioned(
                              bottom: -2,
                              right: -2,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.themeColor,
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white, width: 1.5),
                                ),
                                child: const Icon(
                                  Icons.camera_alt,
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      title: Text(
                        vendor.vendorDetails?.pubCafeFineDinningName ?? vendor.businessRegistrationName ?? 'Unknown Business',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(vendor.phoneNo ?? 'No phone number'),
                      trailing: IconButton(
                        icon: const Icon(Icons.edit_outlined),
                        onPressed: () async {
                          await Navigator.pushNamed(
                            context,
                            AppRoutes.editProfile,
                            arguments: {
                              'fieldName': 'Pub/Cafe/Fine-Dine Name',
                              'initialValue': vendor.vendorDetails?.pubCafeFineDinningName ?? vendor.businessRegistrationName ?? ''
                            },
                          );
                          if (context.mounted) {
                            context.read<VendorAllDetailsBloc>().add(FetchVendorAllDetailsEvent(vendorId: vendorId));
                          }
                        },
                      ),
                    ),
                    const Divider(),
                    AboutSectionTile(
                      description: vendor.vendorDetails?.pubCafeFineDinningDescription ?? '',
                      onEditTap: () async {
                        await Navigator.pushNamed(
                          context,
                          AppRoutes.editProfile,
                          arguments: {
                            'fieldName': 'About',
                            'initialValue': vendor.vendorDetails?.pubCafeFineDinningDescription ?? ''
                          },
                        );
                        if (context.mounted) {
                          context.read<VendorAllDetailsBloc>().add(FetchVendorAllDetailsEvent(vendorId: vendorId));
                        }
                      },
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

class AboutSectionTile extends StatefulWidget {
  final String description;
  final VoidCallback onEditTap;

  const AboutSectionTile({
    super.key,
    required this.description,
    required this.onEditTap,
  });

  @override
  State<AboutSectionTile> createState() => _AboutSectionTileState();
}

class _AboutSectionTileState extends State<AboutSectionTile> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final hasLongDesc = widget.description.length > 150;
    final displayText = hasLongDesc && !_isExpanded
        ? '${widget.description.substring(0, 150)}...'
        : widget.description;

    return ListTile(
      title: Row(
        children: [
          const Text("About"),
          const Spacer(),
          GestureDetector(
            onTap: widget.onEditTap,
            child: const Icon(Icons.edit_outlined),
          )
        ],
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text(
            displayText.isEmpty ? 'No description' : displayText,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              height: 1.4,
            ),
          ),
          if (hasLongDesc) ...[
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                setState(() {
                  _isExpanded = !_isExpanded;
                });
              },
              child: Text(
                _isExpanded ? "See Less" : "See More",
                style: TextStyle(
                  color: AppColors.themeColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
