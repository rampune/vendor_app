import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/config.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';
class DashboardCard extends StatelessWidget {
  const DashboardCard({
    super.key,
    required this.iconData,
    required this.title,
    required this.callback,
  });
  final String title;
  final IconData iconData;
  final GestureTapCallback callback;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: callback,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: isDark(context)?AppColors.darkThemeColor:null,
          border: Border.all(color: AppColors.darkGray.withOpacity(0.3), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor:isDark(context)?AppColors.black :AppColors.themeColor.withOpacity(0.15),
              radius: 24,
              child: Icon(iconData, size: 26,
                color: isDark(context)?AppColors.darkGray:AppColors.black,
              ),
            ),
            20.width(),
            Expanded(
              child: Text(
                title,
                style: context.titleSmall()?.copyWith(
fontWeight: FontWeight.bold,

                ),
              ),
            ),
            Icon(Icons.chevron_right, size: 28),
          ],
        ),
      ),
    );
  }
}
