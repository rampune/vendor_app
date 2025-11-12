import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';

import '../../common_widgets/custom_text_field.dart';
import '../event_controller/event_controller.dart';
class EventTC extends StatelessWidget {
  const EventTC({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: EventController.booingTcFormKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Term & Conditions",
                style: context.titleLarge(),),
              10.height(),
              Text("Describe Term & conditions in 200 words",
                style: context.titleSmall(),),
              20.height(),
              CustomTextField(
                  title: "Term & Conditions",
                  placeHolderText: "200 Words Only",
                  maxLines: 20,
                  minLines: 20,
                  validator: (String? data){
                    if((data?.length??0)<5){
                      return "Enter Minimum 5 char";
                    }
                  },
                  textController: EventController.eventTermAndCondition),
              20.height(),
            ],),
        ),
      ),
    );
  }
}




