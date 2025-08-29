
//Saransh new code

import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/working_hours_bottom_sheet_widget.dart';

import '../bloc/business_hour_bloc.dart'; // Assuming AppColors is defined here

class WorkingHourTile extends StatelessWidget {
  final String day;
  final String subTitle;
  final bool isOn;
  final String? slotTime; // Slot string in format "HH:mm - HH:mm"
  final VoidCallback leadingCallBack; // Kept for compatibility, but unused
  final VoidCallback onTap;

  final BusinessHourBloc businessHourBloc;

  const WorkingHourTile({
    super.key,
    required this.day,
    required this.subTitle,
    required this.isOn,
    required this.slotTime,
    required this.leadingCallBack,
    required this.onTap,

    required this.businessHourBloc
  });

  @override
  Widget build(BuildContext context) {
    // Parse slotTime to extract start and end times
    String? startTime;
    String? endTime;
    if (slotTime != null) {
      try {
        var times = slotTime!.split('-').map((e) => e.trim()).toList();
        if (times.length == 2) {
          startTime = times[0];
          endTime = times[1];
        }
      } catch (e) {
        debugPrint('Error parsing slotTime: $e');
        startTime = null;
        endTime = null;
      }
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black),
      ),
      child: ExpansionTile(
        leading: Icon(Icons.keyboard_arrow_down),
        title: Row(
          children: [
            Text(
              day,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500),
            ),
            Spacer(),
            Text(
              subTitle,
              style: TextStyle(
                color: subTitle == 'Open' ? Colors.green : Colors.red,
                fontSize: 14,
                fontWeight: FontWeight.w500
              ),
            ),
          ],
        ),
        trailing: Switch(
          value: isOn,
          onChanged: (value) => onTap(),
          activeColor: Colors.green,
          activeTrackColor: Colors.green[400],
          inactiveThumbColor: Colors.red,
          inactiveTrackColor: Colors.grey[300],
        ),
        children: [
          if (slotTime != null && startTime != null && endTime != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            'Start Time',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      GestureDetector(

                        onTap: () {
                          // Open BottomSheetWidget to edit start time
                          showModalBottomSheet(
                            backgroundColor: AppColors.transparent,
                            context: context,
                            builder: (_) {
                              return BottomSheetWidget(
                                businessHourBloc: businessHourBloc,  // Replace with actual bloc instance
                                day: day,
                                isOpen: isOn,
                                isPostRequest: false,
                                slotTime: slotTime,
                                isEditMode: true,
                              );
                            },
                          );
                        },

                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black
                              ),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  startTime,
                                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                                ),
                                Icon(Icons.keyboard_arrow_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.themeColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Text(
                            'End Time',
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      GestureDetector(
                        onTap: (){
                          // Open BottomSheetWidget to edit start time
                          showModalBottomSheet(
                            backgroundColor: AppColors.transparent,
                            context: context,
                            builder: (_) {
                              return BottomSheetWidget(
                                businessHourBloc: businessHourBloc,  // Replace with actual bloc instance
                                day: day,
                                isOpen: isOn,
                                isPostRequest: false,
                                slotTime: slotTime,
                                isEditMode: true,
                              );
                            },
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black
                            ),
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                            child: Row(
                              children: [
                                Text(
                                  endTime,
                                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                                ),
                                Icon(Icons.keyboard_arrow_down)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                ],
              ),
            )
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'No operating hours defined',
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
              ),
            ),
        ],
      ),
    );
  }
}