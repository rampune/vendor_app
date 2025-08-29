
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/features/business_hours/model/business_hour_model.dart';
import 'package:new_pubup_partner/features/business_hours/utils.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/bottom_sheet_button.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/slot_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import '../../../config/theme.dart';
import '../bloc/business_hour_bloc.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({
    super.key,
    required this.businessHourBloc,
    required this.day,
    this.isOpen,
    this.isPostRequest = false,
    this.slotTime, // Existing slot time (e.g., "11:00 - 23:00")
    this.isEditMode = false, // True for editing slot, false for toggling isOpen
  });

  final BusinessHourBloc businessHourBloc;
  final String day;
  final bool? isOpen;
  final bool isPostRequest;
  final String? slotTime;
  final bool isEditMode; // True for editing slot, false for toggling isOpen

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  bool applyToAllDays = false; // State for the checkbox

  @override
  void initState() {
    BusinessHourUtils.clearSlot(); // Clear any existing slot
    // Pre-populate controllers with existing slot time if available
    if (widget.slotTime != null) {
      try {
        var times = widget.slotTime!.split('-').map((e) => e.trim()).toList();
        if (times.length == 2) {
          startTimeController.text = times[0];
          endTimeController.text = times[1];
        }
      } catch (e) {
        debugPrint('Error parsing slotTime: $e');
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    startTimeController.dispose();
    endTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isOpen ?? false
        ? Column( // Use Column to stack "Off" button and editing section
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!widget.isEditMode) // Show "Off" section only if not in edit mode
          SafeArea(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomButton(
                    buttonColor: AppColors.redLight,
                    buttonText: "Off on ${widget.day}",
                    onPress: () {
                      BusinessHourData hourModel = BusinessHourData(
                        vendorData: BusinessProfileData.vendorId() ?? "",
                        operationalTime: [
                          OperationalTime(
                            day: widget.day,
                            isopen: false,
                            slot: null, // No slot when closed
                          ),
                        ],
                      );
                      widget.businessHourBloc.add(
                        BusinessHourPatchEvent(businessHourData: hourModel),
                      );
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        // Always show the editing section when isOpen is true

        if (widget.isEditMode)
          Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(10),
              topLeft: Radius.circular(10),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.day,
                      style: context.titleSmall()?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close, color: AppColors.redLight),
                    ),
                  ],
                ),
                Divider(),
                10.height(),
                SlotWidget(
                  startTimeController: startTimeController,
                  endTimeController: endTimeController,
                  timeGapInMinute: 10,
                  title: '',
                  deleteCallBack: () {},
                ),
                20.height(),
                Row(
                  children: [
                    Checkbox(
                      value: applyToAllDays,
                      onChanged: (bool? value) {
                        setState(() {
                          applyToAllDays = value ?? false;
                        });
                      },
                    ),
                    Text(
                      'Applicable for all days',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
                10.height(),
                BottomSheetButton(
                  onTap: () {
                    if (startTimeController.text.isNotEmpty &&
                        endTimeController.text.isNotEmpty) {
                      // Validate and create slot string
                      String slot =
                          "${startTimeController.text} - ${endTimeController.text}";
                      try {
                        DateFormat format = DateFormat("HH:mm");
                        DateTime startTime = format.parse(startTimeController.text);
                        DateTime endTime = format.parse(endTimeController.text);

                        // Validate time range
                        if (startTime.isAfter(endTime) ||
                            startTime.isAtSameMomentAs(endTime)) {
                          showToast("⚠ Start time must be before end time");
                          return;
                        }

                        // Create operationalTime list based on checkbox state
                        List<OperationalTime> operationalTimes;
                        if (applyToAllDays) {
                          // Apply to all days
                          operationalTimes = [
                            'Sunday',
                            'Monday',
                            'Tuesday',
                            'Wednesday',
                            'Thursday',
                            'Friday',
                            'Saturday'
                          ].map((day) => OperationalTime(
                            day: day,
                            isopen: true,
                            slot: slot,
                          )).toList();
                        } else {
                          // Apply to selected day only
                          operationalTimes = [
                            OperationalTime(
                              day: widget.day,
                              isopen: true, // Set to true when updating slot
                              slot: slot,
                            ),
                          ];
                        }

                        BusinessHourData hourModel = BusinessHourData(
                          vendorData: BusinessProfileData.vendorId() ?? "",
                          operationalTime: operationalTimes,
                        );

                        widget.businessHourBloc.add(
                          BusinessHourPatchEvent(businessHourData: hourModel),
                        );

                        // Clear controllers after saving
                        startTimeController.clear();
                        endTimeController.clear();
                        Navigator.pop(context);
                      } catch (e) {
                        showToast("⚠ Invalid time format. Use HH:mm");
                        return;
                      }
                    } else {
                      showToast("Add Start time and End time");
                      return;
                    }
                  },
                ),
                30.height(),
              ],
            ),
          ),
        ),

      ],
    )
        : Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.day,
                  style: context.titleSmall()?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close, color: AppColors.redLight),
                ),
              ],
            ),
            Divider(),
            10.height(),
            SlotWidget(
              startTimeController: startTimeController,
              endTimeController: endTimeController,
              timeGapInMinute: 10,
              title: '',
              deleteCallBack: () {},
            ),
            20.height(),
            Row(
              children: [
                Checkbox(
                  value: applyToAllDays,
                  onChanged: (bool? value) {
                    setState(() {
                      applyToAllDays = value ?? false;
                    });
                  },
                ),
                Text(
                  'Applicable for all days',
                  style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                ),
              ],
            ),
            10.height(),
            BottomSheetButton(
              onTap: () {
                if (startTimeController.text.isNotEmpty &&
                    endTimeController.text.isNotEmpty) {
                  // Validate and create slot string
                  String slot =
                      "${startTimeController.text} - ${endTimeController.text}";
                  try {
                    DateFormat format = DateFormat("HH:mm");
                    DateTime startTime = format.parse(startTimeController.text);
                    DateTime endTime = format.parse(endTimeController.text);

                    // Validate time range
                    if (startTime.isAfter(endTime) ||
                        startTime.isAtSameMomentAs(endTime)) {
                      showToast("⚠ Start time must be before end time");
                      return;
                    }

                    // Create operationalTime list based on checkbox state
                    List<OperationalTime> operationalTimes;
                    if (applyToAllDays) {
                      // Apply to all days
                      operationalTimes = [
                        'Sunday',
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday'
                      ].map((day) => OperationalTime(
                        day: day,
                        isopen: true,
                        slot: slot,
                      )).toList();
                    } else {
                      // Apply to selected day only
                      operationalTimes = [
                        OperationalTime(
                          day: widget.day,
                          isopen: !(widget.isOpen ?? false), // Toggle isOpen
                          slot: slot,
                        ),
                      ];
                    }

                    BusinessHourData hourModel = BusinessHourData(
                      vendorData: BusinessProfileData.vendorId() ?? "",
                      operationalTime: operationalTimes,
                    );

                    widget.businessHourBloc.add(
                      BusinessHourPatchEvent(businessHourData: hourModel),
                    );

                    // Clear controllers after saving
                    startTimeController.clear();
                    endTimeController.clear();
                    Navigator.pop(context);
                  } catch (e) {
                    showToast("⚠ Invalid time format. Use HH:mm");
                    return;
                  }
                } else {
                  showToast("Add Start time and End time");
                  return;
                }
              },
            ),
            30.height(),
          ],
        ),
      ),
    );
  }
}