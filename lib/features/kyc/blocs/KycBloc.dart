import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/kyc/repository/kyc_repository.dart';

class KycBloc extends Bloc<KycEvent,KycState>{
  KycBloc() : super(KycInitState()) {
    on<KycUploadEvent>(handler);
    on<KycProgressUpdateEvent>((event, emit) {
      emit(KycUploadingProgressState(progress: event.progress));
    });
  }
handler(KycEvent event,
    Emitter<KycState> emit)async{
    if(event is  KycUploadEvent){
      emit(KycLoadingState());
      try {
        ApiResults? results = await KycRepository.saveKycRepo(
            imageModelList: event.imgUploadModelList,
            mapData: event.data,
            uploadProgress: (sent, total) {
              if (total != -1) {
                add(KycProgressUpdateEvent(progress: sent / total));
              }
            });
        if (results?.statusCode == 200 || results?.statusCode == 201) {
          emit(KycSuccessState());
        } else {
          emit(KycErrorState(
              errorMsg:
                  "${results?.message} ${results?.data} ${results?.statusCode}"));
        }
      } catch (exception) {
        emit(KycErrorState(errorMsg: "${exception.toString()}"));
      }
    }
}
}
abstract class KycEvent {}

class KycUploadEvent extends KycEvent {
  List<ImageUploadModel> imgUploadModelList;
  Map<String, dynamic> data;
  KycUploadEvent({required this.data, required this.imgUploadModelList});
}

class KycProgressUpdateEvent extends KycEvent {
  final double progress;
  KycProgressUpdateEvent({required this.progress});
}
abstract class KycState extends Equatable{
}
class KycInitState extends KycState{
  @override
  List<Object?> get props => [];
}
class KycLoadingState extends KycState {
  @override
  List<Object?> get props => [];
}

class KycUploadingProgressState extends KycState {
  final double progress;
  KycUploadingProgressState({required this.progress});
  @override
  List<Object?> get props => [progress];
}
class KycSuccessState extends KycState{
  @override
  List<Object?> get props => [];
}

class KycErrorState extends KycState{
  final String errorMsg;
  KycErrorState({required this.errorMsg});
  @override
  List<Object?> get props => [];
}

