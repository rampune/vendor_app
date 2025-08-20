import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';


import '../../config/theme.dart';
class BookButton extends StatelessWidget {
  const BookButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      decoration: BoxDecoration(
          color: AppColors.blue,
          border: Border.all(color: AppColors.white),
          borderRadius: BorderRadius.circular(7)
      ),
      child: Text("Book Now",
        style: context.titleSmall()?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.white
        ),),
    );
  }
}
