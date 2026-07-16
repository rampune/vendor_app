// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:new_pubup_partner/config/common_functions.dart';
// import 'package:new_pubup_partner/config/extensions.dart';
// import 'package:new_pubup_partner/config/string.dart';
// import 'package:new_pubup_partner/data/source/local/hive_box.dart';
// import 'package:new_pubup_partner/features/admin_details/widget/custom_drop_down/custom_drop_down.dart';
//
// import 'package:new_pubup_partner/utils/string_to_int.dart';
// import '../../../config/theme.dart';
// import '../../common_widgets/custom_button.dart';
// import '../../common_widgets/custom_text_field.dart';
// import '../event_booking.dart';
// import '../event_controller/event_controller.dart';
// import '../model/EventPostModel.dart';
// import '../widget/ticket_button.dart';
// import '../widget/yes_no_toggle.dart';
// class EventBookingScreen2 extends StatefulWidget {
//   const EventBookingScreen2({super.key});
//
//   @override
//   State<EventBookingScreen2> createState() => _EventBookingScreen2State();
// }
//
// class _EventBookingScreen2State extends State<EventBookingScreen2> {
//
// bool isTicketFree=false;
// bool isCoupleFree = false;
//   List<String> ticketType=["Single Male", "Single Female", "Couple"];
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//       child: SingleChildScrollView(
//         child: Form(
//           key: EventController.booking2FormKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Text("Turn vibes Into Bookings",
//                 style: context.titleLarge(),),
//               10.height(),
//               Text("Get Discovered by the right crowd .Post your event in minutes.",
//                 style: context.titleSmall(),),
//               10.height(),
//               Wrap(
//                 children: EventController.listTickets.map((item)=>  PremiumTicketButton(
//                   title: item.ticketType??'',
//                   ticketType: '', onEdit: () {  }, onDelete: () {
//                     setState(() {
//                       EventController.
//                       listTickets.remove(item);
//                     });
//
//                 }, price: "${item.price}",
//                 )).toList(),
//               ),
//               10.height(),
//
//
//
//               ///Amara ram old code with dropdown
//               CustomDropDown(controller: EventController.ticketType,
//                   heading: "Ticket Type",
//                   title: "Ticket Type",
//                   validator: (String? data){
//                 if(data?.isEmpty??true){
//                   return "Choose Ticket type";
//                 }
//                   },
//                   listCustomDropDownModel:ticketType.map((item)=>
//                       CustomDropDownModel(name: item,)).toList(),
//
//
//                   onSelect: (CustomDropDownModel selected){
//
//                   }),
//
//
//               ///Saransh new code with with text field
//               // CustomTextField(
//               //   validator: (String? data){
//               //     if(data?.isEmpty??true){
//               //       return "Enter name";
//               //     }
//               //   },
//               //   textController: EventController.ticketType,
//               //   title: "Ticket Name",
//               //   placeHolderText: "Enter the name",
//               //
//               // ),
//
//
//
//
//               10.height(),
//               CustomTextField(
//                 validator: (String? data){
//                   if(data?.isEmpty??true){
//                     return "Enter Description";
//                   }
//                 },
//
//                 textController: EventController.ticketDescription,
//                 title: "Ticket Description",
//                 placeHolderText: "e.g Early Bird,Express Entry",
//
//               ),
//               20.height(),
//
//
//               YesNoToggle(title: "Ticket Free",callBack: (bool result){
//                 print("$result");
//                 setState(() {
//                   isTicketFree=result;
//                 });
//               },),
//
//
//
//               20.height(),
//
//               YesNoToggle(title: "Couple Free",callBack: (bool result){
//                 print("$result");
//                 setState(() {
//                   isCoupleFree=result;
//                 });
//               },),
//
//               10.height(),
//             if(!isTicketFree)  CustomTextField(
//               validator: (String? data){
//                 if(data?.isEmpty??true&&(!isTicketFree)){
//                   return "Enter Ticket Price";
//                 }
//               },
//
//
//                 textController: EventController.ticketPrice,
//                 title: "Ticket Price",
//                 isNumber: true,
//
//               ),
//               20.height(),
//               CustomTextField(
//                 validator: (String? data){
//                   if(data?.isEmpty??true){
//                     return "Enter CoverCharges";
//                   }
//                 },
//
//                 textController: EventController.ticketCoverCharges,
//                 title: "Cover Charges",
//                 placeHolderText: "",
//
//               ),
//               20.height(),
//
//              Align(alignment: Alignment.center,
//               child:    FloatingActionButton(
//                 backgroundColor: AppColors.black,
//                 onPressed: (){
//           if(EventController.booking2FormKey.currentState?.validate()??false){
//             // if(ticketType.contains("${EventController.ticketType.text}")){
//             //   EventController.listTickets= EventController.listTickets.where((ticket)=>ticket.ticketType!="${EventController.ticketType.text}").toList();
//             // }
//
//
//             setState(() {
//           TicketModel ticketModel= TicketModel(ticketType:
//               EventController.ticketType.text,
//                   price:isTicketFree?0:stringToInt(EventController.ticketPrice.text,
//                   ),
//                   description: EventController.ticketDescription.text,
//                   coverCharges: EventController.ticketCoverCharges.text,
//                   isFree: isTicketFree,
//                   isCoupleFree: isCoupleFree
//               );
//               EventController.listTickets.add(ticketModel);
//         Future.delayed(Duration(seconds: 1),(){
//           EventController.ticketDescription.clear();
//           EventController.ticketPrice.clear();
//           EventController.ticketType.clear();
//         });
//             });
//           }else{
//             showToast("Enter Valid Data");
//           }
//
//                 },child: Icon(Icons.add),)
//              ),
//
//
//
//
//
//
//
//             ],),
//         ),
//       ),
//     );
//   }
// }
//
//
//




