import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import '../../../../config/theme.dart';
import '../../model/EventPostModel.dart';
class EventView extends StatelessWidget {
  const EventView({super.key,required this.getEventModel,this.isDelete=true,this.isEdit=true});
  final EventPostModel  getEventModel;
  final bool isDelete,isEdit;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            keyValueText("Event Name", getEventModel.eventName??'',context),
            10.height(),
              keyValueText("Event Date", getEventModel.eventDate??"",context,valueColor: AppColors.green),
              10.height(),
              keyValueText("Event Time", "${getEventModel.startTime} To ${getEventModel.startTime}",context,valueColor: AppColors.green),
              10.height(),
            keyValueText("Venue", getEventModel.venue??'',context),
          10.height(),
              keyValueText("Ticket Price", "${ticketStringToModel(getEventModel.ticketModelInString)?.
              map((item)=>"${item.ticketType} - ${item.price} ").toList()}",context),
          10.height(),
            ],),

          Positioned(
              right: 10,
              top: 10,
              child: Column(
                children: [
                  if(!(getEventModel.status?.toLowerCase().trim().contains("upcoming")??false))  IconButton(onPressed: (){},
                   icon:Icon(Icons.delete,color: AppColors.redLight,
               size: 20,)),
          ],))
        ],
      ),
    );
  }
  keyValueText(String key,String value,BuildContext context,{Color ?valueColor}){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text("$key",
            style: context.bodySmall()?.copyWith(
                fontWeight: FontWeight.bold
            ),),
        ),

Text(":"),
        10.width(),

        Expanded(
            flex: 6,
            child: Text("$value", style: context.bodySmall()?.copyWith(
                color: valueColor
            ),
              textAlign: TextAlign.left,))
      
      
    ],);
  }
  
 List<TicketModel> ?ticketStringToModel(String ? rawString){
    List<TicketModel> ?listTicketModel;
    try{
      print("$rawString");

List<dynamic> listDynamic=jsonDecode(rawString??'');
   listTicketModel=   listDynamic.map((item) => TicketModel.fromJson(item)).toList();
      return listTicketModel;
      
    }catch(exception){
      
print("--$exception");
      return null;
    }

      
  }
}
