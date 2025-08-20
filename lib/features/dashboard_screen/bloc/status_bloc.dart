import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/logger.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/features/dashboard_screen/model/vendor_status_model.dart';
import 'package:new_pubup_partner/features/dashboard_screen/repository/status_repository.dart';

class StatusBloc extends Bloc<StatusEvent,StatusState>{
  StatusBloc():super(StatusInitState()){
    on(handler);
  }
  handler(StatusEvent event ,Emitter<StatusState> emit)async{
if(event is StatusGetKycEvent){

  try{
    emit(StatusLoadingState());
ApiResults ? result= await StatusRepository.kycStatusRepo(vendorId: event.vendorId);

if(result?.data!=null){
  logger("------${result?.data}000 ${result?.statusCode} ${result?.message}--");
  VendorStatusModel statusModel=VendorStatusModel.fromJson(result?.data);

  if(statusModel.status?.toLowerCase()=="false"){
    emit(StatusKycFreshUserState());
  }else if(statusModel.status=="success"){
   if(statusModel.data?.kycStatus=="approved"){
     emit(StatusKycApprovalState());
   }else if(statusModel.data?.kycStatus=="rejected"){
     emit(StatusKycRejectedState(message: statusModel.data?.kycRejectionReason));
   }else if(statusModel.data?.kycStatus=="pending"){
     emit(StatusKycPendingState());
   }else{
     print("amra009dsfslfsa worong status${statusModel.data?.kycStatus}");
     emit(StatusErrorState(message: "wrong state found "));
   }
  }else{
    emit(StatusErrorState(message: "wrong state found"));
  }
  print("${statusModel?.toJson()}");
}else{
  emit(StatusErrorState(message: "${result?.message}"));
}
  }catch(exception){
    print("amra009fsdflsa$exception");
    emit(StatusErrorState(message: "${exception}"));
  }


}
  }
}

abstract class StatusEvent {}
 class StatusGetKycEvent extends StatusEvent {
  final String vendorId;
  StatusGetKycEvent({required this.vendorId});
}
abstract class StatusState extends Equatable{


}
class StatusInitState extends StatusState{
  @override
  List<Object?> get props => [];
}
class StatusLoadingState extends StatusState{
  @override
  List<Object?> get props => [];
}
class StatusKycRejectedState extends StatusState {
  final String ?message;
  StatusKycRejectedState({required this.message});

  @override
  List<Object?> get props => [];
}
class StatusKycApprovalState extends StatusState {
  @override
  List<Object?> get props => [];
}
class StatusKycPendingState extends StatusState{
  @override
  List<Object?> get props => [];
}
class StatusKycFreshUserState  extends StatusState{
  @override
  List<Object?> get props => [];
}
class StatusErrorState  extends StatusState{
  final String? message;
  StatusErrorState({this.message});
  @override
  List<Object?> get props => [];
}