/*
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/data/source/local/hive_box.dart';
import 'package:new_pubup_partner/features/admin_details/widget/custom_drop_down/custom_drop_down.dart';
import 'package:new_pubup_partner/features/event/load_save_event.dart';

import 'package:new_pubup_partner/utils/string_to_int.dart';
import '../../../config/theme.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../event_booking.dart';
import '../event_controller/event_controller.dart';
import '../model/EventPostModel.dart';
import '../widget/ticket_button.dart';
import '../widget/yes_no_toggle.dart';
class EventBookingScreen2 extends StatefulWidget {
  const EventBookingScreen2({super.key});

  @override
  State<EventBookingScreen2> createState() => _EventBookingScreen2State();
}

class _EventBookingScreen2State extends State<EventBookingScreen2> {
  List<String> ticketTypes = ["Single Male", "Single Female", "Couple"];

  bool _validateTicketFields() {
    if (EventController.ticketType.text.trim().isEmpty) {
      showToast("Choose Ticket Type");
      return false;
    }
    if (EventController.ticketDescription.text.trim().isEmpty) {
      showToast("Enter Description");
      return false;
    }
    if (!EventController.ticketIsFree.value && EventController.ticketPrice.text.trim().isEmpty) {
      showToast("Enter Ticket Price");
      return false;
    }
    if (EventController.ticketCoverCharges.text.trim().isEmpty) {
      showToast("Enter Cover Charges");
      return false;
    }
    return true;
  }

  void _addTicketAndClear() {
    if (!_validateTicketFields()) {
      return;
    }
    TicketModel ticketModel = TicketModel(
        ticketType: EventController.ticketType.text,
        price: EventController.ticketIsFree.value ? 0 : stringToInt(EventController.ticketPrice.text),
        description: EventController.ticketDescription.text,
        coverCharges: EventController.ticketCoverCharges.text,
        isFree: EventController.ticketIsFree.value,
        isCoupleFree: EventController.coupleIsFree.value
    );
    EventController.listTickets.add(ticketModel);
    // Clear fields
    EventController.ticketDescription.clear();
    EventController.ticketPrice.clear();
    EventController.ticketType.clear();
    EventController.ticketCoverCharges.clear();
    EventController.ticketIsFree.value = false;
    EventController.coupleIsFree.value = false;
    LoadSaveEvent.instance.saveEventToHive();
    setState(() {});
  }

  void _addTicketAndNext() {
    hideKeyboard();
    LoadSaveEvent.instance.saveEventToHive();
    if (EventController.booking2FormKey.currentState?.validate() ?? false) {
      // If dropdown has validator, but since removed, always true
    }
    if (EventController.ticketDescription.text.trim().isNotEmpty) {
      if (!_validateTicketFields()) {
        return;
      }
      TicketModel ticketModel = TicketModel(
          ticketType: EventController.ticketType.text,
          price: EventController.ticketIsFree.value ? 0 : stringToInt(EventController.ticketPrice.text),
          description: EventController.ticketDescription.text,
          coverCharges: EventController.ticketCoverCharges.text,
          isFree: EventController.ticketIsFree.value,
          isCoupleFree: EventController.coupleIsFree.value
      );
      EventController.listTickets.add(ticketModel);
      // Clear fields
      EventController.ticketDescription.clear();
      EventController.ticketPrice.clear();
      EventController.ticketType.clear();
      EventController.ticketCoverCharges.clear();
      EventController.ticketIsFree.value = false;
      EventController.coupleIsFree.value = false;
    }
    // Move to next regardless
    EventController.eventPageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    final isCoupleSelected = EventController.ticketType.text == "Couple";
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: EventController.booking2FormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Turn vibes Into Bookings",
                style: context.titleLarge(),),
              10.height(),
              Text("Get Discovered by the right crowd .Post your event in minutes.",
                style: context.titleSmall(),),
              10.height(),
              Wrap(
                children: EventController.listTickets.map((item)=>  PremiumTicketButton(
                  title: item.ticketType??'',
                  ticketType: '', onEdit: () {  }, onDelete: () {
                  setState(() {
                    EventController.
                    listTickets.remove(item);
                  });

                }, price: "${item.price}",
                )).toList(),
              ),
              10.height(),
              CustomDropDown(controller: EventController.ticketType,
                  heading: "Ticket Type",
                  title: "Ticket Type",
                  // Removed validator to allow skipping
                  listCustomDropDownModel:ticketTypes.map((item)=>
                      CustomDropDownModel(name: item,)).toList(),
                  onSelect: (CustomDropDownModel selected){
                    // EventController.ticketType.text = selected.name;

                    setState(() {
                      EventController.ticketType.text = selected.name;
                      if (selected.name != "Couple") {
                        EventController.coupleIsFree.value = false;
                      }
                    });
                  }),
              10.height(),
              CustomTextField(
                // Removed validator
                textController: EventController.ticketDescription,
                title: "Ticket Description",
                placeHolderText: "e.g Early Bird,Express Entry",
              ),
              20.height(),

              Row(
                children: [
                  Expanded(
                    child: ValueListenableBuilder<bool>(
                        valueListenable: EventController.ticketIsFree,
                        builder: (context, isFree, child) {
                          return YesNoToggle(title: "Ticket Free", isYes: isFree, callBack: (bool result){
                            setState(() {
                              EventController.ticketIsFree.value = result;
                            });
                          },);
                        }
                    ),
                  ),

                  if (isCoupleSelected) ...[
                    const Spacer(),
                    Expanded(
                      child: ValueListenableBuilder<bool>(
                          valueListenable: EventController.coupleIsFree,
                          builder: (context, isCoupleFree, child) {
                            return YesNoToggle(title: "Couple Free", isYes: isCoupleFree, callBack: (bool result){
                              setState(() {
                                EventController.coupleIsFree.value = result;
                              });
                            },);
                          }
                      ),
                    ),
                  ],
                ],
              ),

              10.height(),
              if(!EventController.ticketIsFree.value) ...[
                CustomTextField(
                  // Removed validator
                  textController: EventController.ticketPrice,
                  title: "Ticket Price",
                  isNumber: true,
                ),
                20.height(),
              ],
              CustomTextField(
                // Removed validator
                textController: EventController.ticketCoverCharges,
                title: "Cover Charges",
                placeHolderText: "",
              ),
              20.height(),
              Text(
                "If you have multiple tickets types",
                style: const TextStyle(color: Colors.red),
              ),
              10.height(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonColor: AppColors.black,
                      buttonText: "+ Add More Tickets",
                      onPress: _addTicketAndClear,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      buttonColor: Colors.amber,
                      buttonText: "Next",
                      onPress: _addTicketAndNext,
                    ),
                  ),
                ],
              ),
              20.height(),
            ],
          ),
        ),
      ),
    );
  }
}*/









