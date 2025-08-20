import 'package:flutter/material.dart';

class CustomViewPager extends StatelessWidget {
  const CustomViewPager(
      {super.key,
      required this.callBack,
    required  this.listScreens,
      required this.controller,
      this.isScroll=true});
  final Function(int) callBack;
  final List<Widget> listScreens;
  final PageController controller;
  final bool isScroll;
  @override
  Widget build(BuildContext context) {
    return PageView(
      physics:isScroll?null: const NeverScrollableScrollPhysics(),
      controller: controller,
      onPageChanged: (index) {
        print(index.toString());
        callBack(index);
      },
      children: listScreens
    );
  }
}
