

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
// import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
// import '../common_widgets/overlay_loading_progress.dart';
// import '../dashboard_screen/bloc/status_bloc.dart';
//
// // Notification model based on the image
// class NotificationModel {
//   final String id;
//   final String title;
//   final String description;
//   final DateTime timestamp;
//   final String? avatarUrl; // Logo or profile image
//   final bool hasAction; // Whether to show a button (e.g., "Pay")
//   final String? actionText; // Button text (e.g., "Pay")
//
//   NotificationModel({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.timestamp,
//     this.avatarUrl,
//     this.hasAction = false,
//     this.actionText,
//   });
// }
//
// class NotificationScreen extends StatefulWidget {
//   const NotificationScreen({super.key, required this.vendorId});
//   final String vendorId;
//
//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }
//
// class _NotificationScreenState extends State<NotificationScreen> {
//   late StatusBloc statusBloc;
//
//   // Sample notifications based on the image
//   final List<NotificationModel> _notifications = [
//     NotificationModel(
//       id: '1',
//       title: 'Royal Night Event',
//       description: 'Your recent event has successfully completed.',
//       timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
//       avatarUrl: 'https://example.com/pizzapoint.jpg',
//     ),
//     NotificationModel(
//       id: '2',
//       title: 'John',
//       description: 'requested for a table booking',
//       timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 6)),
//       avatarUrl: 'https://example.com/john.jpg',
//       hasAction: true,
//     ),
//     NotificationModel(
//       id: '3',
//       title: 'Chaishai',
//       description: 'Your recent transaction of 30.00 at Chaishai has successfully completed.',
//       timestamp: DateTime.now().subtract(const Duration(hours: 2)),
//       avatarUrl: 'https://example.com/chaishai.jpg',
//     ),
//     NotificationModel(
//       id: '4',
//       title: '2024 is now available',
//       description: 'Your monthly account statement for April',
//       timestamp: DateTime.now().subtract(const Duration(hours: 4)),
//       avatarUrl: 'https://example.com/statement.jpg',
//     ),
//     NotificationModel(
//       id: '5',
//       title: 'Your new credit card ending in 2688 has',
//       description: 'been successfully activated.',
//       timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
//       avatarUrl: 'https://example.com/creditcard.jpg',
//     ),
//     NotificationModel(
//       id: '6',
//       title: 'Your account balance has been updated.',
//       description: 'Current balance: 10,889.37',
//       timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
//       avatarUrl: 'https://example.com/balance.jpg',
//     ),
//     NotificationModel(
//       id: '7',
//       title: 'Exclusive offer for you! Get 1% cashback on',
//       description: 'your next grocery purchase using your HDFC credit card. T&C apply.',
//       timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
//       avatarUrl: 'https://example.com/hdfc.jpg',
//     ),
//     NotificationModel(
//       id: '8',
//       title: 'Apr 26 bill to Electric board has been',
//       description: 'processed successfully',
//       timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 7)),
//       avatarUrl: 'https://example.com/electric.jpg',
//     ),
//   ];
//
//   @override
//   void initState() {
//     super.initState();
//     statusBloc = StatusBloc();
//     statusBloc.add(
//       StatusGetKycEvent(
//         vendorId: widget.vendorId,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     statusBloc.close();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Notifications")),
//       body: BlocBuilder<StatusBloc, StatusState>(
//         bloc: statusBloc,
//         builder: (BuildContext context, StatusState state) {
//           if (state is StatusLoadingState) {
//             return const CustomLoadingWidget();
//           } else if (state is StatusErrorState) {
//             return CustomErrorWidget(
//               retryCallBack: () {
//                 statusBloc.add(
//                   StatusGetKycEvent(
//                     vendorId: widget.vendorId,
//                   ),
//                 );
//               },
//             );
//           }
//
//           return SafeArea(
//             child: RefreshIndicator(
//               onRefresh: () async {
//                 statusBloc.add(
//                   StatusGetKycEvent(
//                     vendorId: widget.vendorId,
//                   ),
//                 );
//               },
//               child: ListView.builder(
//                 padding: const EdgeInsets.all(0),
//                 itemCount: _getItemCount(),
//                 itemBuilder: (context, index) {
//                   return _buildItem(index);
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   int _getItemCount() {
//     final now = DateTime.now();
//     int todayCount = _notifications.where((n) => _isSameDay(n.timestamp, now)).length;
//     int yesterdayCount = _notifications.where((n) => _isYesterday(n.timestamp, now)).length;
//     return (todayCount > 0 ? 1 : 0) + (yesterdayCount > 0 ? 1 : 0) + _notifications.length;
//   }
//
//   Widget _buildItem(int index) {
//     final now = DateTime.now();
//     final todayNotifications = _notifications.where((n) => _isSameDay(n.timestamp, now)).toList();
//     final yesterdayNotifications = _notifications.where((n) => _isYesterday(n.timestamp, now)).toList();
//
//     if (todayNotifications.isNotEmpty && index == 0) {
//       return const Padding(
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         child: Text(
//           'Today',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//             color: Colors.black,
//           ),
//         ),
//       );
//     }
//     int todayOffset = todayNotifications.isNotEmpty ? 1 : 0;
//     if (yesterdayNotifications.isNotEmpty && index == todayOffset + todayNotifications.length) {
//       return const Padding(
//         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
//         child: Text(
//           'Yesterday',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 16,
//             color: Colors.black,
//           ),
//         ),
//       );
//     }
//
//     int notificationIndex = index - (todayNotifications.isNotEmpty ? 1 : 0);
//     if (yesterdayNotifications.isNotEmpty && index > todayNotifications.length) {
//       notificationIndex -= 1;
//     }
//
//     if (notificationIndex >= 0 && notificationIndex < _notifications.length) {
//       return _buildNotificationTile(_notifications[notificationIndex]);
//     }
//     return const SizedBox.shrink();
//   }
//
//   Widget _buildNotificationTile(NotificationModel notification) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Avatar
//           CircleAvatar(
//             radius: 20,
//             backgroundColor: Colors.grey[200],
//             backgroundImage: notification.avatarUrl != null
//                 ? NetworkImage(notification.avatarUrl!)
//                 : null,
//             child: notification.avatarUrl == null
//                 ? const Icon(Icons.person, color: Colors.grey)
//                 : null,
//           ),
//           const SizedBox(width: 12),
//           // Content
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Title and description
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: '${notification.title} ',
//                         style: const TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           fontSize: 14,
//                         ),
//                       ),
//                       TextSpan(
//                         text: notification.description,
//                         style: const TextStyle(
//                           fontWeight: FontWeight.normal,
//                           color: Colors.black,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 const SizedBox(height: 4),
//                 // Timestamp and action
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       _formatTimestamp(notification.timestamp),
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.grey[600],
//                       ),
//                     ),
//                     if (notification.hasAction)
//                       ElevatedButton(
//                         onPressed: () {
//                           // Handle action (e.g., "Pay")
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             const SnackBar(content: Text('Payment action triggered')),
//                           );
//                         },
//                         style: ElevatedButton.styleFrom(
//                           minimumSize: const Size(60, 24),
//                           padding: const EdgeInsets.symmetric(horizontal: 12),
//                           textStyle: const TextStyle(fontSize: 12),
//                         ),
//                         child: const Text('Pay'),
//                       ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   String _formatTimestamp(DateTime timestamp) {
//     final now = DateTime.now();
//     final difference = now.difference(timestamp);
//
//     if (difference.inMinutes < 60) {
//       return '${difference.inMinutes}m ago';
//     } else if (difference.inHours < 24) {
//       return '${difference.inHours}h ago';
//     } else {
//       return '${difference.inDays}d ago';
//     }
//   }
//
//   bool _isSameDay(DateTime date1, DateTime date2) {
//     return date1.year == date2.year &&
//         date1.month == date2.month &&
//         date1.day == date2.day;
//   }
//
//   bool _isYesterday(DateTime date, DateTime now) {
//     final yesterday = now.subtract(const Duration(days: 1));
//     return _isSameDay(date, yesterday);
//   }
// }











// lib/features/notifications/screens/notification_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
import 'package:new_pubup_partner/features/notification_screen/bloc/notification_bloc.dart';
import 'package:new_pubup_partner/features/notification_screen/event/notification_event.dart';
import 'package:new_pubup_partner/features/notification_screen/model/notification_model.dart';
import 'package:new_pubup_partner/features/notification_screen/state/notification_state.dart';



class NotificationScreen extends StatefulWidget {
  final String vendorId;
  const NotificationScreen({super.key, required this.vendorId});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late NotificationBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = NotificationBloc()..add(FetchNotifications(widget.vendorId));
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  // Yeh tumhara original model (UI ke liye) – bas API se convert kar denge
  List<NotificationModelUi> _convertToUIModel(List<NotificationModel> apiList) {
    return apiList.map((n) {
      bool hasAction = n.title.contains("Blocked") || n.title.contains("Unblocked");
      return NotificationModelUi(
        id: n.id.toString(),
        title: n.title,
        description: n.body,
        timestamp: n.createdAt,
        avatarUrl: null, // Tumhare paas avatar nahi hai API mein
        hasAction: hasAction,
        actionText: hasAction ? (n.title.contains("Blocked") ? "Contact Support" : "Got it") : null,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: BlocBuilder<NotificationBloc, NotificationState>(
        bloc: bloc,
        builder: (context, state) {
          if (state is NotificationLoading) {
            return const CustomLoadingWidget();
          }
          if (state is NotificationError) {
            // return CustomErrorWidget(
            //   retryCallBack: () => bloc.add(FetchNotifications(widget.vendorId)),
            // );
            return Center(child: Text('No notifications available'));
          }
          if (state is NotificationLoaded) {
            final notifications = _convertToUIModel(state.notifications);

            return SafeArea(
              child: RefreshIndicator(
                onRefresh: () async {
                  bloc.add(FetchNotifications(widget.vendorId));
                },
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: _getItemCount(notifications),
                  itemBuilder: (context, index) => _buildItem(index, notifications),
                ),
              ),
            );
          }

          return const Center(child: Text("No notifications"));
        },
      ),
    );
  }

  // Yeh sab tumhara 100% original code hai – bilkul same
  int _getItemCount(List<NotificationModelUi> notifications) {
    final now = DateTime.now();
    int todayCount = notifications.where((n) => _isSameDay(n.timestamp, now)).length;
    int yesterdayCount = notifications.where((n) => _isYesterday(n.timestamp, now)).length;
    return (todayCount > 0 ? 1 : 0) + (yesterdayCount > 0 ? 1 : 0) + notifications.length;
  }

  Widget _buildItem(int index, List<NotificationModelUi> notifications) {
    final now = DateTime.now();
    final todayNotifications = notifications.where((n) => _isSameDay(n.timestamp, now)).toList();
    final yesterdayNotifications = notifications.where((n) => _isYesterday(n.timestamp, now)).toList();

    if (todayNotifications.isNotEmpty && index == 0) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text('Today', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      );
    }
    int todayOffset = todayNotifications.isNotEmpty ? 1 : 0;
    if (yesterdayNotifications.isNotEmpty && index == todayOffset + todayNotifications.length) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text('Yesterday', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      );
    }

    int notificationIndex = index - (todayNotifications.isNotEmpty ? 1 : 0);
    if (yesterdayNotifications.isNotEmpty && index > todayNotifications.length) {
      notificationIndex -= 1;
    }

    if (notificationIndex >= 0 && notificationIndex < notifications.length) {
      return _buildNotificationTile(notifications[notificationIndex]);
    }
    return const SizedBox.shrink();
  }

  Widget _buildNotificationTile(NotificationModelUi notification) {

    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            child: const Icon(Icons.notifications, color: Colors.grey),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${notification.title} ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: isDarkMode ? Colors.white : Colors.black,),
                      ),
                      TextSpan(
                        text: notification.description,
                        style: TextStyle(fontSize: 14, color: isDarkMode ? Colors.white : Colors.black,),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatTimestamp(notification.timestamp),
                      style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                    ),

                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final diff = DateTime.now().difference(timestamp);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  bool _isSameDay(DateTime d1, DateTime d2) => d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  bool _isYesterday(DateTime date, DateTime now) => _isSameDay(date, now.subtract(const Duration(days: 1)));
}




class NotificationModelUi {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final String? avatarUrl;     // Logo ya profile image (abhi null rahega kyuki API mein nahi hai)
  final bool hasAction;        // Button dikhana hai ya nahi
  final String? actionText;    // Button ka text (jaise "Contact Support", "Got it")

  NotificationModelUi({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    this.avatarUrl,
    this.hasAction = false,
    this.actionText,
  });
}