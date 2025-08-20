import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui' as img;
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/admin_details/widget/custom_drop_down/multi_select_drop_down.dart';
import '../../utils/pickers/pickers.dart';
import '../../utils/save_and_retrive_file.dart';
import '../admin_details/widget/custom_drop_down/custom_drop_down.dart';
class Test extends StatefulWidget {
  const Test({super.key});
  @override
  State<Test> createState() => _TestState();
}
class _TestState extends State<Test> {
  TextEditingController controller=TextEditingController();
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: AppBar(),
  body: Column(
    children:
    [
      MultiSelectDropDown(
        heading: "Select multiDropdown",
          controller: controller,
          listCustomDropDownModel: [
        CustomDropDownModel(name: "List 1",id: 2),
        CustomDropDownModel(name: "List 2",id: 4),
        CustomDropDownModel(name: "List 3",id: 6),
        CustomDropDownModel(name: "List 4",id: 8)

      ], onSelect: (value){
        print("value $value");
      })

  ],),
    );
  }
}
