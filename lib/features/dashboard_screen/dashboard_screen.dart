import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:marquee/marquee.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/routes.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/features/admin_details/bloc/save_details_bloc.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/common_widgets/premium_drawer.dart';
import 'package:new_pubup_partner/features/dashboard_screen/bloc/status_bloc.dart';
import 'package:new_pubup_partner/features/dashboard_screen/widgets/animated_pause_toggle.dart';
import 'package:new_pubup_partner/features/dashboard_screen/widgets/dashboard_card.dart';
import 'package:new_pubup_partner/features/dashboard_screen/widgets/pause_toggle_tooltip.dart';
import 'package:new_pubup_partner/promotion/promotion.dart';
import '../../config/config.dart';
import '../../config/theme.dart';
import '../../data/source/local/hive_box.dart';
import '../common_widgets/custom_scaffold.dart';
import 'model/dashboard_model.dart';
class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}
class _DashboardScreenState extends State<DashboardScreen> {
  StatusBloc statusBloc = StatusBloc();
  SaveDetailsBloc saveDetailsBloc = SaveDetailsBloc();
  String? _pendingNavigationPath;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  OverlayEntry? _tooltipOverlayEntry;
  final LayerLink _toggleLayerLink = LayerLink();
  bool _isTooltipVisible = true;
  bool _wasCurrentRoute = false;

  @override
  void dispose() {
    _removeTooltip();
    super.dispose();
  }

  void _removeTooltip() {
    _isTooltipVisible = false;
    if (_tooltipOverlayEntry != null) {
      final entry = _tooltipOverlayEntry!;
      _tooltipOverlayEntry = null;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        entry.remove();
      });
    }
  }

  void _showTooltipIfNeeded() {
    final bool hasDismissed = MyHiveBox.instance.getBox().get('has_dismissed_pause_toggle_tooltip', defaultValue: false);
    if (!hasDismissed && _isTooltipVisible) {
      _showTooltip();
    }
  }

  void _showTooltip() {
    if (_tooltipOverlayEntry != null) return;

    _tooltipOverlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          width: 240,
          child: CompositedTransformFollower(
            link: _toggleLayerLink,
            showWhenUnlinked: false,
            offset: const Offset(-155, 36),
            child: TooltipBubble(
              text: "By enabling this, your pub will be paused temporarily",
              onDismiss: () {
                _removeTooltip();
                MyHiveBox.instance.getBox().put('has_dismissed_pause_toggle_tooltip', true);
              },
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_tooltipOverlayEntry!);
  }

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    final bool isCurrentRoute = route?.isCurrent ?? true;
    if (isCurrentRoute && !_wasCurrentRoute) {
      _isTooltipVisible = true;
    }
    _wasCurrentRoute = isCurrentRoute;

    if (!isCurrentRoute) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _removeTooltip();
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showTooltipIfNeeded();
      });
    }
    return Listener(
      behavior: HitTestBehavior.translucent,
      onPointerDown: (_) {
        _removeTooltip();
      },
      child: CustomScaffold(
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
          BlocProvider(
            create: (context) => saveDetailsBloc,
            child: BlocConsumer<SaveDetailsBloc, SaveDetailsState>(
              bloc: saveDetailsBloc,
              listener: (context, state) {
                if (state is SaveBusinessDetailAlreadyFillState) {
                  // showToast("Pub status updated successfully");
                  debugPrint('Pub status updated successfully');
                } else if (state is SaveErrorState) {
                  showToast("Failed to update status: ${state.errorMsg}");
                }
              },
              builder: (context, state) {
                final businessData = BusinessProfileData.getBusinessRegistrationData()?.businessData;
                final bool isPaused = businessData?.isPubPause ?? false;
                final bool isLoading = state is SaveLoadingState;
                return CompositedTransformTarget(
                  link: _toggleLayerLink,
                  child: Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(right: 8),
                    child: AnimatedPauseToggle(
                      initialValue: isPaused,
                      isLoading: isLoading,
                      onChanged: (bool value) {
                        saveDetailsBloc.add(
                          SaveBusinessDetailsPatchFieldEvent(
                            mapData: {'isPubPause': value},
                            vendorId: BusinessProfileData.vendorId() ?? '',
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
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
                  final targetPath = _pendingNavigationPath == "newEvent"
                      ? AppRoutes.eventBooking
                      : (_pendingNavigationPath ?? AppRoutes.eventBooking);
                  _pendingNavigationPath = null;
                  Navigator.pushNamed(
                    context,
                    targetPath,
                    arguments: BusinessProfileData.vendorId(),
                  );
                } else if (state is StatusKycRejectedState) {
                  _pendingNavigationPath = null;
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
                  _pendingNavigationPath = null;
                  showAlert(context, "Your KYC application is currently under review. We’ll notify you once the verification is complete.");
                } else if (state is StatusKycFreshUserState) {
                  _pendingNavigationPath = null;
                  askConfirmation(context, "You need complete kyc first",
                  confirmCallBack: (){
                    Navigator.pushNamed(context, AppRoutes.kyc);
                  }
                  );
                } else if (state is StatusErrorState) {
                  _pendingNavigationPath = null;
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
                      final String currentPath = DashboardModel.listDashboardModel[index].path;
                      if (currentPath == "newEvent" ||
                          currentPath == AppRoutes.showEventScreen ||
                          currentPath == AppRoutes.allBooking ||
                          currentPath == AppRoutes.sponsorAdsScreen ||
                          currentPath == AppRoutes.salesReport
                      ) {
                        _pendingNavigationPath = currentPath;
                        statusBloc.add(
                          StatusGetKycEvent(
                            vendorId: BusinessProfileData.vendorId() ?? '',
                          ),
                        );
                      }
                      else if (BusinessProfileData.getBusinessRegistrationData()?.businessData?.status?.toLowerCase() == "pending") {
                        showAlert(
                          context,
                          "Your KYC and registration application is currently under review. Once verification is complete, you will have full access to this feature. Thank you for your patience.",
                        );
                      }
                      else if (BusinessProfileData.getBusinessRegistrationData()?.businessData?.status?.toLowerCase() == "rejected") {
                        askConfirmation(
                          heading: Text(
                            "Registration Rejected",
                            style: context.titleMedium()?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.redLight,
                            ),
                          ),
                          context,
                          "Your registration request was not approved. Please review and resubmit your business verification details.",
                          confirmCallBack: () {
                            Navigator.pushNamed(context, AppRoutes.kyc);
                          },
                        );
                      }
                      else {
                Navigator.pushNamed(
                          context,
                          DashboardModel.listDashboardModel[index].path,
                  arguments:BusinessProfileData.vendorId(),
                        );
                      }

                    },



                  );
                },
              ),
            ),
        
          ],
        ),
      ),
    ),
  );
}
}

