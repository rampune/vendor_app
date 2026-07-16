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
import 'dart:io';
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
        final images = event.imagesWithIndex;
        final existingCount = event.existingImagesCount;
        final removedIndices = event.removedIndices;

        if (vendorId.isEmpty) {
          emit(FoodErrorState(errorMsg: "Invalid Vendor Id"));
          return;
        }

        if (images.isEmpty && removedIndices.isEmpty) {
          emit(FoodErrorState(errorMsg: "No changes to save"));
          return;
        }

        ApiResults? finalResult;

        // 1. Process Deletions
        if (removedIndices.isNotEmpty) {
          debugPrint('Handling Menu Deletions for indices: $removedIndices');
          for (var idx in removedIndices) {
            finalResult = await FoodMenuRepository.deleteMenuImageRepository(
              vendorId: vendorId,
              index: idx,
            );
            if (finalResult?.statusCode != 200 && finalResult?.statusCode != 201) {
              emit(FoodErrorState(
                errorMsg: "Delete failed for index $idx: ${finalResult?.message}"
              ));
              return;
            }
          }
        }

        // 2. Process Updates and Additions
        if (images.isNotEmpty) {
          // CASE 1: First time upload
          if (existingCount == 0) {
            debugPrint('Menu Case 1: First time upload');
            final List<ImageUploadModel> listImages = images.values.map((file) {
              return ImageUploadModel(file: file as File, fileName: "menu");
            }).toList().cast<ImageUploadModel>();


            finalResult = await FoodMenuRepository.uploadFoodMenuRepository(
              listImages: listImages,
              mapData: {"vendor_data": vendorId},
            );
          } 
          // CASE 2, 3, 4: Existing images exist
          else {
            List<ImageUploadModel> updates = [];
            List<ImageUploadModel> additions = [];

            images.forEach((index, file) {
              if (index < existingCount) {
                // Update existing slot
                updates.add(ImageUploadModel(file: file, fileName: "image_index_$index"));
              } else {
                // New addition
                additions.add(ImageUploadModel(file: file, fileName: "menu"));
              }
            });

            // Handle Updates
            if (updates.isNotEmpty) {
              debugPrint('Handling Menu Updates: ${updates.length} images');
              finalResult = await FoodMenuRepository.updateFoodMenuImagesRepository(
                listImages: updates,
                vendorId: vendorId,
              );
              
              if (finalResult?.statusCode != 200 && finalResult?.statusCode != 201) {
                emit(FoodErrorState(errorMsg: "Update failed: ${finalResult?.message}"));
                return;
              }
            }

            // Handle Additions
            if (additions.isNotEmpty) {
              debugPrint('Handling Menu Additions: ${additions.length} images');
              finalResult = await FoodMenuRepository.patchFoodMenuRepository(
                listImages: additions,
                vendorId: vendorId,
              );
            }
          }
        }

        if (finalResult != null && (finalResult.statusCode == 200 || finalResult.statusCode == 201)) {
          emit(FoodSuccessState());
        } else {
          emit(FoodErrorState(
              errorMsg: finalResult?.message ?? "Operation failed with unknown error"));
        }
      } catch (exception) {
        debugPrint('Exception during menu upload/delete: $exception');
        emit(FoodErrorState(errorMsg: "Operation failed: $exception"));
      }
    }
  }
}

abstract class FoodMenuEvent {}

class FoodMenuUploadEvent extends FoodMenuEvent {
  final Map<int, File> imagesWithIndex;
  final String vendorId;
  final int existingImagesCount;
  final List<int> removedIndices;

  FoodMenuUploadEvent({
    required this.vendorId,
    required this.imagesWithIndex,
    required this.existingImagesCount,
    this.removedIndices = const [],
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

