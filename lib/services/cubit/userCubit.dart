import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState>{
  UserCubit._private():super(UserInitState());
  static UserCubit instance=UserCubit._private();
  factory UserCubit()=>instance;
  onUserList(List<dynamic> userList){
    emit(UserInitState());
    emit(UserListAvailableState(userList: userList));
  }
onUserInit(){
emit(UserInitState());
}
}
abstract class UserState extends Equatable{

}
class UserInitState extends UserState{
  @override
  List<Object?> get props => [];
}
class UserListAvailableState extends UserState{
  final List<dynamic > userList;
  UserListAvailableState({required this.userList});
  @override
  List<Object?> get props => [];
}
