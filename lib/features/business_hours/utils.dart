import 'package:intl/intl.dart';
import 'package:new_pubup_partner/features/business_hours/model/business_hour_model.dart';

import '../../config/common_functions.dart';

class BusinessHourUtils{
  static List<Slot> listSlot=[];
  static addToSlotList(Slot slot){

      DateFormat format = DateFormat("HH:mm");

      // Parse the new slot's start and end times
      DateTime newStart = format.parse(slot.startTime ?? "00:00");
      DateTime newEnd = format.parse(slot.endTime ?? "00:00");

      // Loop through existing slots
      for (int index = 0; index < listSlot.length; index++) {
        Slot existing = listSlot[index];

        DateTime existStart = format.parse(existing.startTime ?? "00:00");
        DateTime existEnd = format.parse(existing.endTime ?? "00:00");

        // Check overlap: newStart < existEnd && newEnd > existStart
        if (newStart.isBefore(existEnd) && newEnd.isAfter(existStart)) {
          showToast("⚠ Slot overlaps with existing slot: ${existing.startTime} - ${existing.endTime}");
          return; // Stop, don't add
        }
      }

      // If no overlap, add to list
      listSlot.add(slot);
      showToast("✅ Slot added: ${slot.startTime} - ${slot.endTime}");


  }
}