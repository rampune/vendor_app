// bloc/notification_event.dart
abstract class NotificationEvent {}
class FetchNotifications extends NotificationEvent {
  final String vendorId;
  FetchNotifications(this.vendorId);
}