import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/features/admin_details/widget/custom_drop_down/custom_drop_down.dart';
import 'package:new_pubup_partner/features/event/load_save_event.dart';
import 'package:new_pubup_partner/utils/string_to_int.dart';
import '../../../config/theme.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../event_controller/event_controller.dart';
import '../model/EventPostModel.dart';
import '../widget/ticket_button.dart';
import '../widget/yes_no_toggle.dart';
import '../../../utils/pickers/pickers.dart';

class EventBookingScreen2 extends StatefulWidget {
  const EventBookingScreen2({super.key});

  @override
  State<EventBookingScreen2> createState() => _EventBookingScreen2State();
}

class _EventBookingScreen2State extends State<EventBookingScreen2> {
  List<String> ticketTypes = ["Single Male", "Single Female", "Couple"];

  bool _isRefundable = false;
  final TextEditingController _advancePriceController = TextEditingController();
  final TextEditingController _refundablePriceController = TextEditingController();
  final TextEditingController _refundablePricePercentageController = TextEditingController();
  final TextEditingController _refundableTillDateController = TextEditingController();

  DateTime? _parseDateString(String text) {
    text = text.trim();
    if (text.isEmpty) return null;
    String formatted = text.replaceAll('/', '-');
    try {
      List<String> parts = formatted.split('-');
      if (parts.length == 3) {
        int day = int.parse(parts[0]);
        int month = int.parse(parts[1]);
        int year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (_) {}
    return DateTime.tryParse(text);
  }

  void _calculatePercentage() {
    final priceStr = _advancePriceController.text.trim();
    final refPriceStr = _refundablePriceController.text.trim();
    if (priceStr.isEmpty || refPriceStr.isEmpty) {
      _refundablePricePercentageController.text = '';
      return;
    }
    final price = int.tryParse(priceStr) ?? 0;
    final refPrice = int.tryParse(refPriceStr) ?? 0;
    if (price > 0 && refPrice > 0) {
      final pct = ((refPrice / price) * 100).round();
      final newText = pct.toString();
      if (_refundablePricePercentageController.text != newText) {
        _refundablePricePercentageController.text = newText;
      }
    } else {
      _refundablePricePercentageController.text = '';
    }
  }

  void _calculatePrice() {
    final priceStr = _advancePriceController.text.trim();
    final pctStr = _refundablePricePercentageController.text.trim();
    if (priceStr.isEmpty || pctStr.isEmpty) {
      _refundablePriceController.text = '';
      return;
    }
    final price = int.tryParse(priceStr) ?? 0;
    final pct = int.tryParse(pctStr) ?? 0;
    if (price > 0 && pct > 0) {
      final refPrice = ((pct / 100) * price).round();
      final newText = refPrice.toString();
      if (_refundablePriceController.text != newText) {
        _refundablePriceController.text = newText;
      }
    } else {
      _refundablePriceController.text = '';
    }
  }

  @override
  void dispose() {
    _advancePriceController.dispose();
    _refundablePriceController.dispose();
    _refundablePricePercentageController.dispose();
    _refundableTillDateController.dispose();
    super.dispose();
  }

  Set<String> _getAddedTicketTypes() {
    return EventController.listTickets
        .where((ticket) => ticket.ticketType != null)
        .map((ticket) => ticket.ticketType!)
        .toSet();
  }

  bool _isTicketTypeAlreadyAdded(String type) {
    return _getAddedTicketTypes().contains(type);
  }

  List<CustomDropDownModel> _getAvailableTicketTypes() {
    final addedTypes = _getAddedTicketTypes();
    return ticketTypes
        .where((type) => !addedTypes.contains(type))
        .map((item) => CustomDropDownModel(name: item))
        .toList();
  }

  bool _validateTicketFields() {
    if (EventController.ticketType.text.trim().isEmpty) {
      showToast("Choose Ticket Type");
      return false;
    }
    if (EventController.ticketDescription.text.trim().isEmpty) {
      showToast("Enter Description");
      return false;
    }
    if (!EventController.ticketIsFree.value && EventController.ticketPrice.text.trim().isEmpty) {
      showToast("Enter Ticket Price");
      return false;
    }
    if (EventController.ticketCoverCharges.text.trim().isEmpty) {
      showToast("Enter Cover Charges");
      return false;
    }
    if (_isRefundable) {
      if (_advancePriceController.text.trim().isEmpty) {
        showToast("Enter Advance Price");
        return false;
      }
      if (_refundablePriceController.text.trim().isEmpty) {
        showToast("Enter Refundable Price");
        return false;
      }
      final refPriceText = _refundablePriceController.text.trim();
      if (refPriceText.isNotEmpty && (int.tryParse(refPriceText) == 0)) {
        showAlert(context, "Refundable amounts cannot be zero");
        return false;
      }
      if (_refundablePricePercentageController.text.trim().isEmpty) {
        showToast("Enter Refundable Price Percentage");
        return false;
      }
      if (_refundableTillDateController.text.trim().isEmpty) {
        showToast("Select Refundable Till Date");
        return false;
      }

      final int ticketPrice = EventController.ticketIsFree.value ? 0 : (int.tryParse(EventController.ticketPrice.text.trim()) ?? 0);
      final int advancePrice = int.tryParse(_advancePriceController.text.trim()) ?? 0;
      final int refundablePrice = int.tryParse(_refundablePriceController.text.trim()) ?? 0;

      if (refundablePrice > advancePrice) {
        showAlert(context, "Refundable amount cannot be more than the pre-booking amount");
        return false;
      }

      if ((advancePrice + refundablePrice) > ticketPrice) {
        showAlert(context, "Advance and Refundable  amount cannot be more than the ticket  amount");
        return false;
      }
    }
    return true;
  }

  bool _validateAllTicketTypesAdded() {
    final addedTypes = _getAddedTicketTypes();
    if (addedTypes.isEmpty) {
      return true;
    }
    if (addedTypes.length < 3 || !addedTypes.containsAll(ticketTypes)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please add at least one ticket for each type: Single Male, Single Female, Couple"),
          duration: const Duration(seconds: 3),
        ),
      );
      return false;
    }
    return true;
  }

