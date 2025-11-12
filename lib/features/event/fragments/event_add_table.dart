// import 'package:flutter/material.dart';
// import 'package:new_pubup_partner/config/common_functions.dart';
// import 'package:new_pubup_partner/config/extensions.dart';
// import 'package:new_pubup_partner/utils/string_to_int.dart';
//
// import '../../../config/theme.dart';
// import '../../common_widgets/custom_button.dart';
// import '../../common_widgets/custom_text_field.dart';
// import '../event_controller/event_controller.dart';
// import '../model/EventPostModel.dart';
// import '../model/event_table_model.dart';
// import '../widget/ticket_button.dart';
// class EventAddTable extends StatefulWidget {
//   const EventAddTable({super.key});
//
//   @override
//   State<EventAddTable> createState() => _EventAddTableState();
// }
//
// class _EventAddTableState extends State<EventAddTable> {
//
//   bool isTicketFree=false;
//   // List<String> ticketType=["Single Male", "Single Female", "Couple"];
//
//
//   @override
//   Widget build(BuildContext context) {
//
//     return Container(
//       margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
//       child: SingleChildScrollView(
//         child: Form(
//           key: EventController.addTableFormKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               Text("Add Tables to Event",
//                 style: context.titleLarge(),),
//               10.height(),
//               Text("Add Ticket to your events",
//                 style: context.titleSmall(),),
//               10.height(),
//
//               Wrap(
//                 children: EventController.listEventTable.map((item)=>  PremiumTicketButton(
//                   title: item.numberOfTables??'',
//                   ticketType: '', onEdit: () {  }, onDelete: () {
//                   setState(() {
//                     EventController.listEventTable.remove(item);
//                   });
//
//                 }, price: '${item.tablePrice}',
//                 )).toList(),
//               ),
//
//
//               10.height(),
//
//               CustomTextField(
//                 isNumber: true,
//                 validator: (String? data){
//                   if(data?.isEmpty??true){
//                     return "Enter Description";
//                   }
//                 },
//
//                 textController: EventController.numbTableController,
//                 title: "Number of Tables",
//                 placeHolderText: "e.g 100",
//
//               ),
//               20.height(),
//               CustomTextField(
//                 isNumber: true,
//                 validator: (String? data){
//                   if(data?.isEmpty??true){
//                     return "Enter sitting capacity";
//                   }
//                 },
//
//                 textController: EventController.sittingTableController,
//                 title: "Sitting Capacity",
//                 placeHolderText: "",
//
//               ),
//               20.height(),
//
//
//
//           CustomTextField(
//                 validator: (String? data){
//                   if(data?.isEmpty??true&&(!isTicketFree)){
//                     return "Enter Table Price";
//                   }
//                 },
//
//
//                 textController: EventController.priceTableController,
//                 title: "Table Price",
//                 isNumber: true,
//
//               ),
//               20.height(),
//               20.height(),
//
//
//
//               CustomTextField(
//                 validator: (String? data){
//                   if(data?.isEmpty??true&&(!isTicketFree)){
//                     return "Enter Cover Charges";
//                   }
//                 },
//                 textController: EventController.coverChargeTableController,
//                 title: "Cover Charges",
//               ),
//               20.height(),
//
//               Align(alignment: Alignment.center,
//                   child:    FloatingActionButton(
//                     backgroundColor: AppColors.black,
//                     onPressed: (){
//                       if(EventController.addTableFormKey.currentState?.validate()??false){
//
//
//                         setState(() {
//                           EventController.listEventTable.add(EventTableModel(
//
//                              numberOfTables : EventController.numbTableController.text,
//                               tablePrice:stringToInt(EventController.priceTableController.text),
//                           sittingCapacity: EventController.sittingTableController.text,
//                             coverCharges: EventController.coverChargeTableController.text
//                           ));
//                           Future.delayed(Duration(seconds: 1),(){
//                             EventController.numbTableController.clear();
//                             EventController.priceTableController.clear();
//                             EventController.sittingTableController.clear();
//                             EventController.coverChargeTableController.clear();
//                           });
//                         });
//                       }else{
//                         showToast("Enter Valid Data");
//                       }
//
//                     },child: Icon(Icons.add),)
//               )
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
//






