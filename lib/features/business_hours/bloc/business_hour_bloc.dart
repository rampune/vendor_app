
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/features/business_hours/model/business_hour_model.dart';
import 'package:new_pubup_partner/features/business_hours/repository/business_hour_repository.dart';

class BusinessHourBloc extends Bloc<BusinessHourEvent, BusinessHourState> {
  BusinessHourBloc() : super(BusinessHourInitState()) {
    on(handler);
  }

  handler(BusinessHourEvent event, Emitter<BusinessHourState> emit) async {
    emit(BusinessHourLoadingState());

    if (event is BusinessHourPostEvent) {
      try {
        ApiResults? apiResults = await BusinessHourRepository
            .businessHourPostRepository(data: event.businessHourData.toJson());
        if (apiResults?.statusCode == 200) {
          BusinessHourData businessHourData =
          BusinessHourData.fromJson(apiResults?.data['data']);
          debugPrint('Business hour data added successfully: ${businessHourData.operationalTime}');
          emit(BusinessUserExistsState(
              listOprTime: businessHourData.operationalTime ?? []));
        } else {
          debugPrint('Failed to add business hour data: ${apiResults?.data} ${apiResults?.message}');
          emit(BusinessHourErrorState(
              errorMsg: "${apiResults?.data} ${apiResults?.message}"));
        }
      } catch (exception) {
        debugPrint('Exception while adding business hour data: $exception');
        emit(BusinessHourErrorState(errorMsg: "$exception"));
      }
    }
    else if (event is BusinessHourPatchEvent) {
      try {
        ApiResults? apiResults = await BusinessHourRepository
            .businessHourPatchRepository(
            data: event.businessHourData.toJson(),
            vendorId: BusinessProfileData.vendorId() ?? "");

        if (apiResults?.statusCode == 200) {
          BusinessHourData businessHourData =
          BusinessHourData.fromJson(apiResults?.data['data']);
          debugPrint('Business hour data updated successfully: ${businessHourData.operationalTime}');
          emit(BusinessUserExistsState(
              listOprTime: businessHourData.operationalTime ?? []));
        } else {
          debugPrint('Failed to update business hour data: ${apiResults?.data} ${apiResults?.message}');
          emit(BusinessHourErrorState(
              errorMsg: "${apiResults?.data} ${apiResults?.message}"));
        }
      } catch (exception, stackTrace) {
        debugPrint('Exception while updating business hour data: $exception');
        emit(BusinessHourErrorState(errorMsg: "$exception"));
      }
    } else if (event is BusinessHourGetEvent) {
      try {
        ApiResults? result = await BusinessHourRepository
            .businessHourGetRepository(
            vendorId: BusinessProfileData.vendorId() ?? '');

        if (result?.statusCode == 200) {
          BusinessHourData businessHourData =
          BusinessHourData.fromJson(result?.data['data']);
          debugPrint('Business hour data fetched successfully: ${businessHourData.operationalTime}');
          emit(BusinessUserExistsState(
              listOprTime: businessHourData.operationalTime ?? []));
        } else {
          if (result?.data["status"] == "Invalid Vendor Id") {
            debugPrint('Failed to fetch business hour data: Invalid Vendor Id');
            emit(BusinessUserNotExistsState());
          } else {
            debugPrint('Failed to fetch business hour data: ${result?.data} ${result?.message}');
            emit(BusinessHourErrorState(
                errorMsg: "${result?.data} ${result?.message}"));
          }
        }
      } catch (exception) {
        debugPrint('Exception while fetching business hour data: $exception');
        emit(BusinessHourErrorState(errorMsg: "$exception"));
      }
    }
  }
}

abstract class BusinessHourEvent {}

class BusinessHourPostEvent extends BusinessHourEvent {
  BusinessHourData businessHourData;
  BusinessHourPostEvent({required this.businessHourData});
}

class BusinessHourPatchEvent extends BusinessHourEvent {
  BusinessHourData businessHourData;
  BusinessHourPatchEvent({required this.businessHourData});
}

class BusinessHourGetEvent extends BusinessHourEvent {}

abstract class BusinessHourState extends Equatable {}

class BusinessHourInitState extends BusinessHourState {
  @override
  List<Object?> get props => [];
}

class BusinessHourLoadingState extends BusinessHourState {
  @override
  List<Object?> get props => [];
}

class BusinessUserExistsState extends BusinessHourState {
  final List<OperationalTime> listOprTime;
  BusinessUserExistsState({required this.listOprTime});
  @override
  List<Object?> get props => [listOprTime];
}

class BusinessUserNotExistsState extends BusinessHourState {
  @override
  List<Object?> get props => [];
}

class BusinessHourSuccessState extends BusinessHourState {
  @override
  List<Object?> get props => [];
}

class BusinessHourErrorState extends BusinessHourState {
  final String errorMsg;
  BusinessHourErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [errorMsg];
}