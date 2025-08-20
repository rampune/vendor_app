import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import '../../config/config.dart';
import '../../config/theme.dart';
class SuffixIconButton extends StatelessWidget {
  const SuffixIconButton({super.key,
  required this.title,this.isIcon=true,
    required this.onTap,this.backgroundColor,this.textColor});
final String title;
final bool isIcon;
final Color? backgroundColor,textColor;

final GestureTapCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color:backgroundColor?? dynamicWhiteBtnTheme(context)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),

          Text(title,
          style: context.titleSmall()?.copyWith(
            fontWeight: FontWeight.bold,
           color:textColor?? AppColors.black
          ),),
          isIcon?  Icon(Icons.arrow_circle_right_rounded ,
            color: Theme.of(context).primaryColor,):SizedBox.shrink()
        ],),

      ),
    );
  }
}
