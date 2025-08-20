import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/assets.dart';
import 'package:new_pubup_partner/config/extensions.dart';
class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({super.key,required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppAssetsPath.emptyImg),
          10.height(),
          Text(message,style: context.titleSmall(),)
        ],),
    );
  }
}
