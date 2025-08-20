import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';

import '../../config/config.dart';
import '../../config/theme.dart';
import '../models/group_toggle_button_model.dart';

class CustomGroupToggle extends StatefulWidget {
  const CustomGroupToggle({super.key,
    required this.listGroupToggleModel,this.selectedIndex,
  required this.callBack});
  final List<GroupToggleButtonModel> listGroupToggleModel;
  final int ?selectedIndex;
  final Function(int) callBack;


  @override
  State<CustomGroupToggle> createState() => _CustomGroupToggleState();
}

class _CustomGroupToggleState extends State<CustomGroupToggle> {
  int groupId = -1;
 @override
  void initState() {

    if(widget.selectedIndex!=null){
      groupId=widget.selectedIndex??-1;
    }

  }
  @override
  Widget build(BuildContext context) {

List<GroupToggleButtonModel> list=widget.listGroupToggleModel;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(list.length,


              (index)=>
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          groupId = groupId==index?groupId=-1:groupId=index;
                          print("$index");
                        widget.callBack(groupId);
                        });
                      },
                      child: SimpleOutlineButton(
                        icon:list[index].iconData,
                        title: list[index].title,
                        backgroundColor: groupId == index ? dynamicThemeColor(context) : null,
                      ),
                    ),
                  )
      ),
    );
  }
}




class SimpleOutlineButton extends StatelessWidget {
  const SimpleOutlineButton({
    super.key,
    required this.title,
    this.icon,
    this.backgroundColor,
    this.onTap,
    this.textColor

  });

  final String title;
  final IconData? icon;
  final GestureTapCallback ?onTap;
  final Color? backgroundColor,textColor;

  @override
  Widget build(BuildContext context) {
    final themeColor = dynamicThemeColor(context);
    final isSelected = backgroundColor != null;

    return Material(
      elevation: isSelected ? 6 : 0,
      borderRadius: BorderRadius.circular(12),
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: InkWell(
          onTap: onTap,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: backgroundColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? themeColor : AppColors.darkGray,
                width: 1.2,
              ),
              boxShadow: isSelected
                  ? [
                BoxShadow(
                  color: themeColor.withOpacity(0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                )
              ]
                  : [],
            ),
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 250),
              style: context.bodySmall()!.copyWith(
                color: isSelected ? Colors.white : AppColors.darkGray,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
              ),
              child: Text(title,maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: context.bodySmall()?.copyWith(
                  color: textColor
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
