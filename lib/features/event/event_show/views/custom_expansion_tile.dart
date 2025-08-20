import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';
class CustomExpansionTile extends StatelessWidget {
  const CustomExpansionTile({super.key,required this.title,required this.children,this.leadingIcon});
  final String title;
  final List<Widget> children;
  final IconData ?leadingIcon;

  @override
  Widget build(BuildContext context) {
    return  ExpansionTile(title: Text(title,style: context.titleSmall(),),
    shape: tileBorder(),
  collapsedShape: tileBorder(),
      leading: Icon(leadingIcon),
  children: children,

    );
  }
 RoundedRectangleBorder tileBorder(){
    return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: AppColors.darkGray)
    );
  }
}
