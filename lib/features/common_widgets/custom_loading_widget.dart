import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/theme.dart';
class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator(
      backgroundColor: AppColors.black,
      color: AppColors.themeColor,

    ),);
  }
}
