import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/data/source/local/hive_box.dart';
import 'package:new_pubup_partner/features/admin_details/widget/custom_drop_down/custom_drop_down.dart';

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

bool isTicketFree=false;
  List<String> ticketType=["Single Male", "Single Female", "Couple"];
  @override
  Widget build(BuildContext context) {
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



              ///Amara ram old code with dropdown
              // CustomDropDown(controller: EventController.ticketType,
              //     heading: "Ticket Type",
              //     title: "Ticket Type 1",
              //     validator: (String? data){
              //   if(data?.isEmpty??true){
              //     return "Choose Ticket type";
              //   }
              //     },
              //     listCustomDropDownModel:ticketType.map((item)=>
              //         CustomDropDownModel(name: item,)).toList(),
              //
              //
              //     onSelect: (CustomDropDownModel selected){
              //
              //     }),


              ///Saransh new code with with text field
              CustomTextField(
                validator: (String? data){
                  if(data?.isEmpty??true){
                    return "Enter Type";
                  }
                },
                textController: EventController.ticketType,
                title: "Ticket Type",
                placeHolderText: "e.g Single, double",

              ),




              10.height(),
              CustomTextField(
                validator: (String? data){
                  if(data?.isEmpty??true){
                    return "Enter Description";
                  }
                },

                textController: EventController.ticketDescription,
                title: "Ticket Description",
                placeHolderText: "e.g Early Bird,Express Entry",

              ),
              20.height(),


              YesNoToggle(title: "Ticket Free",callBack: (bool result){
                print("$result");
                setState(() {
                  isTicketFree=result;
                });
              },),

              10.height(),
            if(!isTicketFree)  CustomTextField(
              validator: (String? data){
                if(data?.isEmpty??true&&(!isTicketFree)){
                  return "Enter Ticket Price";
                }
              },


                textController: EventController.ticketPrice,
                title: "Ticket Price",
                isNumber: true,

              ),
              20.height(),
              CustomTextField(
                validator: (String? data){
                  if(data?.isEmpty??true){
                    return "Enter CoverCharges";
                  }
                },

                textController: EventController.ticketCoverCharges,
                title: "Cover Charges",
                placeHolderText: "",

              ),
              20.height(),

             Align(alignment: Alignment.center,
              child:    FloatingActionButton(
                backgroundColor: AppColors.black,
                onPressed: (){
          if(EventController.booking2FormKey.currentState?.validate()??false){
            // if(ticketType.contains("${EventController.ticketType.text}")){
            //   EventController.listTickets= EventController.listTickets.where((ticket)=>ticket.ticketType!="${EventController.ticketType.text}").toList();
            // }


            setState(() {
          TicketModel ticketModel= TicketModel(ticketType:
              EventController.ticketType.text,
                  price:isTicketFree?0:stringToInt(EventController.ticketPrice.text,
                  ),
                  description: EventController.ticketDescription.text,
                  coverCharges: EventController.ticketCoverCharges.text,
                  isFree: isTicketFree
              );
              EventController.listTickets.add(ticketModel);
        Future.delayed(Duration(seconds: 1),(){
          EventController.ticketDescription.clear();
          EventController.ticketPrice.clear();
          EventController.ticketType.clear();
        });
            });
          }else{
            showToast("Enter Valid Data");
          }

                },child: Icon(Icons.add),)
             ),




            ],),
        ),
      ),
    );
  }
}
