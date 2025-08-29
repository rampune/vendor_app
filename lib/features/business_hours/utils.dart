
//Saransh new code
import 'package:intl/intl.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
class BusinessHourUtils {
  static String? currentSlot; // Store a single slot string instead of a list

  static bool addToSlot(String slot) {
    if (currentSlot != null) {
      showToast("⚠ Only one slot is allowed. Replace the existing slot?");
      return false; // Prevent adding if a slot already exists
    }

    // Validate the slot format (e.g., "11:00 - 23:00")
    RegExp slotPattern = RegExp(r'^\d{2}:\d{2}\s*-\s*\d{2}:\d{2}$');
    if (!slotPattern.hasMatch(slot)) {
      showToast("⚠ Invalid slot format. Use 'HH:mm - HH:mm'");
      return false;
    }

    // Parse the slot string
    try {
      DateFormat format = DateFormat("HH:mm");
      var times = slot.split('-').map((e) => e.trim()).toList();
      DateTime startTime = format.parse(times[0]);
      DateTime endTime = format.parse(times[1]);

      // Validate time range
      if (startTime.isAfter(endTime) || startTime.isAtSameMomentAs(endTime)) {
        showToast("⚠ Start time must be before end time");
        return false;
      }

      currentSlot = slot; // Store the slot
      showToast("✅ Slot added: $slot");
      return true;
    } catch (e) {
      showToast("⚠ Error parsing slot times");
      return false;
    }
  }

  static void clearSlot() {
    currentSlot = null; // Clear the slot
  }
}