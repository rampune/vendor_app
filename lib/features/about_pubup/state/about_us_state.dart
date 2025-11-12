// bloc/about_us_state.dart
import 'package:equatable/equatable.dart';
import 'package:new_pubup_partner/features/about_pubup/model/about_us_model.dart';


abstract class AboutUsState extends Equatable {}

class AboutUsInitState extends AboutUsState {
  @override
  List<Object?> get props => [];
}

class AboutUsLoadingState extends AboutUsState {
  @override
  List<Object?> get props => [];
}

class AboutUsSuccessState extends AboutUsState {
  final AboutUsModel aboutUsModel;

  AboutUsSuccessState({required this.aboutUsModel});

  @override
  List<Object?> get props => [aboutUsModel];
}

class AboutUsErrorState extends AboutUsState {
  final String errorMsg;

  AboutUsErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [errorMsg];
}