import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        if (vendorId.isEmpty) {
          emit(PubCafeGalleryErrorState(errorMsg: "Invalid Vendor Id"));
          return;
        }
        debugPrint('Uploading menu for vendorId: $vendorId, images: ${event.listImageUploadModel}');
        ApiResults? apiResult = await PubCafeGalleryRepository.patchPubCafeGalleryRepository(
          listImages: event.listImageUploadModel,
          vendorId: vendorId,
        );

        if (apiResult?.statusCode == 410 || apiResult?.statusCode == 404) {
          debugPrint('Patch failed, falling back to upload: ${apiResult?.data}');
          ApiResults? uploadResult = await PubCafeGalleryRepository.uploadPubCafeGalleryRepository(
            listImages: event.listImageUploadModel,
            mapData: {"vendor_data": vendorId},
          );
          if (uploadResult?.statusCode == 200 || uploadResult?.statusCode == 201) {
            debugPrint('Upload successful: ${uploadResult?.data}');
            emit(PubCafeGallerySuccessState());
          } else {
            emit(PubCafeGalleryErrorState(errorMsg: "${uploadResult?.data} ${uploadResult?.message}"));
          }
        } else if (apiResult?.statusCode == 200 || apiResult?.statusCode == 201) {
          debugPrint('Patch successful: ${apiResult?.data}');
          emit(PubCafeGallerySuccessState());
        } else {
          emit(PubCafeGalleryErrorState(errorMsg: "${apiResult?.data} ${apiResult?.message}"));
        }
      } catch (exception) {
        debugPrint('Exception during upload: $exception');
        emit(PubCafeGalleryErrorState(errorMsg: "Upload failed: $exception"));
      }
    }
  }
}