import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OnMsgCubit extends Cubit<MsgState>{
  OnMsgCubit._private():super(MsgInitState());
  static OnMsgCubit instance=OnMsgCubit._private();
  factory OnMsgCubit()=>instance;

  onMessageReceive(String message,bool isSelf){
    emit(MsgInitState());
    emit(MsgReceiveState(msg: message,isSelf: isSelf));
  }
}
abstract class MsgState extends Equatable{

}
class MsgInitState extends MsgState{
  @override
  List<Object?> get props => [];
}

class MsgReceiveState extends MsgState{
  final String msg;
  final bool isSelf;
  MsgReceiveState({required this.msg,required this.isSelf});
  @override
  List<Object?> get props => [];
}