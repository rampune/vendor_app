/*import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';

import '../common_widgets/overlay_loading_progress.dart';
import '../dashboard_screen/bloc/status_bloc.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key,required this.vendorId});
  final String vendorId;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  StatusBloc statusBloc=StatusBloc();
  @override
  void initState() {
    statusBloc.add(
      StatusGetKycEvent(
        vendorId: widget.vendorId?? '',
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Notification"),
    ),
    body: Center(
      child: BlocBuilder<StatusBloc, StatusState>(
        bloc: statusBloc,
        builder: (BuildContext context, StatusState state) {
         if( state is StatusLoadingState){
           return CustomLoadingWidget();
         }else if (state is StatusKycApprovalState) {
           return Text("Kyc approved");
          } else if (state is StatusKycRejectedState) {
            return Text("Kyc Rejected");

          } else if (state is StatusKycPendingState) {
    return Text("kyc Pending");
            return ListView.builder(itemBuilder: (BuildContext context, int index){
              return ListTile(title: Text("dsfs"),

              shape: RoundedRectangleBorder(

              ),);
            });
          } else if (state is StatusKycFreshUserState) {
         return Text("kyc not send");
          }else if(state is  StatusErrorState){
           return CustomErrorWidget(retryCallBack: (){
             statusBloc.add(
               StatusGetKycEvent(
                 vendorId: widget.vendorId?? '',
               ),
             );
           },);
          }
          return SizedBox.shrink();
        },

      ),
    ),
    );
  }
}*/






/// New code of Saransh

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
import '../common_widgets/overlay_loading_progress.dart';
import '../dashboard_screen/bloc/status_bloc.dart';

// Notification model based on the image
class NotificationModel {
  final String id;
  final String title;
  final String description;
  final DateTime timestamp;
  final String? avatarUrl; // Logo or profile image
  final bool hasAction; // Whether to show a button (e.g., "Pay")
  final String? actionText; // Button text (e.g., "Pay")

  NotificationModel({
    required this.id,
    required this.title,
    required this.description,
    required this.timestamp,
    this.avatarUrl,
    this.hasAction = false,
    this.actionText,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key, required this.vendorId});
  final String vendorId;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late StatusBloc statusBloc;

  // Sample notifications based on the image
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'Royal Night Event',
      description: 'Your recent event has successfully completed.',
      timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
      avatarUrl: 'https://example.com/pizzapoint.jpg',
    ),
    NotificationModel(
      id: '2',
      title: 'John',
      description: 'requested for a table booking',
      timestamp: DateTime.now().subtract(const Duration(hours: 1, minutes: 6)),
      avatarUrl: 'https://example.com/john.jpg',
      hasAction: true,
    ),
    NotificationModel(
      id: '3',
      title: 'Chaishai',
      description: 'Your recent transaction of 30.00 at Chaishai has successfully completed.',
      timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      avatarUrl: 'https://example.com/chaishai.jpg',
    ),
    NotificationModel(
      id: '4',
      title: '2024 is now available',
      description: 'Your monthly account statement for April',
      timestamp: DateTime.now().subtract(const Duration(hours: 4)),
      avatarUrl: 'https://example.com/statement.jpg',
    ),
    NotificationModel(
      id: '5',
      title: 'Your new credit card ending in 2688 has',
      description: 'been successfully activated.',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 1)),
      avatarUrl: 'https://example.com/creditcard.jpg',
    ),
    NotificationModel(
      id: '6',
      title: 'Your account balance has been updated.',
      description: 'Current balance: 10,889.37',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 3)),
      avatarUrl: 'https://example.com/balance.jpg',
    ),
    NotificationModel(
      id: '7',
      title: 'Exclusive offer for you! Get 1% cashback on',
      description: 'your next grocery purchase using your HDFC credit card. T&C apply.',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      avatarUrl: 'https://example.com/hdfc.jpg',
    ),
    NotificationModel(
      id: '8',
      title: 'Apr 26 bill to Electric board has been',
      description: 'processed successfully',
      timestamp: DateTime.now().subtract(const Duration(days: 1, hours: 7)),
      avatarUrl: 'https://example.com/electric.jpg',
    ),
  ];

  @override
  void initState() {
    super.initState();
    statusBloc = StatusBloc();
    statusBloc.add(
      StatusGetKycEvent(
        vendorId: widget.vendorId,
      ),
    );
  }

  @override
  void dispose() {
    statusBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notifications")),
      body: BlocBuilder<StatusBloc, StatusState>(
        bloc: statusBloc,
        builder: (BuildContext context, StatusState state) {
          if (state is StatusLoadingState) {
            return const CustomLoadingWidget();
          } else if (state is StatusErrorState) {
            return CustomErrorWidget(
              retryCallBack: () {
                statusBloc.add(
                  StatusGetKycEvent(
                    vendorId: widget.vendorId,
                  ),
                );
              },
            );
          }

          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                statusBloc.add(
                  StatusGetKycEvent(
                    vendorId: widget.vendorId,
                  ),
                );
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(0),
                itemCount: _getItemCount(),
                itemBuilder: (context, index) {
                  return _buildItem(index);
                },
              ),
            ),
          );
        },
      ),
    );
  }

  int _getItemCount() {
    final now = DateTime.now();
    int todayCount = _notifications.where((n) => _isSameDay(n.timestamp, now)).length;
    int yesterdayCount = _notifications.where((n) => _isYesterday(n.timestamp, now)).length;
    return (todayCount > 0 ? 1 : 0) + (yesterdayCount > 0 ? 1 : 0) + _notifications.length;
  }

  Widget _buildItem(int index) {
    final now = DateTime.now();
    final todayNotifications = _notifications.where((n) => _isSameDay(n.timestamp, now)).toList();
    final yesterdayNotifications = _notifications.where((n) => _isYesterday(n.timestamp, now)).toList();

    if (todayNotifications.isNotEmpty && index == 0) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          'Today',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      );
    }
    int todayOffset = todayNotifications.isNotEmpty ? 1 : 0;
    if (yesterdayNotifications.isNotEmpty && index == todayOffset + todayNotifications.length) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          'Yesterday',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      );
    }

    int notificationIndex = index - (todayNotifications.isNotEmpty ? 1 : 0);
    if (yesterdayNotifications.isNotEmpty && index > todayNotifications.length) {
      notificationIndex -= 1;
    }

    if (notificationIndex >= 0 && notificationIndex < _notifications.length) {
      return _buildNotificationTile(_notifications[notificationIndex]);
    }
    return const SizedBox.shrink();
  }

  Widget _buildNotificationTile(NotificationModel notification) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Avatar
          CircleAvatar(
            radius: 20,
            backgroundColor: Colors.grey[200],
            backgroundImage: notification.avatarUrl != null
                ? NetworkImage(notification.avatarUrl!)
                : null,
            child: notification.avatarUrl == null
                ? const Icon(Icons.person, color: Colors.grey)
                : null,
          ),
          const SizedBox(width: 12),
          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and description
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${notification.title} ',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                      TextSpan(
                        text: notification.description,
                        style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                // Timestamp and action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatTimestamp(notification.timestamp),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                    if (notification.hasAction)
                      ElevatedButton(
                        onPressed: () {
                          // Handle action (e.g., "Pay")
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Payment action triggered')),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(60, 24),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          textStyle: const TextStyle(fontSize: 12),
                        ),
                        child: const Text('Pay'),
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
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  bool _isYesterday(DateTime date, DateTime now) {
    final yesterday = now.subtract(const Duration(days: 1));
    return _isSameDay(date, yesterday);
  }
}