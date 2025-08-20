import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/features/business_hours/model/business_hour_model.dart';
class CustomSlotCard extends StatelessWidget {
  const CustomSlotCard({super.key,required this.slot,this.onTap});
  final Slot slot;
  final GestureTapCallback ?onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
      margin: EdgeInsets.only(right: 5,top: 5),
      decoration:
      BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: AppColors.darkGray)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("${slot.slotName}",
                style: context.bodySmall()?.copyWith(
                  fontWeight: FontWeight.bold
                ),),
              10.width(),
              InkWell(
                  onTap: onTap,
                  child: Icon(Icons.close,size: 20,color: AppColors.redLight,))
          ],),
5.height(),
          Text("${slot.startTime} - ${slot.endTime} ",
          style: context.bodySmall(),),
        ],
      ),);
  }
}
