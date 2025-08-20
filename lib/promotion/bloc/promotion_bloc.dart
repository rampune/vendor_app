import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/source/network/api_result_handler.dart';
import '../model/promotion_model.dart';
import '../repository/promotion_repository.dart';

class PromotionBloc extends Bloc<PromotionEvent,
PromotionState>{
  PromotionBloc():super(PromotionInitState()){
    on(handler);
  }
  handler(PromotionEvent event,
      Emitter<PromotionState> emit)async{
    emit(PromotionLoadingState());
    try {
      if (event is PromotionGetBannerEvent) {
        ApiResults results = await PromotionRepository
            .getPromotionCardRepository();
        if (results.statusCode == 200) {
          emit(PromotionSuccessState(
              promotionModel: PromotionModel.fromJson(results.data)));
        } else {
          emit(PromotionErrorState(
              errorMsg: "${results.data} ${results.message}"));
        }
      }
    }catch(exception){
      emit(PromotionErrorState(errorMsg: "${exception}"));
    }
  }
}
abstract class PromotionEvent {}
 class PromotionGetBannerEvent extends PromotionEvent{}
abstract class PromotionState extends Equatable{}
 class PromotionInitState extends PromotionState{
  @override
  List<Object?> get props => [];
 }
 class PromotionLoadingState extends PromotionState{
   @override
   List<Object?> get props => [];
 }
 class PromotionSuccessState extends PromotionState{
  final PromotionModel promotionModel;
  PromotionSuccessState({required this.promotionModel});
   @override
   List<Object?> get props => [promotionModel];
 }
 class PromotionErrorState extends PromotionState{
  final String errorMsg;
  PromotionErrorState({required this.errorMsg});
   @override
   List<Object?> get props => [errorMsg];
 }