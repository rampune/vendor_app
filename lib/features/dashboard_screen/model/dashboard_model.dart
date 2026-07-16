import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../config/routes.dart';

class DashboardModel{

  IconData iconData;
  String title;
  String path;


  DashboardModel({required this.iconData,required this.title,this.path="/"});
 static List<DashboardModel> listDashboardModel=[

   DashboardModel(
     iconData: Icons.calendar_month, // 📅 All Events
     title: "All Events",
     path: AppRoutes.showEventScreen,
   ),

   DashboardModel(
     iconData: Icons.add_task_rounded, // ➕ Post New Event
     title: "Post New Event",
     path: "newEvent",
   ),



   DashboardModel(
     iconData: Icons.book_online_rounded, // 📖 All Bookings
     title: "All Bookings",
     // path: AppRoutes.eventBooking,
     path: AppRoutes.allBooking,
   ),

   DashboardModel(
     iconData: Icons.campaign_rounded, // 📢 Sponsor Adds
     title: "Sponsor Ads",
     path: AppRoutes.sponsorAdsScreen,
   ),
   // DashboardModel(
   //   iconData: Icons.qr_code, // 📢 Sponsor Adds
   //   title: "Ticket Validator",
   //   path: AppRoutes.ticketValidator,
   // ),



   DashboardModel(
     iconData: Icons.bar_chart_rounded, // 📊 Sales Report
     title: "Sales Report",
     path: AppRoutes.salesReport,
   ),
  ]
  ;
}