import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/features/event/load_save_event.dart';
import 'package:new_pubup_partner/utils/string_to_int.dart';

import '../../../config/theme.dart';
import '../../common_widgets/custom_button.dart';
import '../../common_widgets/custom_text_field.dart';
import '../event_controller/event_controller.dart';
import '../model/EventPostModel.dart';
import '../model/event_table_model.dart';
import '../widget/ticket_button.dart';

class EventAddTable extends StatefulWidget {
  const EventAddTable({super.key});

  @override
  State<EventAddTable> createState() => _EventAddTableState();
}

class _EventAddTableState extends State<EventAddTable> {

  bool _validateTableFields() {
    if (EventController.numbTableController.text.trim().isEmpty) {
      showToast("Enter Number of Tables");
      return false;
    }
    if (EventController.sittingTableController.text.trim().isEmpty) {
      showToast("Enter Sitting Capacity");
      return false;
    }
    if (EventController.priceTableController.text.trim().isEmpty) {
      showToast("Enter Table Price");
      return false;
    }
    if (EventController.coverChargeTableController.text.trim().isEmpty) {
      showToast("Enter Cover Charges");
      return false;
    }
    return true;
  }

  void _addTableAndClear() {
    if (!_validateTableFields()) {
      return;
    }
    EventController.listEventTable.add(EventTableModel(
        numberOfTables : EventController.numbTableController.text,
        tablePrice: stringToInt(EventController.priceTableController.text),
        sittingCapacity: EventController.sittingTableController.text,
        coverCharges: EventController.coverChargeTableController.text
    ));
    // Clear fields
    EventController.numbTableController.clear();
    EventController.priceTableController.clear();
    EventController.sittingTableController.clear();
    EventController.coverChargeTableController.clear();
    LoadSaveEvent.instance.saveEventToHive();
    setState(() {});
  }

  void _addTableAndNext() {
    hideKeyboard();
    LoadSaveEvent.instance.saveEventToHive();
    if (EventController.numbTableController.text.trim().isNotEmpty) {
      if (!_validateTableFields()) {
        return;
      }
      EventController.listEventTable.add(EventTableModel(
          numberOfTables : EventController.numbTableController.text,
          tablePrice: stringToInt(EventController.priceTableController.text),
          sittingCapacity: EventController.sittingTableController.text,
          coverCharges: EventController.coverChargeTableController.text
      ));
      // Clear fields
      EventController.numbTableController.clear();
      EventController.priceTableController.clear();
      EventController.sittingTableController.clear();
      EventController.coverChargeTableController.clear();
    }
    // Move to next regardless
    EventController.eventPageController.animateToPage(
      3,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: EventController.addTableFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Add Tables to Event",
                style: context.titleLarge(),),
              10.height(),
              Text("Add Tables to your events",
                style: context.titleSmall(),),
              10.height(),
              Wrap(
                children: EventController.listEventTable.map((item)=>  PremiumTicketButton(
                  title: item.numberOfTables??'',
                  ticketType: '', onEdit: () {  }, onDelete: () {
                  setState(() {
                    EventController.listEventTable.remove(item);
                  });

                }, price: '${item.tablePrice}',
                )).toList(),
              ),
              10.height(),
              CustomTextField(
                isNumber: true,
                // Removed validator
                textController: EventController.numbTableController,
                title: "Number of Tables",
                placeHolderText: "e.g 100",
              ),
              20.height(),
              CustomTextField(
                isNumber: true,
                // Removed validator
                textController: EventController.sittingTableController,
                title: "Sitting Capacity",
                placeHolderText: "",
              ),
              20.height(),
              CustomTextField(
                // Removed validator
                textController: EventController.priceTableController,
                title: "Table Price",
                isNumber: true,
              ),
              20.height(),
              CustomTextField(
                // Removed validator
                textController: EventController.coverChargeTableController,
                title: "Cover Charges",
              ),
              20.height(),
              Text(
                "If you have multiple table types",
                style: const TextStyle(color: Colors.red),
              ),
              10.height(),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      buttonColor: AppColors.black,
                      buttonText: "+ Add More Tables",
                      onPress: _addTableAndClear,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomButton(
                      buttonColor: Colors.amber,
                      buttonText: "Next",
                      onPress: _addTableAndNext,
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