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

// Notification model (unchanged from previous)
class NotificationModel {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  final bool isRead;
  final String? userImage; // Added for Instagram-like avatar
  final String? postImage; // Optional image for post-related notifications

  NotificationModel({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
    this.userImage,
    this.postImage,
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

  // Sample notifications (replace with your API data)
  final List<NotificationModel> _notifications = [
    NotificationModel(
      id: '1',
      title: 'john_doe',
      message: 'liked your post',
      timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      userImage: 'https://example.com/user1.jpg', // Replace with actual image URL
      postImage: 'https://example.com/post1.jpg',
    ),
    NotificationModel(
      id: '2',
      title: 'jane_smith',
      message: 'started following you',
      timestamp: DateTime.now().subtract(const Duration(hours: 3)),
      userImage: 'https://example.com/user2.jpg',
    ),
    NotificationModel(
      id: '3',
      title: 'alex_wilson',
      message: 'commented: Great work!',
      timestamp: DateTime.now().subtract(const Duration(days: 1)),
      userImage: 'https://example.com/user3.jpg',
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
        appBar: AppBar(title: Text("Notification"),),
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

          return RefreshIndicator(
            onRefresh: () async {
              statusBloc.add(
                StatusGetKycEvent(
                  vendorId: widget.vendorId,
                ),
              );
            },
            child: _notifications.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.notifications_none,
                    size: 48,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No notifications yet',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            )
                : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notification = _notifications[index];
                return _buildNotificationTile(notification);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationTile(NotificationModel notification) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: InkWell(
        onTap: () {
          // Handle notification tap (e.g., mark as read or navigate)
          setState(() {
            // Update isRead status (you might want to update this in your BLoC)
            _notifications[_notifications.indexOf(notification)] =
                NotificationModel(
                  id: notification.id,
                  title: notification.title,
                  message: notification.message,
                  timestamp: notification.timestamp,
                  isRead: true,
                  userImage: notification.userImage,
                  postImage: notification.postImage,
                );
          });
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Notification content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Username and message
                  RichText(
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: notification.title,
                          style: TextStyle(
                            fontWeight: notification.isRead
                                ? FontWeight.normal
                                : FontWeight.bold,
                            color: Colors.black,
                            fontSize: 14,
                          ),
                        ),
                        TextSpan(
                          text: ' ${notification.message}',
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
                  // Timestamp
                  Text(
                    _formatTimestamp(notification.timestamp),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${difference.inDays ~/ 7}w';
    }
  }
}