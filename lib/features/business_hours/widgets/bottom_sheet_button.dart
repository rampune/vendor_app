import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';

import '../../../config/theme.dart';
class BottomSheetButton extends StatelessWidget {
  const BottomSheetButton({super.key,this.onTap});
  final GestureTapCallback ?onTap;

  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: AppColors.themeColor,
            borderRadius: BorderRadius.circular(10)

        ),
        child: Center(child: Text("Save",
          style: context.titleSmall()?.copyWith(
              color: AppColors.white,
              fontWeight: FontWeight.bold
          ),
        )),
      ),
    );
  }
}
