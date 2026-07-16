// bloc/notification_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/notification_screen/event/notification_event.dart';
import 'package:new_pubup_partner/features/notification_screen/model/notification_model.dart';
import 'package:new_pubup_partner/features/notification_screen/repository/notification_repository.dart';
import 'package:new_pubup_partner/features/notification_screen/state/notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  final repo = NotificationRepository.instance;

  NotificationBloc() : super(NotificationInitial()) {
    on<FetchNotifications>((event, emit) async {
      emit(NotificationLoading());
      try {
        final result = await repo.getVendorNotifications(vendorId: event.vendorId);

        if (result?.statusCode == 200 && result?.data != null) {
          final List<dynamic> list = result!.data['data'];
          final notifications = list
              .map((e) => NotificationModel.fromJson(e))
              .toList()
              .reversed
              .toList();

          emit(NotificationLoaded(notifications));
        } else {
          emit(NotificationError("Failed to load notifications"));
        }
      } catch (e) {
        emit(NotificationError(e.toString()));
      }
    });
  }
}