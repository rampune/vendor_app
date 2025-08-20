import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';

import '../../../config/theme.dart';

class IconTitleCard extends StatelessWidget {
  const IconTitleCard({super.key,required this.title,
  required this.iconData});
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 40),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.darkGray)),
      child: Center(
        child: Row(

          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          Icon(iconData,size: 50,),
          40.width(),
          Text(title,
          textAlign: TextAlign.center,
          style: context.titleSmall()?.copyWith(
            fontWeight: FontWeight.normal
          ),)
        ],),
      ),
    );
  }
}
