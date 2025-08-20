import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import '../../config/theme.dart';

class CustomButton extends StatelessWidget {
  const    CustomButton({
    super.key,
    required this.buttonText,
    this.buttonColor,
    this.buttonTextColor = AppColors.white,
    required this.onPress,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.useFullWidth,
    this.cornerRadius,
    this.maxLines,
    this.id,
    this.textAlign,
    this.height,
    this.gradient,
  });

  final void Function()? onPress;
  final String buttonText;
  final Color? buttonColor;
  final Color buttonTextColor;
  final EdgeInsets padding;
  final bool? useFullWidth;
  final double? cornerRadius;
  final double? height;
  final int? maxLines;
  final String? id;
  final TextAlign? textAlign;
  final Gradient? gradient;

  @override
  Widget build(BuildContext context) {
    final bool isFullWidth = useFullWidth ?? false;
    final BorderRadius radius =
    BorderRadius.circular(cornerRadius ?? AppSizes.buttonRadius * 1.5);

    final child = InkWell(
      borderRadius: radius,
      onTap: onPress,
      splashColor: AppColors.white.withOpacity(0.15),
      child: Ink(
        decoration: BoxDecoration(
          color: gradient == null ? buttonColor ?? AppColors.themeColor : null,
          gradient: gradient,
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: (buttonColor ?? AppColors.themeColor).withOpacity(0.35),
              offset: const Offset(0, 4),
              blurRadius: 12,
            ),
          ],
        ),
        child: Container(
          padding: padding,
          height: height ?? 48,
          alignment: Alignment.center,
          child: Text(
            buttonText,
            style: context.bodyMedium()?.copyWith(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: buttonTextColor,
              letterSpacing: 0.5,
            ),
            maxLines: maxLines,
            overflow: TextOverflow.ellipsis,
            textAlign: textAlign ?? TextAlign.center,
          ),
        ),
      ),
    );

    return SizedBox(
      width: isFullWidth ? DeviceSize.screenWidth(context) - 40 : null,
      child: child,
    );
  }
}
