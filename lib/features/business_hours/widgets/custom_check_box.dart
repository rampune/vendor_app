// import 'package:flutter/material.dart';
// import 'package:new_pubup_partner/config/extensions.dart';
// class CustomCheckBox extends StatefulWidget {
//   const CustomCheckBox({super.key,required this.title,required this.callBack});
//   final String title;
//   final Function(bool) callBack;
//
//   @override
//   State<CustomCheckBox> createState() => _CustomCheckBoxState();
// }
//
// class _CustomCheckBoxState extends State<CustomCheckBox> {
//   bool isCheck=false;
//   @override
//   Widget build(BuildContext context) {
//     return         Row(children: [
//       Checkbox(value: isCheck, onChanged: (bool?value){
// if(value!=null){
//   widget.callBack(value);
//   setState(() {
//     isCheck=value;
//   });
// }
//       }),
//       Text(widget.title,
//         style: context.titleSmall()?.copyWith(),)
//
//     ],);
//   }
// }
