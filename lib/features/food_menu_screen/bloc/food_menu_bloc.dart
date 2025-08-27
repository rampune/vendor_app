// import 'package:equatable/equatable.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:new_pubup_partner/config/common_functions.dart';
// import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
// import 'package:new_pubup_partner/data/source/network/dio_client.dart';
// import 'package:new_pubup_partner/features/food_menu_screen/repository/food_repository.dart';
//
// class FoodMenuBloc extends Bloc<FoodMenuEvent, FoodMenuState> {
//   FoodMenuBloc() : super(FoodInitState()) {
//     on(handler);
//   }
//
//   handler(FoodMenuEvent event, Emitter<FoodMenuState> emit) async {
//     if (event is FoodMenuUploadEvent) {
//       emit(FoodLoadingState());
//       try {
//         ApiResults? apiResult =
//             await FoodMenuRepository.patchFoodMenuRepository(
//               listImages: event.listImageUploadModel,
//               vendorId: event.vendorId,
//             );
//
//         debugPrint('event.listImageUploadModel........${event.listImageUploadModel}');
//
//         if (apiResult?.statusCode == 410) {
//           ApiResults? apiResult =
//               await FoodMenuRepository.uploadFoodMenuRepository(
//                 listImages: event.listImageUploadModel,
//
//                 mapData: {"vendor_data":event.vendorId},
//               );
// if(apiResult?.statusCode==200||apiResult?.statusCode==201){
//   debugPrint('event.listImageUploadModel........${event.listImageUploadModel}');
//   emit(FoodSuccessState());
// }else {
//   emit(FoodErrorState(errorMsg: "${apiResult?.data} ${apiResult?.message}"));
// }
//
//
//           print("....#######${apiResult?.data}");
//         } else {
//           emit(FoodSuccessState());
//         }
//         print("----${apiResult?.data}");
//       } catch (exception) {
//         emit(FoodErrorState(errorMsg: "${exception.toString()}"));
//       }
//     }
//   }
// }
//
// abstract class FoodMenuEvent {}
//
// class FoodMenuUploadEvent extends FoodMenuEvent {
//   List<ImageUploadModel> listImageUploadModel;
//   String vendorId;
//
//   FoodMenuUploadEvent({
//     required this.vendorId,
//     required this.listImageUploadModel,
//   });
// }
//
// abstract class FoodMenuState extends Equatable {}
//
// class FoodInitState extends FoodMenuState {
//   @override
//   List<Object?> get props => [];
// }
//
// class FoodLoadingState extends FoodMenuState {
//   @override
//   List<Object?> get props => [];
// }
//
// class FoodErrorState extends FoodMenuState {
//   final String errorMsg;
//
//   FoodErrorState({required this.errorMsg});
//
//   @override
//   List<Object?> get props => [];
// }
//
// class FoodSuccessState extends FoodMenuState {
//   @override
//   List<Object?> get props => [];
// }




//Fixme: Saransh New code
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/data/source/network/api_result_handler.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/food_menu_screen/repository/food_repository.dart';

class FoodMenuBloc extends Bloc<FoodMenuEvent, FoodMenuState> {
  FoodMenuBloc() : super(FoodInitState()) {
    on<FoodMenuUploadEvent>(handler);
  }

  Future<void> handler(FoodMenuEvent event, Emitter<FoodMenuState> emit) async {
    if (event is FoodMenuUploadEvent) {
      emit(FoodLoadingState());
      try {
        final vendorId = event.vendorId;
        if (vendorId.isEmpty) {
          emit(FoodErrorState(errorMsg: "Invalid Vendor Id"));
          return;
        }
        debugPrint('Uploading menu for vendorId: $vendorId, images: ${event.listImageUploadModel}');
        ApiResults? apiResult = await FoodMenuRepository.patchFoodMenuRepository(
          listImages: event.listImageUploadModel,
          vendorId: vendorId,
        );

        if (apiResult?.statusCode == 410 || apiResult?.statusCode == 404) {
          debugPrint('Patch failed, falling back to upload: ${apiResult?.data}');
          ApiResults? uploadResult = await FoodMenuRepository.uploadFoodMenuRepository(
            listImages: event.listImageUploadModel,
            mapData: {"vendor_data": vendorId},
          );
          if (uploadResult?.statusCode == 200 || uploadResult?.statusCode == 201) {
            debugPrint('Upload successful: ${uploadResult?.data}');
            emit(FoodSuccessState());
          } else {
            emit(FoodErrorState(errorMsg: "${uploadResult?.data} ${uploadResult?.message}"));
          }
        } else if (apiResult?.statusCode == 200 || apiResult?.statusCode == 201) {
          debugPrint('Patch successful: ${apiResult?.data}');
          emit(FoodSuccessState());
        } else {
          emit(FoodErrorState(errorMsg: "${apiResult?.data} ${apiResult?.message}"));
        }
      } catch (exception) {
        debugPrint('Exception during upload: $exception');
        emit(FoodErrorState(errorMsg: "Upload failed: $exception"));
      }
    }
  }
}

abstract class FoodMenuEvent {}

class FoodMenuUploadEvent extends FoodMenuEvent {
  final List<ImageUploadModel> listImageUploadModel;
  final String vendorId;

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
  List<Object?> get props => [errorMsg];
}

class FoodSuccessState extends FoodMenuState {
  @override
  List<Object?> get props => [];
}
