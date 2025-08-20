import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/features/sponsor_ads_screen/repository/sponsor_ads_repo.dart';

class SponsorAdsBloc extends Bloc<SponsorAdsEvent,SponsorAdsState>{
  SponsorAdsBloc():super(SponsorAdsInitState()){
    on(handler);
  }
  handler(SponsorAdsEvent event,Emitter<SponsorAdsState> emit)async{

    if(event is SponsorAdsUploadDataEvent){
try{
  emit(SponsorAdsLoadingState());

ApiResults ?results= await  SponsorAdsRepo.uploadRepo(data: event.data, imgFile: event.imgFile);
if(results?.statusCode==200){
  emit(SponsorAdsSuccessState());
}else{
  emit(SponsorAdsErrorState(errorMsg:  results?.message??"something wrong try again"));
}

}catch(exception){
  emit(SponsorAdsErrorState(errorMsg:  "${exception}"));
}

    }
  }
}

abstract class SponsorAdsEvent {}

class SponsorAdsUploadDataEvent extends SponsorAdsEvent{
  final File imgFile;
  final Map<String,dynamic> data;
  SponsorAdsUploadDataEvent({required this.data,required this.imgFile});

}
abstract class SponsorAdsState extends Equatable{}
class SponsorAdsInitState extends SponsorAdsState{
  @override
  List<Object?> get props => [];
}
class SponsorAdsLoadingState extends SponsorAdsState{
  @override
  List<Object?> get props => [];
}

class SponsorAdsSuccessState extends SponsorAdsState{
  @override
  List<Object?> get props => [];
}
class SponsorAdsErrorState extends SponsorAdsState{
  final String errorMsg;
  SponsorAdsErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}