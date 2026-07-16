
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/logger.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/local/secure_storage/secure_vendor_storage.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/common_widgets/yes_no_toggle_small.dart';
import 'package:new_pubup_partner/services/notification/notification_services.dart';
import '../../../config/common_functions.dart';
import '../../../config/routes.dart';
import '../../../config/theme.dart';
import '../../../services/lat_log_to_address.dart';
import '../../../services/location_service.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../bloc/save_details_bloc.dart';
import '../controller/admin_controller.dart';
import '../model/business_resister_model.dart';
import '../state_picker/select_city.dart';
import '../state_picker/select_state.dart';
import '../widget/custom_drop_down/custom_drop_down.dart';

class BusinessDetails extends StatefulWidget {
  const BusinessDetails({super.key});

  @override
  State<BusinessDetails> createState() => _BusinessDetailsState();
}

class _BusinessDetailsState extends State<BusinessDetails> {
  String? stateId;
  TextEditingController constitutionController = TextEditingController();
  SaveDetailsBloc saveDetailsBloc = SaveDetailsBloc();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  static BusinessData businessDataModel = BusinessData();
  bool manualLocationOff = true;

  // ── Features & Facilities ────────────────────────────────────────────────────
  static const List<String> _staticFacilities = [
    'Celebration Area',
    'Free Starter',
    'Dance Area',
    'Complimentary salads',
  ];

  final Map<String, bool> _selectedFacilities = {
    for (var f in _staticFacilities) f: false,
  };
  final List<String> _customFacilities = [];
  bool _showAddFacilityField = false;
  final TextEditingController _newFacilityController = TextEditingController();

  // ── Uniques ──────────────────────────────────────────────────────────────────
  final List<String> _uniquesList = [];

  // ─── Helpers ─────────────────────────────────────────────────────────────────
  List<String> get _selectedFacilitiesList =>
      _selectedFacilities.entries.where((e) => e.value).map((e) => e.key).toList();

  @override
  void initState() {
    final profile = BusinessProfileData.getProfilePhoneOrEmail();
    AdminController.emailController.text = profile.phoneOrEmail;
    // Also initialize phoneOrEmailController to avoid validation failure on first load
    AdminController.phoneOrEmailController.text = "";

    saveDetailsBloc.add(GetBusinessDetailsEvent(
        emailOrPhone: profile.phoneOrEmail));
    super.initState();
  }

  @override
  void dispose() {
    _newFacilityController.dispose();
    super.dispose();
  }

