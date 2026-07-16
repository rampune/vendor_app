import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/navigation_util.dart';
import 'package:new_pubup_partner/features/pub_cafe_gallery_screen/pub_cafe_gallery_controller.dart';
import 'package:new_pubup_partner/features/pub_cafe_gallery_screen/state/pub_cafe_gallery_state.dart';

import 'package:new_pubup_partner/config/string.dart';
import '../../config/common_functions.dart';
import '../../data/source/local/global_data/profile_data.dart';
import '../../data/source/network/dio_client.dart';
import '../../utils/save_and_retrive_file.dart';
import '../common_widgets/custom_button.dart';
import '../common_widgets/custom_file_picker_container.dart';
import '../common_widgets/overlay_loading_progress.dart';
import 'bloc/pub_cafe_gallery_bloc.dart';
import 'event/pub_cafe_gallery_event.dart';
import 'repository/pub_cafe_gallery_repository.dart';

class PubCafeGalleryScreen extends StatefulWidget {
  const PubCafeGalleryScreen({super.key});

  @override
  State<PubCafeGalleryScreen> createState() => _PubCafeGalleryScreenState();
}

class _PubCafeGalleryScreenState extends State<PubCafeGalleryScreen> {
  final PubCafeGalleryBloc pubCafeGalleryBloc = PubCafeGalleryBloc();

  bool _isLoadingGallery = true;
  int _existingImagesCount = 0;
  final List<String> _initialFileNames = ["", "", "", ""];

  @override
  void initState() {
    super.initState();
    _clearControllers();
    _fetchExistingGallery();
  }

  /// Clear static controllers so stale data from previous sessions doesn't linger
  void _clearControllers() {
    PubCafeGalleryController.pubCafe1PhotoController.clear();
    PubCafeGalleryController.pubCafe2DrinkPhotoController.clear();
    PubCafeGalleryController.pubCafe3PhotoController.clear();
    PubCafeGalleryController.pubCafe4PhotoController.clear();
  }


  Future<void> _fetchExistingGallery() async {
    final vendorId = BusinessProfileData.vendorId() ?? '';
    if (vendorId.isEmpty) {
      if (mounted) setState(() => _isLoadingGallery = false);
      return;
    }

    try {
      final result = await PubCafeGalleryRepository.fetchGalleryRepository(
        vendorId: vendorId,
      );

      if (result?.statusCode != 200 || result?.data == null) {
        debugPrint('Failed to fetch gallery or invalid response');
        return;
      }

      final data = result!.data;
      debugPrint('Gallery API response: $data');

      Map<String, dynamic>? galleryMap;

      // Handle response structure
      if (data is Map<String, dynamic>) {
        if (data['data'] is Map<String, dynamic>) {
          galleryMap = data['data'] as Map<String, dynamic>;
        } else {
          galleryMap = data;
        }
      }

      if (galleryMap != null) {
        final List<dynamic> galleryList = galleryMap['gallery'] ?? [];

        debugPrint('Found ${galleryList.length} images in gallery');

        // Assign first 4 images to respective controllers
        _setControllerFromUrl(
          PubCafeGalleryController.pubCafe1PhotoController,
          galleryList.isNotEmpty ? galleryList[0]?.toString() : null,
          0,
        );
        _setControllerFromUrl(
          PubCafeGalleryController.pubCafe2DrinkPhotoController,
          galleryList.length > 1 ? galleryList[1]?.toString() : null,
          1,
        );
        _setControllerFromUrl(
          PubCafeGalleryController.pubCafe3PhotoController,
          galleryList.length > 2 ? galleryList[2]?.toString() : null,
          2,
        );
        _setControllerFromUrl(
          PubCafeGalleryController.pubCafe4PhotoController,
          galleryList.length > 3 ? galleryList[3]?.toString() : null,
          3,
        );


        setState(() {
          _existingImagesCount = galleryList.length;
        });
        debugPrint('✅ Successfully pre-populated all 4 gallery controllers. Existing count: $_existingImagesCount');
      }
    } catch (e, stack) {
      debugPrint('Failed to fetch existing gallery: $e');
      debugPrint('Stack: $stack');
    } finally {
      if (mounted) {
        setState(() => _isLoadingGallery = false);
      }
    }
  }

