import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/source/network/api_result_handler.dart';
import '../repository/login_repository.dart';
import '../utils/utils.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState>{
  LoginBloc():super(LoginInitState()){
    on(handler);
  }
  handler(LoginEvent event,Emitter<LoginState> emit)async{
    if(event is LoginSendOtpEvent){
int otp=otpGenerator();
      emit(LoginLoadingState());
ApiResults ?results=await LoginRepository.sendOtpRepository(mobileNumber: event.mobileNumber,
    otp: "$otp");

if(results?.statusCode==200){
  emit(LoginOtpSentState(otp:otp, mobileNumber: event.mobileNumber));
}else{
  emit(LoginErrorState(errorMsg: "${results?.message}"));
}
    }

  }
}
abstract class LoginEvent {}
class LoginSendOtpEvent extends LoginEvent{
  String mobileNumber;
  LoginSendOtpEvent({required this.mobileNumber});
}
abstract class LoginState extends Equatable{}
class LoginInitState extends LoginState{
  @override
  List<Object?> get props => [];
}
class LoginLoadingState extends LoginState{
  @override
  List<Object?> get props => [];
}
class LoginSuccessState extends LoginState{
  @override
  List<Object?> get props => [];
}
class LoginOtpSentState extends LoginState{
  final String  mobileNumber;
  final int otp;
  LoginOtpSentState({required this.otp,required this.mobileNumber});
  @override
  List<Object?> get props => [];
}
class LoginErrorState extends LoginState{
  final String errorMsg;
  LoginErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}