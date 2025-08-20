import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent,ThemeState>{
  ThemeBloc._private():super(ThemeInitState()){
    on(handler);
  }
  static final ThemeBloc _instance=ThemeBloc._private();
 factory ThemeBloc()=>_instance;
handler(ThemeEvent event,Emitter<ThemeState> emit){
    if(event is ThemeChangeEvent){
      emit(ThemeLoadingState());
      emit(ThemeSuccessState(themeColor: event.themeColor));

    }
}
}
 abstract class ThemeEvent{}
 class ThemeChangeEvent extends ThemeEvent{
  final Color themeColor;
  ThemeChangeEvent({required this.themeColor});
 }
 abstract class ThemeState extends Equatable{}
class ThemeInitState extends ThemeState{
  @override
  List<Object?> get props => [];
}

class ThemeLoadingState extends ThemeState{
  @override
  List<Object?> get props => [];
}

class ThemeSuccessState extends ThemeState{
  final Color themeColor;
  ThemeSuccessState({required this.themeColor});
  @override
  List<Object?> get props => [];
}

class ThemeErrorState extends ThemeState{
  final String errorMsg;
  ThemeErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}