  void _setControllerFromUrl(TextEditingController controller, String? url, int index) {
    if (url == null || url.isEmpty) {
      controller.clear();
      _initialFileNames[index] = "";
      return;
    }

    final fileName = url.split('/').last;
    if (fileName.isNotEmpty) {
      controller.text = fileName;
      _initialFileNames[index] = fileName;
    } else {
      controller.clear();
      _initialFileNames[index] = "";
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Gallery"),
      ),
      body: _isLoadingGallery
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.height(),
                    Text(
                      "PubCafeGallery",
                      style: context.titleMedium()?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    20.height(),

                    CustomFilePickerContainer(
                      title: "Image 1",
                      controller:
                          PubCafeGalleryController.pubCafe1PhotoController,
                    ),
                    20.height(),
                    CustomFilePickerContainer(
                      title: "Image 2",
                      controller: PubCafeGalleryController
                          .pubCafe2DrinkPhotoController,
                    ),
                    20.height(),
                    CustomFilePickerContainer(
                      title: "Image 3",
                      controller:
                          PubCafeGalleryController.pubCafe3PhotoController,
                    ),
                    20.height(),
                    CustomFilePickerContainer(
                      title: "Image 4",
                      controller:
                          PubCafeGalleryController.pubCafe4PhotoController,
                    ),
                    20.height(),

                    BlocListener<PubCafeGalleryBloc, PubCafeGalleryState>(
                      bloc: pubCafeGalleryBloc,
                      listener: (BuildContext context,
                          PubCafeGalleryState state) {
                        state is PubCafeGalleryLoadingState
                            ? OverlayLoadingProgress.start(context)
                            : OverlayLoadingProgress.stop();

                        if (state is PubCafeGallerySuccessState) {
                          showSuccessAlert(
                            context: context,
                            title: "Gallery Uploaded",
                            callBack: () {
                              context.pop();
                              context.pop();
                            },
                          );
                        } else if (state is PubCafeGalleryErrorState) {
                          showAlert(context, state.errorMsg);
                        }
                      },
                      child: const SizedBox.shrink(),
                    ),

                    40.height(),
                    CustomButton(
                      buttonText: "Submit",
                      onPress: () async {
                        // Only upload images the user has newly picked locally.
                        // Controllers pre-filled from API will have a filename
                        // but no corresponding local file → loadFile returns null → skip.
                        Map<int, File> imagesWithIndex = {};

                        if (PubCafeGalleryController.pubCafe1PhotoController.text != _initialFileNames[0]) {
                          File? file = await loadFile(fileName: PubCafeGalleryController.pubCafe1PhotoController.text);
                          if (file != null) imagesWithIndex[0] = file;
                        }
                        if (PubCafeGalleryController.pubCafe2DrinkPhotoController.text != _initialFileNames[1]) {
                          File? file = await loadFile(fileName: PubCafeGalleryController.pubCafe2DrinkPhotoController.text);
                          if (file != null) imagesWithIndex[1] = file;
                        }
                        if (PubCafeGalleryController.pubCafe3PhotoController.text != _initialFileNames[2]) {
                          File? file = await loadFile(fileName: PubCafeGalleryController.pubCafe3PhotoController.text);
                          if (file != null) imagesWithIndex[2] = file;
                        }
                        if (PubCafeGalleryController.pubCafe4PhotoController.text != _initialFileNames[3]) {
                          File? file = await loadFile(fileName: PubCafeGalleryController.pubCafe4PhotoController.text);
                          if (file != null) imagesWithIndex[3] = file;
                        }


                        // Calculate removed indices (images that were initially there but are now removed/cleared)
                        List<int> removedIndices = [];

                        if (_initialFileNames[0].isNotEmpty &&
                            (PubCafeGalleryController.pubCafe1PhotoController.text == AppStr.filePickerDefaultText ||
                             PubCafeGalleryController.pubCafe1PhotoController.text.isEmpty)) {
                          removedIndices.add(0);
                        }
                        if (_initialFileNames[1].isNotEmpty &&
                            (PubCafeGalleryController.pubCafe2DrinkPhotoController.text == AppStr.filePickerDefaultText ||
                             PubCafeGalleryController.pubCafe2DrinkPhotoController.text.isEmpty)) {
                          removedIndices.add(1);
                        }
                        if (_initialFileNames[2].isNotEmpty &&
                            (PubCafeGalleryController.pubCafe3PhotoController.text == AppStr.filePickerDefaultText ||
                             PubCafeGalleryController.pubCafe3PhotoController.text.isEmpty)) {
                          removedIndices.add(2);
                        }
                        if (_initialFileNames[3].isNotEmpty &&
                            (PubCafeGalleryController.pubCafe4PhotoController.text == AppStr.filePickerDefaultText ||
                             PubCafeGalleryController.pubCafe4PhotoController.text.isEmpty)) {
                          removedIndices.add(3);
                        }

                        pubCafeGalleryBloc.add(
                          PubCafeGalleryUploadEvent(
                            vendorId: BusinessProfileData.vendorId() ?? '',
                            imagesWithIndex: imagesWithIndex,
                            existingImagesCount: _existingImagesCount,
                            removedIndices: removedIndices,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
