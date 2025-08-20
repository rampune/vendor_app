import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/routes.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import '../../config/config.dart';
class PremiumAnimatedDrawer extends StatefulWidget {
  final Function() onClose;

  const PremiumAnimatedDrawer({super.key, required this.onClose});

  @override
  State<PremiumAnimatedDrawer> createState() => _PremiumAnimatedDrawerState();
}

class _PremiumAnimatedDrawerState extends State<PremiumAnimatedDrawer> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _offset = Tween<Offset>(begin: Offset(-1.0, 0), end: Offset.zero).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offset,
      child: Container(
        width: MediaQuery.of(context).size.width-100,
        color: AppColors.themeColor,
        child: SafeArea(
          child: Container(
            decoration:BoxDecoration(
              color:isDark(context)?AppColors.darkThemeColor.withOpacity(0.8) :AppColors.lighterGray.withOpacity(1),

            ),
            child: Column(
              children: [
                _buildHeader(context),
                Divider(thickness: 1.2, color:isDark(context)?AppColors.darkGray :Colors.grey.shade200),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 8),
                    children: [

                      _buildDrawerItem(context, icon: Icons.email, title: 'Email', route: AppRoutes.editProfile,
                          endIcon: Icons.edit,
                      subTitle: BusinessProfileData.getBusinessRegistrationData()?.businessData?.email
                      ),

                      _buildDrawerItem(context, icon: Icons.language, title: 'Website', route: AppRoutes.editProfile,
                          endIcon: Icons.edit,
                          subTitle: BusinessProfileData.getBusinessRegistrationData()?.businessData?.website
                      ),
                      _buildDrawerItem(context, icon: Icons.lock_clock, title: 'Operational Hours', route: AppRoutes.businessHoursScreen,
                      endIcon: Icons.edit),
                      _buildDrawerItem(context, icon: Icons.menu_book,
                          title: 'Food Menu', route: AppRoutes.menuScreen),
                      _buildDrawerItem(context, icon: Icons.info_outline,
                          title: 'About Pubup', route: AppRoutes.myWebView),
                      _buildDrawerItem(context, icon: Icons.lock, title: 'Privacy Policy', route: AppRoutes.myWebView),

                      _buildDrawerItem(context, icon: Icons.menu_book_rounded, title: 'Term & Conditions', route: AppRoutes.myWebView),

                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton.icon(
                    onPressed: widget.onClose,
                    icon: Icon(Icons.logout),
                    label: Text('Logout'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.redLight,
                      foregroundColor: Colors.white,
                      minimumSize: Size(double.infinity, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      elevation: 5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: dynamicThemeColor(context),

        borderRadius: BorderRadius.only(topRight: Radius.circular(0)),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor:isDark(context)? AppColors.darkGray:AppColors.white,
            child: Icon(Icons.person, size: 30, color:dynamicThemeColor(context)),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${BusinessProfileData.getBusinessRegistrationData()?.businessData?.businessRegistrationName}", style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold)),
              10.height(),
                Text("${BusinessProfileData.vendorId()}", style: context.bodySmall()?.copyWith(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          10.width()
        ],
      ),
    );
  }

  Widget _buildDrawerItem(BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
    IconData?endIcon,
    String? subTitle
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        if (ModalRoute.of(context)?.settings.name != route) {
        if(route==AppRoutes.editProfile){
          Navigator.pushNamed(context, route,arguments: title);
        }else{
          Navigator.pushNamed(context, route);
        }

        }
      },
      borderRadius: BorderRadius.circular(16),
      splashColor: AppColors.themeColor.withOpacity(0.1),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color:isDark(context) ?AppColors.black:Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.05),
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(icon, color: AppColors.black, size: 22),
                    SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(title, style: context.titleSmall()),
                          if(subTitle!=null)5.height(),
                        if(subTitle!=null)
                          Text(subTitle, style: context.bodySmall()),
                        ],
                      ),
                    ),
                    Icon(endIcon??Icons.keyboard_arrow_right_rounded, color: AppColors.black),
                  ],
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}
