import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/features/admin_details/widget/custom_drop_down/custom_drop_down.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_file_picker_container.dart';
import 'package:new_pubup_partner/features/event/model/event_faq_model.dart';


import '../../common_widgets/custom_text_field.dart';
import '../event_controller/event_controller.dart';
import '../widget/yes_no_toggle.dart';
class EventBook3 extends StatefulWidget {
  const EventBook3({super.key});

  @override
  State<EventBook3> createState() => _EventBook3State();
}

class _EventBook3State extends State<EventBook3> with AutomaticKeepAliveClientMixin{
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: EventController.booking3FromKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Turn vibes Into Bookings",
                style: context.titleLarge(),),
              10.height(),
              Text("Get Discovered by the right crowd .Post your event in minutes.",
                style: context.titleSmall(),),
              20.height(),
              CustomDropDown(
                  title: "Minimum Age Requirements",
                  controller: EventController.minimumAgeRequired,
                  listCustomDropDownModel: [
                    CustomDropDownModel(name: "2 Year & Above"),
                    CustomDropDownModel(name: "5 Year & Above"),
                    CustomDropDownModel(name: "12 Year & Above"),
                    CustomDropDownModel(name: "Minimum 16 Years"),
                    CustomDropDownModel(name: "Minimum 18 Years")
                  ], onSelect: (CustomDropDownModel model){

                  },
                validator: (String ? data){
                    if(data?.isEmpty??true){
                      return "please select minimum age";

                    }
                },


                  ),
              20.height(),
Wrap(
  runSpacing: 20,
  spacing: double.infinity,
  children: EventFaqModel.loadFaq().where((item)=>item.isFaq!=true).map((item)=>YesNoToggle(title: item.question,isYes: item.answer,callBack: (bool value){
    EventFaqModel.saveFaq(key: item.question, value: value);
  },)).toList(),),


              20.height(),
              CustomDropDown(
                  title: "Venue Layout",
                  controller: EventController.venueLayout,
                  listCustomDropDownModel: [
                    CustomDropDownModel(name: "Indoor"),
                    CustomDropDownModel(name: "Outdoor"),
                    CustomDropDownModel(name: "Both"),
                  ], onSelect: (CustomDropDownModel model){

                  },

                validator: (String ? data){
                  if(data?.isEmpty??true){
                    return "please select minimum age";

                  }
                },
              ),
              20.height(),
              CustomFilePickerContainer(title: "Venue Layout",
                  controller: EventController.venueLayoutPhoto,
                validator: (String ? data){
                  if(data==AppStr.filePickerDefaultText){
                    return "please select minimum age";

                  }
                },
              ),
              20.height(),
              CustomFilePickerContainer(title: "Gallery",
                  controller: EventController.venueGalleryPhoto1,
                validator: (String ? data){
                  if(data==AppStr.filePickerDefaultText){
                    return "please select minimum age";

                  }
                },
              ),

              CustomFilePickerContainer(title: "Gallery",
                controller: EventController.venueGalleryPhoto2,
                validator: (String ? data){
                  if(data==AppStr.filePickerDefaultText){
                    return "please select minimum age";

                  }
                },
              ),
              CustomFilePickerContainer(title: "Gallery",
                controller: EventController.venueGalleryPhoto3,
                validator: (String ? data){
                  if(data==AppStr.filePickerDefaultText){
                    return "please select minimum age";

                  }
                },
              )





            ],),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

}






