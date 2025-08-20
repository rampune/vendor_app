import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/features/business_hours/model/business_hour_model.dart';
import 'package:new_pubup_partner/features/business_hours/repository/business_hour_repository.dart';

class BusinessHourBloc extends Bloc<BusinessHourEvent,
    BusinessHourState
>{
  BusinessHourBloc():super(BusinessHourInitState()){
    on(handler);
  }
  handler(BusinessHourEvent event,Emitter<BusinessHourState> emit)async{
    emit(BusinessHourLoadingState());
if(event is BusinessHourPostEvent){
try {
  ApiResults ?apiResults = await BusinessHourRepository
      .businessHourPostRepository(data: event.businessHourData.toJson());
  if (apiResults?.statusCode == 200) {
    BusinessHourData businessHourData = BusinessHourData.fromJson(
        apiResults?.data['data']);
    emit(BusinessUserExistsState(
        listOprTime: businessHourData.operationalTime ?? []));
  } else {
    BusinessHourErrorState(
        errorMsg: "${apiResults?.data} ${apiResults?.message}");
  }
} catch(exception){
  emit(BusinessHourErrorState(errorMsg: "${exception}"));
}
}else if(event is BusinessHourPatchEvent){

  ApiResults ?apiResults=await BusinessHourRepository.businessHourPatchRepository(data:
  event.businessHourData.toJson(),
  vendorId: BusinessProfileData.vendorId()??"");

  if (apiResults?.statusCode == 200) {
    BusinessHourData businessHourData = BusinessHourData.fromJson(
        apiResults?.data['data']);
    emit(BusinessUserExistsState(
        listOprTime: businessHourData.operationalTime ?? []));
  } else {
    BusinessHourErrorState(
        errorMsg: "${apiResults?.data} ${apiResults?.message}");
  }



}
else if(event is BusinessHourGetEvent){

  emit(BusinessHourLoadingState());

  try {
    ApiResults ?result = await BusinessHourRepository.businessHourGetRepository(

        vendorId: BusinessProfileData.vendorId() ?? ''

    );
    if (result?.statusCode == 200) {
      BusinessHourData businessHourData = BusinessHourData.fromJson(
          result?.data['data']);
      emit(BusinessUserExistsState(listOprTime: businessHourData.operationalTime??[]));


    } else {
      if (result?.data["status"] == "Invalid Vendor Id") {
        emit(BusinessUserNotExistsState());
      } else {
        emit(BusinessHourErrorState(
            errorMsg: "${result?.data}  ${result?.message}"));
      }
    }
  }catch(exception){
    print("exception ------$exception");
    emit(BusinessHourErrorState(
        errorMsg: "$exception"));
  }




}
  }
}

abstract class BusinessHourEvent{}
 class BusinessHourPostEvent extends BusinessHourEvent{
  BusinessHourData businessHourData;
  BusinessHourPostEvent({required this.businessHourData});

 }
 class BusinessHourPatchEvent extends BusinessHourEvent{
  BusinessHourData businessHourData;
  BusinessHourPatchEvent({required this.businessHourData});

 }
class BusinessHourGetEvent extends BusinessHourEvent{
}
abstract class BusinessHourState extends Equatable{}
class BusinessHourInitState extends BusinessHourState{
  @override
  List<Object?> get props => [];
}

class BusinessHourLoadingState extends BusinessHourState{
  @override
  List<Object?> get props => [];
}

class BusinessUserExistsState extends BusinessHourState{
  final List<OperationalTime> listOprTime;
  BusinessUserExistsState({required this.listOprTime});
  @override
  List<Object?> get props => [];
}

class BusinessUserNotExistsState extends BusinessHourState{
  @override
  List<Object?> get props => [];
}
class BusinessHourSuccessState extends BusinessHourState{
  @override
  List<Object?> get props => [];
}

class BusinessHourErrorState extends BusinessHourState{
  final String errorMsg;
  BusinessHourErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}