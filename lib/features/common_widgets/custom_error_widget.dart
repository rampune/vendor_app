import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key,this.retryCallBack,this.msg});
  final GestureTapCallback ?retryCallBack;
  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Center(child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        20.height(),
        Text(msg??"Something wrong try again",
        maxLines: 3,
          overflow: TextOverflow.ellipsis,
        ),
        30.height(),
        Icon(Icons.error_outline,color: AppColors.red,),
        20.height(),
        CustomButton(buttonText: "Retry", onPress: retryCallBack,

        )
      ],

    ),

    );
  }
}
