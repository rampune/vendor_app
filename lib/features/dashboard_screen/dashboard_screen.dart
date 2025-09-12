import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/routes.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/common_widgets/premium_drawer.dart';
import 'package:new_pubup_partner/features/dashboard_screen/bloc/status_bloc.dart';
import 'package:new_pubup_partner/features/dashboard_screen/widgets/dashboard_card.dart';
import 'package:new_pubup_partner/promotion/promotion.dart';
import '../../config/config.dart';
import '../../config/theme.dart';
import '../../data/source/local/hive_box.dart';
import '../common_widgets/custom_scaffold.dart';
import '../common_widgets/promotion_card.dart';
import 'model/dashboard_model.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
  StatusBloc statusBloc = StatusBloc();
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return CustomScaffold(
      scaffoldKey: scaffoldKey,
      drawer: PremiumAnimatedDrawer(
        onClose: () {
          askConfirmation(context, "Are you sure for logout",confirmCallBack: (){
            MyHiveBox.instance.getBox().delete("login");
            MyHiveBox.instance.getBox().clear();
            Navigator.pushNamedAndRemoveUntil(context, AppRoutes.partnerLogin, (
                Route<dynamic> route,
                ) {
              print("amra007-------${route}");
              return false;
            });
            scaffoldKey.currentState?.closeDrawer();
          });

        },
      ),
      appBar: AppBar(

        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              scaffoldKey.currentState?.openDrawer();
            },
            child:  Icon(Icons.menu, color:isDark(context)?AppColors.darkGray: AppColors.black),
          ),
        ),
        title: Text(
          "Pubup Partner",
          style: context.titleSmall()?.copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor:AppColors.themeColor,
        foregroundColor: AppColors.black,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {

              Navigator.pushNamed(context, AppRoutes.notificationScreen,arguments: BusinessProfileData.vendorId()??'' );
            },
            icon:  Icon(
              Icons.notifications_active,
              color:   isDark(context)?AppColors.darkGray: AppColors.black

            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocListener<StatusBloc, StatusState>(
              bloc: statusBloc,
              listener: (BuildContext context, StatusState state) {
                state is StatusLoadingState
                    ? OverlayLoadingProgress.start(context)
                    : OverlayLoadingProgress.stop();
          if (state is StatusKycApprovalState) {
            Navigator.pushNamed(context, AppRoutes.eventBooking);
                } else if (state is StatusKycRejectedState) {
            askConfirmation(
                heading:Text("KYC Rejected",style: context.titleMedium()?.
                  copyWith(fontWeight: FontWeight.bold,color: AppColors.redLight)
                  ,),
                context, "${state.message}  \n\n\nConfirm if you want resend",
                confirmCallBack: (){
                  Navigator.pushNamed(context, AppRoutes.kyc);
                }
            );
                } else if (state is StatusKycPendingState) {
                  showAlert(context, "Your KYC application is currently under review. We’ll notify you once the verification is complete.");
                } else if (state is StatusKycFreshUserState) {
                 askConfirmation(context, "You need complete kyc first",
                 confirmCallBack: (){
               Navigator.pushNamed(context, AppRoutes.kyc);
                 }
                 );
                }else if(state is  StatusErrorState){
            showAlert(context, "Something wrong try again");
          }   },
              child: SizedBox.shrink(),
            ),
        

            SizedBox(
        
                height: 250,
                child
                : PromotionCardSlider()
            ),
            InkWell(
              onTap: () {
                Navigator.pushNamed(context, AppRoutes.sponsorAdsScreen);
              },
              child: Container(
                height: 45,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: dynamicThemeColor(context),
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Center(
                  child: Marquee(
                    text: 'Sponsored Banner Advertisement',
                    style: context.titleLarge()?.copyWith(
        
                    ),
                    scrollAxis: Axis.horizontal,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    pauseAfterRound: const Duration(seconds: 1),
                    startPadding: 10.0,
                    accelerationDuration: const Duration(seconds: 1),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
              ),
            ),
            10.height(),
            Expanded(
              child: ListView.builder(
                itemCount: DashboardModel.listDashboardModel.length,
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final item = DashboardModel.listDashboardModel[index];
                  return DashboardCard(
                    iconData: item.iconData,
                    title: item.title,
                    callback: () async{
                      if (DashboardModel.listDashboardModel[index].path ==
                          "newEvent") {
                        statusBloc.add(
                          StatusGetKycEvent(
                            vendorId: BusinessProfileData.vendorId() ?? '',
                          ),
                        );
                      } else {
                Navigator.pushNamed(
                          context,
                          DashboardModel.listDashboardModel[index].path,
                  arguments:BusinessProfileData.vendorId(),
                        );
                      }
        
        
                      // Navigator.pushNamed(context, item.path);
                    },
                  );
                },
              ),
            ),
        
          ],
        ),
      ),
    );
  }
}
