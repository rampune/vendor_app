import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../config/routes.dart';
class EventTypeModel{
  static List<EventTypeModel>listEventTypeModel=[
    EventTypeModel(
      iconData: Icons.event, // 📆 Upcoming Events
      title: "Upcoming\nEvents(2)",
      path: AppRoutes.eventViewerScreen,
    ),

    EventTypeModel(
      iconData: Icons.check_circle_rounded, // ✅ Completed Events
      title: "Completed\nEvents(5)",
      path: AppRoutes.eventViewerScreen,
    ),

    EventTypeModel(
      iconData: Icons.cancel_rounded, // ❌ Cancelled Events
      title: "Cancelled\nEvents(1)",
      path: AppRoutes.eventViewerScreen,
    ),

  ];
  String title,path;
  IconData iconData;
  EventTypeModel({required this.iconData,required this.title,required this.path});

}