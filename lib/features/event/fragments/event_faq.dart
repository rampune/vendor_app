import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import '../../admin_details/widget/custom_drop_down/custom_drop_down.dart';
import '../event_controller/event_controller.dart';
import '../model/event_faq_model.dart';
import '../widget/yes_no_toggle.dart';
class EventFaq extends StatefulWidget {
  const EventFaq({super.key});
  @override
  State<EventFaq> createState() => _EventFaqState();
}
class _EventFaqState extends State<EventFaq> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: EventController.bookingFaqFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("FAQ for Event",
                style: context.titleLarge(),),
              10.height(),
              Text("Submit FAQ for this Event",
                style: context.titleSmall(),),

              20.height(),
              CustomDropDown(
                placeHolder: "choose parking type",
                  title: "Is there Parking available",
                  controller: EventController.parkingTypeCotroller,
                  validator: (String? data){
                  if(data?.isEmpty??true){
                    return "choose parking type";
                  }
                  },
                  listCustomDropDownModel: [
                    CustomDropDownModel(name: "Pay & Park"),
                    CustomDropDownModel(name: "Wallet Parking"),
                    CustomDropDownModel(name: "No"),
                  ], onSelect: (CustomDropDownModel model){

              }),20.height(),

              Wrap(
                runSpacing: 20,
                spacing: double.infinity,
                children: EventFaqModel.loadFaq().where((item)=>item.isFaq==true).map((item)=>YesNoToggle(title: item.question,isYes: item.answer,callBack: (bool value){
                  EventFaqModel.saveFaq(key: item.question, value: value);
                },)).toList(),),
            ],),
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}





