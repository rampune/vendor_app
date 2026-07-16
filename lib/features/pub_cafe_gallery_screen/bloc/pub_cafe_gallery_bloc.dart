import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import '../../../data/source/network/api_result_handler.dart';
import '../event/pub_cafe_gallery_event.dart';
import '../repository/pub_cafe_gallery_repository.dart';
import '../state/pub_cafe_gallery_state.dart';

class PubCafeGalleryBloc extends Bloc<PubCafeGalleryEvent, PubCafeGalleryState> {
  PubCafeGalleryBloc() : super(PubCafeGalleryInitState()) {
    on<PubCafeGalleryUploadEvent>(handler);
  }

  Future<void> handler(PubCafeGalleryEvent event, Emitter<PubCafeGalleryState> emit) async {
    if (event is PubCafeGalleryUploadEvent) {
      emit(PubCafeGalleryLoadingState());
      try {
        final vendorId = event.vendorId;
        final images = event.imagesWithIndex;
        final existingCount = event.existingImagesCount;
        final removedIndices = event.removedIndices;

        if (vendorId.isEmpty) {
          emit(PubCafeGalleryErrorState(errorMsg: "Invalid Vendor Id"));
          return;
        }

        if (images.isEmpty && removedIndices.isEmpty) {
          emit(PubCafeGalleryErrorState(errorMsg: "No changes to save"));
          return;
        }

        ApiResults? finalResult;

        // 1. Process Deletions
        if (removedIndices.isNotEmpty) {
          debugPrint('Handling Deletions for indices: $removedIndices');
          for (var idx in removedIndices) {
            finalResult = await PubCafeGalleryRepository.deleteGalleryImageRepository(
              vendorId: vendorId,
              index: idx,
            );
            if (finalResult?.statusCode != 200 && finalResult?.statusCode != 201) {
              emit(PubCafeGalleryErrorState(
                errorMsg: "Delete failed for index $idx: ${finalResult?.message}"
              ));
              return;
            }
          }
        }

        // 2. Process Updates and Additions
        if (images.isNotEmpty) {
          // CASE 1: First time upload (No existing images)
          if (existingCount == 0) {
            debugPrint('Case 1: First time upload');
            final List<ImageUploadModel> listImages = images.values.map((file) {
              return ImageUploadModel(file: file as File, fileName: "gallery");
            }).toList().cast<ImageUploadModel>();

            finalResult = await PubCafeGalleryRepository.uploadPubCafeGalleryRepository(
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
                // This is an update to an existing image slot
                updates.add(ImageUploadModel(file: file, fileName: "image_index_$index"));
              } else {
                // This is a new addition
                additions.add(ImageUploadModel(file: file, fileName: "gallery"));
              }
            });

            // Handle Updates (Case 2 & 3)
            if (updates.isNotEmpty) {
              debugPrint('Handling Updates: ${updates.length} images');
              finalResult = await PubCafeGalleryRepository.updateGalleryImagesRepository(
                listImages: updates,
                vendorId: vendorId,
              );
              
              if (finalResult?.statusCode != 200 && finalResult?.statusCode != 201) {
                emit(PubCafeGalleryErrorState(errorMsg: "Update failed: ${finalResult?.message}"));
                return;
              }
            }

            // Handle Additions (Case 3 & 4)
            if (additions.isNotEmpty) {
              debugPrint('Handling Additions: ${additions.length} images');
              finalResult = await PubCafeGalleryRepository.patchPubCafeGalleryRepository(
                listImages: additions,
                vendorId: vendorId,
              );
            }
          }
        }

        if (finalResult != null && (finalResult.statusCode == 200 || finalResult.statusCode == 201)) {
          emit(PubCafeGallerySuccessState());
        } else {
          emit(PubCafeGalleryErrorState(
              errorMsg: finalResult?.message ?? "Operation failed with unknown error"));
        }
      } catch (exception) {
        debugPrint('Exception during upload/delete: $exception');
        emit(PubCafeGalleryErrorState(errorMsg: "Operation failed: $exception"));
      }
    }
  }
}