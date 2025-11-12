import 'package:flutter/material.dart';
import 'package:new_pubup_partner/features/about_pubup/view/about_us_screen.dart';
import 'package:new_pubup_partner/features/admin_details/edit_profile/edit_profile.dart';
import 'package:new_pubup_partner/features/all_bookings/all_bookings.dart';
import 'package:new_pubup_partner/features/event/event_show/show_event.dart';
import 'package:new_pubup_partner/features/event/event_show/views/event_viewer.dart';
import 'package:new_pubup_partner/features/event/model/EventPostModel.dart';
import 'package:new_pubup_partner/features/event/update_event/update_event.dart';
import 'package:new_pubup_partner/features/notification_screen/notification_screen.dart';
import 'package:new_pubup_partner/features/pub_cafe_gallery_screen/pub_cafe_gallery_screen.dart';
import 'package:new_pubup_partner/features/vendor_profile_screen/vendor_profile_screen.dart';
import 'package:new_pubup_partner/features/web_view/web_view.dart';
import 'package:new_pubup_partner/ticket_validator/ticket_validator.dart';
import '../features/admin_details/view/business_details.dart';
import '../features/business_hours/business_hours.dart';
import '../features/dashboard_screen/dashboard_screen.dart';
import '../features/event/event_booking.dart';
import '../features/food_menu_screen/menu_screen.dart';
import '../features/kyc/kyc.dart';
import '../features/kyc/views/bank_kyc.dart';
import '../features/kyc/views/owner_kyc.dart';
import '../features/location/location_screen.dart';
import '../features/login/views/mobile_login_screen.dart';
import '../features/login/views/otp_screen.dart';
import '../features/login/views/partner_login.dart';
import '../features/splash_screen/splash_screen.dart';
import '../features/sponsor_ads_screen/sponsor_ads_screen.dart' show SponsorAdsScreen;
class AppRoutes {
  static const String home="/";
  static const String dashboardScreen="/dashboardScreen";
  static const String  splashScreen="/splashScreen";
  static const String mobileLoginScreen="/mobileLoginScreen";
  static const String  otpScreen="/otpScreen";
  static const String locationScreen="/locationScreen";
  static const String  homeScreen="/homeScreen";

  static const String  partnerLogin="/partnerLogin";
  static const String eventViewerScreen="/eventViewerScreen";
static const String sponsorAdsScreen="/sponsorAdsScreen";
  static const String bankDetailsScreen="/bankDetailsScreen";
  static const String owerDetailsScreen="/owerDetailsScreen";
  static const String businessDetailsScreen="businessDetailsScreen";
static const String showEventScreen="/showEventScreen";
  static const String kyc="/kyc";
  static const String businessHoursScreen="/businessHoursScreen";
  static const String eventBooking="/eventBooking";
  static const String notificationScreen="/notificationScreen";
  static const String allBooking="/allBooking";
  static const String menuScreen="/menuScreen";
  static const String myWebView="/mywebView";
  static const String pubCafeGallery = '/pubCafeGallery';
  static const String editProfile="/editProfile";
  static const String updateEventScreen="/updateEventScreen";
  static const String ticketValidator="/ticketValidator";
  static const String vendorProfileScreen = '/vendorProfileScreen';

  static const String aboutUsScreen = '/aboutUsScreen';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
 case splashScreen:
        return CustomPageRoute(builder: (_)=>SplashScreen(), settings: settings);
      case mobileLoginScreen:
        return CustomPageRoute(builder: (_)=>MobileLoginScreen(), settings: settings);
      case otpScreen:
        return CustomPageRoute(builder: (_)=>OtpScreen(otpModel: settings.arguments as OtpModel,), settings: settings);
      case locationScreen:
        return CustomPageRoute(builder: (_)=>LocationScreen(), settings: settings);

      case partnerLogin:
        return CustomPageRoute(builder: (_)=>PartnerLogin(), settings: settings);

      case dashboardScreen:
        return CustomPageRoute(builder: (_)=>DashboardScreen(), settings: settings);
      case eventViewerScreen:
        return CustomPageRoute(builder: (_)=>EventViewer(getEventModelList: settings.arguments as List<EventPostModel>), settings: settings);

      case bankDetailsScreen:
        return CustomPageRoute(builder: (_)=>BankKyc(), settings: settings);
      case owerDetailsScreen:
        return CustomPageRoute(builder: (_)=>OwnerKyc(), settings: settings);
      case businessDetailsScreen:
        return CustomPageRoute(builder: (_)=>BusinessDetails(), settings: settings);

      case kyc:
        return CustomPageRoute(builder: (_)=>Kyc(), settings: settings);
      case sponsorAdsScreen:
        return CustomPageRoute(builder: (_)=>SponsorAdsScreen(),
            settings: settings);
      case businessHoursScreen:
        return CustomPageRoute(builder: (_)=>BusinessHours(),
            settings: settings);
      case eventBooking:
        return CustomPageRoute(builder: (_)=>EventBooking(),
            settings: settings);
      case notificationScreen:
        return CustomPageRoute(builder: (_)=>NotificationScreen(vendorId:  settings.arguments as String,),
            settings: settings);
        //allBooking
      case allBooking:
        return CustomPageRoute(builder: (_)=>AllBookings(vendorId: settings.arguments as String,),
            settings: settings);

      case vendorProfileScreen:
        return CustomPageRoute(builder: (_)=>VendorProfileScreen(vendorId:settings.arguments as String),
            settings: settings);

      case menuScreen:
        return CustomPageRoute(builder: (_)=>MenuScreen(),
            settings: settings);
      case pubCafeGallery:
        return CustomPageRoute(builder: (_)=>PubCafeGalleryScreen(),
            settings: settings);
      case myWebView:
        return CustomPageRoute(builder: (_)=>MyWebView(),
            settings: settings);
      case showEventScreen:
        return CustomPageRoute(builder: (_)=>ShowEvent(),
            settings: settings);


    case aboutUsScreen:
    return CustomPageRoute(builder: (_)=>AboutUsScreen(),
    settings: settings);


      case editProfile:
        return CustomPageRoute(builder: (_)=>EditProfile(
          editType: settings.arguments as String,

        ), settings: settings);
      case updateEventScreen:
        return CustomPageRoute(builder: (_)=>UpdateEvent(), settings: settings);
      case ticketValidator:
        return CustomPageRoute(builder: (_)=>TicketValidator(), settings: settings);

      default:
        return CustomPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ),
            settings: settings);
    }
  }
}

class CustomPageRoute<T> extends MaterialPageRoute<T> {
  CustomPageRoute(
      {required WidgetBuilder builder, required RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // if (settings.isInitialRoute)
    //   return child;
    // Fades between routes. (If you don't want any animation,
    // just return child.)
    // return new FadeTransition(opacity: animation, child: child);

    return new SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1, 0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
}
