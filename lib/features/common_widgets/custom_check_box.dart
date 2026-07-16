import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
class CustomCheckBox extends StatefulWidget {
  const CustomCheckBox({super.key,required this.title,required this.callBack,this.imgUrl, this.initialValue = false});
  final String title;
  final Function(bool) callBack;
  final String? imgUrl;
  final bool initialValue;
  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}
class _CustomCheckBoxState extends State<CustomCheckBox> {
  late bool isCheck;

  @override
  void initState() {
    super.initState();
    isCheck = widget.initialValue;
  }

  @override
  void didUpdateWidget(covariant CustomCheckBox oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialValue != widget.initialValue) {
      isCheck = widget.initialValue;
    }
  }
  @override
  Widget build(BuildContext context) {
    return         Row(

      children: [
      Checkbox(value: isCheck, onChanged: (bool?value){
        if(value!=null){
          widget.callBack(value);
          setState(() {
            isCheck=value;
          });
        }
      }),
      Text(widget.title,
        style: context.titleSmall()?.copyWith(),),
      Expanded(child: Text("")),
      SizedBox(
        height: 35,width: 40,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100),
          child: Image.network(
              fit: BoxFit.fill,
              widget.imgUrl??"https://picsum.photos/id/237/200/300"),
        ),),
        20.width(),

    ],);
  }
}
