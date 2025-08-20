import 'dart:math';

import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/config.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/working_hours_bottom_sheet_widget.dart';
class WorkingHourTile extends StatelessWidget {
  const WorkingHourTile({super.key,
  required this.day,this.onTap,this.isOn,this.subTitle,this.leadingCallBack});
final String day;
final GestureTapCallback? onTap;
final String? subTitle;
final bool?isOn;
final GestureTapCallback? leadingCallBack;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        onTap: leadingCallBack,
        child: Icon(Icons.arrow_drop_down_sharp,size: 35,
        color: isDark(context)?AppColors.darkGray:null,
        ),
      ),
      trailing: InkWell(
          onTap: onTap,
          child: OnOFFs(isON: isOn??false,)),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: AppColors.darkGray,),
        borderRadius: BorderRadius.circular(10)

      ),
      title: Text(day,style: context.titleSmall()?.copyWith(
        fontWeight: FontWeight.bold
      ),),
      // subtitle: Text("---- ",style: context.bodySmall()?.copyWith(
      //   color: AppColors.darkGray
      // ),),


    );
  }
}
class OnOFFs extends StatefulWidget {
  const OnOFFs({super.key,required this.isON});
  final bool isON;

  @override
  State<OnOFFs> createState() => _OnOFFsState();
}

class _OnOFFsState extends State<OnOFFs> {

  List<Icon> iconList=[Icon(Icons.toggle_on,size: 50,
  color: AppColors.green,
  ),Icon(Icons.toggle_off_outlined,size: 50,color: AppColors.red,)];
  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 50,
      child: widget.isON?iconList[0]:iconList[1],);
  }
}
