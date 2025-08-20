
import 'package:flutter/material.dart';
class CustomIconWithTitle extends StatelessWidget {
  const CustomIconWithTitle({super.key,required this.iconData,
  required this.title,
  this.onTap});
final iconData;
final String title;
final GestureTapCallback ?onTap;
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(iconData,size: 50,),
          Text(title)
        ],),
    );
  }
}