  void _addTicketAndClear() {
    if (!_validateTicketFields()) {
      return;
    }

    final selectedType = EventController.ticketType.text;
    if (_isTicketTypeAlreadyAdded(selectedType)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Ticket type '$selectedType' is already added. Please edit or delete the existing one."),
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    TicketModel ticketModel = TicketModel(
        ticketType: selectedType,
        price: EventController.ticketIsFree.value ? 0 : stringToInt(EventController.ticketPrice.text),
        description: EventController.ticketDescription.text,
        coverCharges: EventController.ticketCoverCharges.text,
        isFree: EventController.ticketIsFree.value,
        isCoupleFree: EventController.coupleIsFree.value,
        isRefundable: _isRefundable,
        advancePrice: _isRefundable ? stringToInt(_advancePriceController.text) : null,
        refundablePrice: _isRefundable ? stringToInt(_refundablePriceController.text) : null,
        refundablePricePercentage: _isRefundable ? stringToInt(_refundablePricePercentageController.text) : null,
        refundableTillDate: _isRefundable ? _refundableTillDateController.text : null,
    );
    EventController.listTickets.add(ticketModel);
    // Clear fields
    EventController.ticketDescription.clear();
    EventController.ticketPrice.clear();
    EventController.ticketType.clear();
    EventController.ticketCoverCharges.clear();
    EventController.ticketIsFree.value = false;
    EventController.coupleIsFree.value = false;
    _advancePriceController.clear();
    _refundablePriceController.clear();
    _refundablePricePercentageController.clear();
    _refundableTillDateController.clear();
    _isRefundable = false;
    LoadSaveEvent.instance.saveEventToHive();
    setState(() {});
  }

  void _addTicketAndNext() {
    hideKeyboard();
    LoadSaveEvent.instance.saveEventToHive();
    if (EventController.booking2FormKey.currentState?.validate() ?? false) {
      // If dropdown has validator, but since removed, always true
    }
    if (EventController.ticketDescription.text.trim().isNotEmpty) {
      if (!_validateTicketFields()) {
        return;
      }
      final selectedType = EventController.ticketType.text;
      if (_isTicketTypeAlreadyAdded(selectedType)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Ticket type '$selectedType' is already added. Please edit or delete the existing one."),
            duration: const Duration(seconds: 3),
          ),
        );
        return;
      }
      TicketModel ticketModel = TicketModel(
          ticketType: selectedType,
          price: EventController.ticketIsFree.value ? 0 : stringToInt(EventController.ticketPrice.text),
          description: EventController.ticketDescription.text,
          coverCharges: EventController.ticketCoverCharges.text,
          isFree: EventController.ticketIsFree.value,
          isCoupleFree: EventController.coupleIsFree.value,
          isRefundable: _isRefundable,
          advancePrice: _isRefundable ? stringToInt(_advancePriceController.text) : null,
          refundablePrice: _isRefundable ? stringToInt(_refundablePriceController.text) : null,
          refundablePricePercentage: _isRefundable ? stringToInt(_refundablePricePercentageController.text) : null,
          refundableTillDate: _isRefundable ? _refundableTillDateController.text : null,
      );
      EventController.listTickets.add(ticketModel);
      // Clear fields
      EventController.ticketDescription.clear();
      EventController.ticketPrice.clear();
      EventController.ticketType.clear();
      EventController.ticketCoverCharges.clear();
      EventController.ticketIsFree.value = false;
      EventController.coupleIsFree.value = false;
      _advancePriceController.clear();
      _refundablePriceController.clear();
      _refundablePricePercentageController.clear();
      _refundableTillDateController.clear();
      _isRefundable = false;
      setState(() {});
    }
    // Validate all types before proceeding
    if (!_validateAllTicketTypesAdded()) {
      return;
    }
    // Move to next regardless if validation passes
    EventController.eventPageController.animateToPage(
      2,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isTicketFree = EventController.ticketIsFree.value;
    if (isTicketFree && _isRefundable) {
      _isRefundable = false;
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: EventController.booking2FormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Turn vibes Into Bookings",
                style: context.titleLarge(),),
              10.height(),
              Text("Get Discovered by the right crowd .Post your event in minutes.",
                style: context.titleSmall(),),
              10.height(),
              Wrap(
                children: EventController.listTickets.map((item)=>  PremiumTicketButton(
                  title: item.ticketType??'',
                  ticketType: '',
                  price: "${item.price}",
                  onDelete: () {
                    setState(() {
                      EventController.listTickets.remove(item);
                      LoadSaveEvent.instance.saveEventToHive();
                    });
                  },
                  onEdit: () {
                    setState(() {
                      EventController.ticketType.text = item.ticketType ?? '';
                      EventController.ticketDescription.text = item.description ?? '';
                      EventController.ticketPrice.text = item.price == 0 ? '' : '${item.price}';
                      EventController.ticketCoverCharges.text = item.coverCharges ?? '';
                      EventController.ticketIsFree.value = item.isFree ?? false;
                      EventController.coupleIsFree.value = item.isCoupleFree ?? false;

                      _isRefundable = item.isRefundable ?? false;
                      _advancePriceController.text = item.advancePrice == null ? '' : '${item.advancePrice}';
                      _refundablePriceController.text = item.refundablePrice == null ? '' : '${item.refundablePrice}';
                      _refundablePricePercentageController.text = item.refundablePricePercentage == null ? '' : '${item.refundablePricePercentage}';
                      _refundableTillDateController.text = item.refundableTillDate ?? '';

                      EventController.listTickets.remove(item);
                    });
                  },
                )).toList(),
              ),
              10.height(),
              CustomDropDown(controller: EventController.ticketType,
                  heading: "Ticket Type",
                  title: "Ticket Type",
                  // Removed validator to allow skipping
                  listCustomDropDownModel: _getAvailableTicketTypes(),
                  onSelect: (CustomDropDownModel selected){
                    setState(() {
                      EventController.ticketType.text = selected.name;
                      if (selected.name != "Couple") {
                        EventController.coupleIsFree.value = false;
                      }
                    });
                  }),
              10.height(),
              CustomTextField(
                // Removed validator
                textController: EventController.ticketDescription,
                title: "Ticket Description",
                placeHolderText: "e.g Early Bird,Express Entry",
              ),
              20.height(),

              Row(
                children: [
                  Expanded(
                    child: ValueListenableBuilder<bool>(
                        valueListenable: EventController.ticketIsFree,
                        builder: (context, isFree, child) {
                          return YesNoToggle(title: "Ticket Free", isYes: isFree, callBack: (bool result){
                            setState(() {
                              EventController.ticketIsFree.value = result;
                              EventController.coupleIsFree.value = result;
                            });
                          },);
                        }
                    ),
                  ),
                ],
              ),

              10.height(),
              if(!EventController.ticketIsFree.value) ...[
                CustomTextField(
                  // Removed validator
                  textController: EventController.ticketPrice,
                  title: "Ticket Price",
                  isNumber: true,
                  placeHolderText: 'eg. 100',
                ),
                20.height(),
              ],
              CustomTextField(
                // Removed validator
                textController: EventController.ticketCoverCharges,
                title: "Cover Charges",
                placeHolderText: "eg. 30",
                isNumber: true,
              ),
              if (!isTicketFree) ...[
                20.height(),
                YesNoToggle(
                  title: "Is Refundable",
                  isYes: _isRefundable,
                  callBack: (bool result) {
                    setState(() {
                      _isRefundable = result;
                    });
                  },
                ),
                if (_isRefundable) ...[
                  20.height(),
                  CustomTextField(
                    textController: _advancePriceController,
                    title: "Advance Price",
                    isNumber: true,
                    placeHolderText: "eg. 1200",
                    onChanged: (val) {
                      if (_isRefundable) {
                        _calculatePercentage();
                      }
                      return null;
                    },
                  ),
                  20.height(),
                  CustomTextField(
                    textController: _refundablePriceController,
                    title: "Refundable Price",
                    isNumber: true,
                    placeHolderText: "eg. 800",
                    onChanged: (val) {
                      _calculatePercentage();
                      return null;
                    },
                  ),
                  20.height(),
                  CustomTextField(
                    textController: _refundablePricePercentageController,
                    title: "Refundable Price Percentage (%)",
                    isNumber: true,
                    placeHolderText: "eg. 75",
                    onChanged: (val) {
                      _calculatePrice();
                      return null;
                    },
                  ),
                  20.height(),
                  CustomTextField(
                    textController: _refundableTillDateController,
                    title: "Refundable Till Date",
                    readOnly: true,
                    placeHolderText: "Select Date",
                    onTap: () async {
                      DateTime now = DateTime.now();
                      DateTime today = DateTime(now.year, now.month, now.day);
                      DateTime lastDate = today;

                      if (EventController.eventDateController.text.isNotEmpty) {
                        DateTime? parsedEventDate = _parseDateString(EventController.eventDateController.text);
                        if (parsedEventDate != null) {
                          lastDate = parsedEventDate;
                        } else {
                          lastDate = DateTime(2101);
                        }
                      } else {
                        lastDate = DateTime(2101);
                      }

                      DateTime firstDate = today;
                      if (lastDate.isBefore(firstDate)) {
                        firstDate = lastDate;
                      }

                      DateTime initialDate = today;
                      if (initialDate.isBefore(firstDate)) {
                        initialDate = firstDate;
                      } else if (initialDate.isAfter(lastDate)) {
                        initialDate = lastDate;
                      }

                      final DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: initialDate,
                        firstDate: firstDate,
                        lastDate: lastDate,
                        barrierColor: Colors.black.withOpacity(0.5),
                        builder: (BuildContext context, Widget? child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: AppColors.themeColor,        // Header background color
                                onPrimary: Colors.white,     // Header text color
                                onSurface: Colors.black,     // Body text color
                              ),
                              textButtonTheme: TextButtonThemeData(
                                style: TextButton.styleFrom(
                                  foregroundColor: AppColors.themeColor, // Button text color
                                ),
                              ),
                              dialogBackgroundColor: Colors.white, // Background of the dialog
                            ),
                            child: child!,
                          );
                        },
                      );

                      if (pickedDate != null) {
                        String selectedDateStr = "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                        setState(() {
                          _refundableTillDateController.text = selectedDateStr;
                        });
                      }
                    },
                  ),
                ],
              ],
              20.height(),
              Text(
                "If you have multiple tickets types",
                style: const TextStyle(color: Colors.red),
              ),
              10.height(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonColor: AppColors.black,
                      buttonText: "+ Add More Tickets",
                      onPress: _addTicketAndClear,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      buttonColor: Colors.amber,
                      buttonText: "Next",
                      onPress: _addTicketAndNext,
                    ),
                  ),
                ],
              ),
              20.height(),
            ],
          ),
        ),
      ),
    );
  }
}