  // ─── GPS auto-fill ────────────────────────────────────────────────────────────
  Future<void> _fetchLocationFromGPS() async {
    OverlayLoadingProgress.start(context);
    try {
      Position? position =
          await LocationService().getPosition(context, timeoutSecond: 40);
      if (position == null) return;

      final lat = position.latitude;
      final lng = position.longitude;

      AdminController.latitudeController.text = lat.toString();
      AdminController.longitudeController.text = lng.toString();

      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng)
          .timeout(const Duration(seconds: 20), onTimeout: () => []);

      if (placemarks.isNotEmpty) {
        final p = placemarks.first;
        final formattedAddress = [
          p.name ?? p.street ?? '',
          p.subLocality ?? '',
        ].where((e) => e.isNotEmpty).join(', ');

        AdminController.addressController.text = formattedAddress;
        AdminController.cityController.text = p.locality ?? '';
        AdminController.stateController.text = p.administrativeArea ?? '';
        AdminController.pinController.text = p.postalCode ?? '';
      }
      setState(() {});
    } catch (e) {
      debugPrint("Error fetching location: $e");
    } finally {
      OverlayLoadingProgress.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder<SaveDetailsBloc, SaveDetailsState>(
            bloc: saveDetailsBloc,
            builder: (context, state) {
              if (state is SaveLoadingState) {
                return const CustomLoadingWidget();
              } else if (state is SaveBusinessDetailAlreadyFillState) {
                if (state.justSavedModel != null) {
                  SecureVendorStorage()
                      .saveBusinessProfile(state.justSavedModel!)
                      .then((_) {
                    showToast("Business details saved successfully!");
                  }).catchError((e) {
                    debugPrint("Failed to save locally: $e");
                  });
                }
                Future.delayed(const Duration(milliseconds: 200), () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.dashboardScreen,
                    (route) => false,
                  );
                });
                return const SizedBox.shrink();
              } else if (state is SaveDetailsFreshUserSuccessState) {
                return businessRegistrationView(state: state);
              } else if (state is SaveErrorState) {
                OverlayLoadingProgress.stop();
                return CustomErrorWidget(
                  msg: state.errorMsg,
                  retryCallBack: () {
                    saveDetailsBloc.add(GetBusinessDetailsEvent(
                      emailOrPhone: BusinessProfileData
                          .getProfilePhoneOrEmail()
                          .phoneOrEmail,
                    ));
                  },
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget businessRegistrationView(
      {required SaveDetailsFreshUserSuccessState state}) {
    TextEditingController countryController = TextEditingController();
    logger(
        "amra-0009\n\n\n${state.businessRegisterModel.toJson()}\n\n");
    businessDataModel.status =
        state.businessRegisterModel.businessData?.status ?? "pending";
    businessDataModel.id =
        state.businessRegisterModel.businessData?.id ?? 111;
    businessDataModel.phoneNo =
        state.businessRegisterModel.businessData?.phoneNo ?? "1234567890";
    businessDataModel.vendorId =
        state.businessRegisterModel.businessData?.vendorId;

    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Select the category you want to register",
                    style: context.titleLarge(),
                  ),
                  20.height(),

                  // ── Business Type ───────────────────────────────────────
                  CustomDropDown(
                    validator: (String? data) {
                      if (data?.isEmpty ?? true) {
                        return "Choose Business Type";
                      }
                    },
                    title: "Business Type",
                    controller: AdminController.vendorType,
                    listCustomDropDownModel: [
                      CustomDropDownModel(name: "Pub"),
                      CustomDropDownModel(name: "Cafe"),
                      CustomDropDownModel(name: "Fine Dinning"),
                    ],
                    heading: "Select Constitution",
                    onSelect: (CustomDropDownModel onSelect) {
                      setState(() {
                        AdminController.vendorType.text = onSelect.name;
                      });
                    },
                  ),
                  10.height(),

                  // ── Business Name ───────────────────────────────────────
                  CustomTextField(
                    textController: AdminController.businessNameController,
                    title: "Business Registration Name",
                    validator: (String? data) {
                      if ("$data".length < 4) {
                        return "Enter Valid Business Name";
                      }
                    },
                  ),
                  10.height(),

                  // ── Constitution ─────────────────────────────────────────
                  CustomDropDown(
                    validator: (String? data) {
                      if (data?.isEmpty ?? true) {
                        return "select constitution";
                      }
                    },
                    title: "Constitution",
                    controller: AdminController.constitutionController,
                    listCustomDropDownModel: [
                      CustomDropDownModel(name: "Proprietorship"),
                      CustomDropDownModel(name: "Partnership"),
                      CustomDropDownModel(name: "OPC"),
                      CustomDropDownModel(name: "Private Limited AOP"),
                      CustomDropDownModel(name: "BOI"),
                      CustomDropDownModel(name: "Any Other"),
                    ],
                    heading: "Select Constitution",
                    onSelect: (CustomDropDownModel onSelect) {
                      setState(() {
                        AdminController.constitutionController.text = onSelect.name;
                      });
                    },
                  ),
                  10.height(),

                  // ── Phone / Email ────────────────────────────────────────
                  CustomTextField(
                    isNumber:
                        !BusinessProfileData.getProfilePhoneOrEmail().isPhone,
                    textController: AdminController.phoneOrEmailController,
                    title: BusinessProfileData.getProfilePhoneOrEmail().isPhone
                        ? "Email Id"
                        : "Phone Number",
                    length:
                        BusinessProfileData.getProfilePhoneOrEmail().isPhone
                            ? 36
                            : 10,
                    validator: (String? data) {
                      if (BusinessProfileData.getProfilePhoneOrEmail()
                          .isPhone) {
                        if (!(data?.isValidEmail() ?? false)) {
                          return "Enter valid email id";
                        }
                      } else {
                        if (data?.length != 10) {
                          return "Enter valid phone number";
                        }
                      }
                    },
                  ),
                  10.height(),

                  CustomTextField(
                    textController: AdminController.emailController,
                    title: BusinessProfileData.getProfilePhoneOrEmail().isPhone
                        ? "phone no"
                        : "Email ID",
                  ),
                  10.height(),

                  // ── Website ──────────────────────────────────────────────
                  CustomTextField(
                    textController: AdminController.websiteController,
                    title: "Website",
                    validator: (String? data) {
                      if (data == null || data.trim().isEmpty) return null;
                      if (!"$data".isValidWebsite()) {
                        return "Enter valid website url";
                      }
                    },
                  ),
                  10.height(),

                  // ── Manual / GPS Location toggle ─────────────────────────
                  Row(
                    children: [
                      const Text("Enter Manual Location "),
                      10.width(),
                      OnOffToggleSmall(
                        isOff: manualLocationOff,
                        callBack: () {
                          setState(() {
                            manualLocationOff = !manualLocationOff;
                          });
                        },
                      ),
                    ],
                  ),
                  10.height(),

                  // ── GPS address field ────────────────────────────────────
                  if (manualLocationOff)
                    CustomTextField(
                      focusColor: AppColors.darkGray,
                      readOnly: true,
                      onTap: () async {
                        OverlayLoadingProgress.start(context);
                        try {
                          Position? position = await LocationService()
                              .getPosition(context, timeoutSecond: 40);
                          if (position == null) return;
                          final lat = position.latitude;
                          final lng = position.longitude;

                          // Save lat/lng
                          AdminController.latitudeController.text =
                              lat.toString();
                          AdminController.longitudeController.text =
                              lng.toString();

                          List<Placemark> placemarks =
                              await placemarkFromCoordinates(lat, lng).timeout(
                            const Duration(seconds: 20),
                            onTimeout: () => [],
                          );

                          if (placemarks.isNotEmpty) {
                            final p = placemarks.first;
                            final formattedAddress = [
                              p.name ?? p.street ?? 'Unknown',
                              p.subLocality ?? '',
                            ]
                                .where((e) => e.isNotEmpty)
                                .join(', ');
                            AdminController.addressController.text =
                                formattedAddress;
                            AdminController.cityController.text =
                                p.locality ?? '';
                            AdminController.stateController.text =
                                p.administrativeArea ?? '';
                            AdminController.pinController.text =
                                p.postalCode ?? '';
                          } else {
                            AdminController.addressController.text =
                                "Unable to fetch address";
                          }
                          setState(() {});
                        } catch (e) {
                          debugPrint("Error fetching address: $e");
                        } finally {
                          OverlayLoadingProgress.stop();
                        }
                      },
                      placeHolderText: "Select Location",
                      suffix: const Icon(Icons.arrow_drop_down_sharp),
                      textController: AdminController.addressController,
                      title: "Address",
                      validator: (String? data) {
                        if (data?.isEmpty ?? true) {
                          return "Please Select Address";
                        }
                        return null;
                      },
                    ),

                  // ── Manual address fields ────────────────────────────────
                  if (!manualLocationOff) ...[
                    10.height(),
                    CustomTextField(
                      textController: AdminController.addressController,
                      title: "Address",
                      validator: (String? data) {
                        if (data?.isEmpty ?? true) {
                          return "Enter valid Address";
                        }
                      },
                    ),
                    10.height(),
                    Row(
                      children: [
                        Expanded(
                          child: SelectState(
                            callBack: (String selected) {
                              setState(() {
                                stateId = selected;
                              });
                            },
                            controller: AdminController.stateController,
                            validator: (String? data) {
                              if (data?.isEmpty ?? true) {
                                return "Please choose State";
                              }
                            },
                          ),
                        ),
                        20.width(),
                        if (stateId != null)
                          Expanded(
                            child: SelectCity(
                              controller: AdminController.cityController,
                              stateId: stateId!,
                              validator: (String? data) {
                                if (data?.isEmpty ?? true) {
                                  return "Please choose city";
                                }
                              },
                              callBack: (String selectedItemCode) {},
                            ),
                          ),
                      ],
                    ),
                    10.height(),
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            textController: countryController,
                            title: "Country",
                            placeHolderText: "INDIA",
                            readOnly: true,
                          ),
                        ),
                        20.width(),
                        Expanded(
                          child: CustomTextField(
                            isNumber: true,
                            textController: AdminController.pinController,
                            title: "Pin Code",
                            length: 6,
                            validator: (String? data) {
                              if (data?.length != 6) {
                                return "Enter Valid Pin";
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                  10.height(),

                  // ── Latitude & Longitude ─────────────────────────────────
                  _buildLatLngSection(),
                  10.height(),

                  // ── Features & Facilities ────────────────────────────────
                  _buildFacilitiesSection(),
                  10.height(),

                  // ── Uniques ──────────────────────────────────────────────
                  _buildUniquesSection(),
                  10.height(),

                  // ── Food Type ──────────────────────────────────────────
                  CustomDropDown(
                    validator: (String? data) {
                      if (data?.isEmpty ?? true) {
                        return "select Food Type";
                      }
                      return null;
                    },
                    title: "Food Type",
                    controller: AdminController.foodTypeController,
                    listCustomDropDownModel: [
                      CustomDropDownModel(name: "Veg"),
                      CustomDropDownModel(name: "Non-Veg"),
                      CustomDropDownModel(name: "Both"),
                    ],
                    heading: "Select Food Type",
                    onSelect: (CustomDropDownModel onSelect) {
                      setState(() {
                        AdminController.foodTypeController.text = onSelect.name;
                      });
                    },
                  ),
                  10.height(),
                ],
              ),
            ),
          ),
        ),

        // ── Submit ────────────────────────────────────────────────────────────
        CustomButton(
          buttonText: "Submit",
          onPress: () {
            hideKeyboard();
            if (!(formKey.currentState?.validate() ?? false)) {
              showAlert(context, "Please Enter valid data");
              return;
            }
            businessDataModel.businessType = AdminController.vendorType.text;
            businessDataModel.businessRegistrationName =
                AdminController.businessNameController.text;
            businessDataModel.constitution =
                AdminController.constitutionController.text;

            BusinessProfileData.getProfilePhoneOrEmail().isPhone
                ? businessDataModel.email =
                    AdminController.phoneOrEmailController.text
                : businessDataModel.phoneNo =
                    AdminController.phoneOrEmailController.text;
            businessDataModel.website = AdminController.websiteController.text;
            businessDataModel.address = AdminController.addressController.text;
            businessDataModel.state = AdminController.stateController.text;
            businessDataModel.city = AdminController.cityController.text;
            businessDataModel.pinCode = AdminController.pinController.text;
            businessDataModel.country = "INDIA";
            businessDataModel.deviceToken =
                SendNotification.tokenForMessages ?? "";

            // ── New fields ──────────────────────────────────────────────────
            businessDataModel.latitude =
                AdminController.latitudeController.text.trim().isEmpty
                    ? null
                    : AdminController.latitudeController.text.trim();
            businessDataModel.longitude =
                AdminController.longitudeController.text.trim().isEmpty
                    ? null
                    : AdminController.longitudeController.text.trim();
            businessDataModel.featuresFacilities = _selectedFacilitiesList;
            businessDataModel.uniques = List.from(_uniquesList);

            businessDataModel.foodType =
                AdminController.foodTypeController.text;
            logger(
                "Submitting with FCM Token: ${businessDataModel.deviceToken}");
            saveDetailsBloc.add(SaveBusinessDetailsEvent(
              businessData: businessDataModel,
              vendorId: businessDataModel.vendorId ?? "",
            ));
          },
        ),
        10.height(),
      ],
    );
  }

  // ─── Lat / Lng Section ───────────────────────────────────────────────────────
  Widget _buildLatLngSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Location Coordinates",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        8.height(),
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                textController: AdminController.latitudeController,
                title: "Latitude",
                placeHolderText: "e.g. 28.6139",
                isNumber: false,
              ),
            ),
            12.width(),
            Expanded(
              child: CustomTextField(
                textController: AdminController.longitudeController,
                title: "Longitude",
                placeHolderText: "e.g. 77.2090",
                isNumber: false,
              ),
            ),
          ],
        ),
        8.height(),
        // "Use My Location" button to auto-fill lat/lng from GPS
        GestureDetector(
          onTap: _fetchLocationFromGPS,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade400),
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.my_location, size: 15,
                    color: Colors.grey.shade700),
                const SizedBox(width: 5),
                Text(
                  "Use My Location (auto-fill)",
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ─── Features & Facilities Section ───────────────────────────────────────────
  Widget _buildFacilitiesSection() {
    final allFacilities = [..._staticFacilities, ..._customFacilities];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Features & Facilities",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        8.height(),

        // Selectable chips
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allFacilities.map((facility) {
            final isSelected = _selectedFacilities[facility] ?? false;
            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedFacilities[facility] = !isSelected;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.black : Colors.transparent,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.black
                        : Colors.grey.shade400,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSelected) ...[
                      const Icon(Icons.check,
                          size: 14, color: Colors.white),
                      const SizedBox(width: 4),
                    ],
                    Text(
                      facility,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: isSelected
                            ? Colors.white
                            : Colors.grey.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        12.height(),

        // Inline add-facility input
        if (_showAddFacilityField) ...[
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _newFacilityController,
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  style: const TextStyle(fontSize: 14, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "Enter facility name…",
                    hintStyle: TextStyle(
                        color: Colors.grey.shade400, fontSize: 13),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    isDense: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide:
                          BorderSide(color: Colors.grey.shade400),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                          color: AppColors.black, width: 1.5),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 11),
                ),
                onPressed: () {
                  final val = _newFacilityController.text.trim();
                  if (val.isEmpty) {
                    showToast("Please enter a facility name");
                    return;
                  }
                  if (_selectedFacilities.containsKey(val)) {
                    showToast("Facility already exists");
                    return;
                  }
                  setState(() {
                    _customFacilities.add(val);
                    _selectedFacilities[val] = true;
                    _newFacilityController.clear();
                    _showAddFacilityField = false;
                  });
                },
                child: const Text("Add", style: TextStyle(fontSize: 13)),
              ),
              const SizedBox(width: 4),
              IconButton(
                onPressed: () {
                  setState(() {
                    _newFacilityController.clear();
                    _showAddFacilityField = false;
                  });
                },
                icon: const Icon(Icons.close, size: 18),
                color: Colors.grey.shade600,
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
              ),
            ],
          ),
          10.height(),
        ],

        // "Add New Facilities" button
        if (!_showAddFacilityField)
          GestureDetector(
            onTap: () {
              setState(() {
                _showAddFacilityField = true;
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                  horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade400),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.add, size: 16, color: Colors.grey.shade700),
                  const SizedBox(width: 4),
                  Text(
                    "Add New Facilities",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
  // ─── Uniques Section ─────────────────────────────────────────────────────────
  Widget _buildUniquesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Uniques",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey.shade700,
          ),
        ),
        8.height(),

        // Input + Add button in a row
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: AdminController.uniqueEntryController,
                textCapitalization: TextCapitalization.sentences,
                style: const TextStyle(fontSize: 14, color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Type a unique feature…",
                  hintStyle: TextStyle(
                      color: Colors.grey.shade400, fontSize: 13),
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 14, vertical: 10),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.grey.shade400),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: AppColors.black, width: 1.5),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 11),
              ),
              onPressed: () {
                final val =
                    AdminController.uniqueEntryController.text.trim();
                if (val.isEmpty) {
                  showToast("Please type something first");
                  return;
                }
                setState(() {
                  _uniquesList.add(val);
                  AdminController.uniqueEntryController.clear();
                });
              },
              child: const Text("Add", style: TextStyle(fontSize: 13)),
            ),
          ],
        ),
        10.height(),

        // Added uniques shown as removable chips
        if (_uniquesList.isNotEmpty)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _uniquesList.asMap().entries.map((entry) {
              return Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.black,
                  border: Border.all(
                    color: AppColors.black,
                    width: 1.5,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 6),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _uniquesList.removeAt(entry.key);
                        });
                      },
                      child: const Icon(
                        Icons.close,
                        size: 15,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
      ],
    );
  }
}
