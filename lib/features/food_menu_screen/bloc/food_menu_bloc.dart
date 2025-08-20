import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/food_menu_screen/repository/food_repository.dart';

class FoodMenuBloc extends Bloc<FoodMenuEvent, FoodMenuState> {
  FoodMenuBloc() : super(FoodInitState()) {
    on(handler);
  }

  handler(FoodMenuEvent event, Emitter<FoodMenuState> emit) async {
    if (event is FoodMenuUploadEvent) {
      emit(FoodLoadingState());
      try {
        ApiResults? apiResult =
            await FoodMenuRepository.patchFoodMenuRepository(
              listImages: event.listImageUploadModel,
              vendorId: event.vendorId,
            );

        if (apiResult?.statusCode == 410) {
          ApiResults? apiResult =
              await FoodMenuRepository.uploadFoodMenuRepository(
                listImages: event.listImageUploadModel,

                mapData: {"vendor_data":event.vendorId},
              );
if(apiResult?.statusCode==200||apiResult?.statusCode==201){
  emit(FoodSuccessState());
}else {
  emit(FoodErrorState(errorMsg: "${apiResult?.data} ${apiResult?.message}"));
}


          print("${apiResult?.data}");
        } else {
          emit(FoodSuccessState());
        }
        print("----${apiResult?.data}");
      } catch (exception) {
        emit(FoodErrorState(errorMsg: "${exception.toString()}"));
      }
    }
  }
}

abstract class FoodMenuEvent {}

class FoodMenuUploadEvent extends FoodMenuEvent {
  List<ImageUploadModel> listImageUploadModel;
  String vendorId;

  FoodMenuUploadEvent({
    required this.vendorId,
    required this.listImageUploadModel,
  });
}

abstract class FoodMenuState extends Equatable {}

class FoodInitState extends FoodMenuState {
  @override
  List<Object?> get props => [];
}

class FoodLoadingState extends FoodMenuState {
  @override
  List<Object?> get props => [];
}

class FoodErrorState extends FoodMenuState {
  final String errorMsg;

  FoodErrorState({required this.errorMsg});

  @override
  List<Object?> get props => [];
}

class FoodSuccessState extends FoodMenuState {
  @override
  List<Object?> get props => [];
}
