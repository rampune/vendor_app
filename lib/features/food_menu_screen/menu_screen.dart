import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/navigation_util.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_file_picker_container.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/food_menu_screen/bloc/food_menu_bloc.dart';
import 'package:new_pubup_partner/features/food_menu_screen/repository/food_repository.dart';
import 'package:new_pubup_partner/utils/save_and_retrive_file.dart';
import 'menu_controller.dart';
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}
class _MenuScreenState extends State<MenuScreen> {
  FoodMenuBloc foodMenuBloc=FoodMenuBloc();
  bool _isLoadingMenu = true;
  int _existingImagesCount = 0;
  final List<String> _initialFileNames = ["", "", "", "", ""];

  @override
  void initState() {
    super.initState();
    _clearControllers();
    _fetchExistingMenu();       // ← Add this
  }


  void _clearControllers() {
    FoodMenuController.foodMenuPhotoController.clear();
    FoodMenuController.foodMenuDrinkPhotoController.clear();
    FoodMenuController.foodMenu3PhotoController.clear();
    FoodMenuController.foodMenu4PhotoController.clear();
    FoodMenuController.foodMenu5PhotoController.clear();
  }

  /// Fetch existing Menu images
  Future<void> _fetchExistingMenu() async {
    final vendorId = BusinessProfileData.vendorId() ?? '';
    if (vendorId.isEmpty) {
      if (mounted) setState(() => _isLoadingMenu = false);
      return;
    }

    try {
      // Assuming you will create this method in repository
      final result = await FoodMenuRepository.fetchMenuRepository(vendorId: vendorId);

      if (result?.statusCode == 200 && result?.data != null) {
        final data = result!.data;
        debugPrint('Menu API Response: $data');

        Map<String, dynamic>? menuMap;

        if (data is Map<String, dynamic>) {
          menuMap = data['data'] is Map<String, dynamic>
              ? data['data'] as Map<String, dynamic>
              : data;
        }

        if (menuMap != null) {
          final List<dynamic> menuImages = menuMap['menu'] ?? [];   // ← Key is 'menu' usually

          _setControllerFromUrl(FoodMenuController.foodMenuPhotoController,
              menuImages.isNotEmpty ? menuImages[0]?.toString() : null, 0);

          _setControllerFromUrl(FoodMenuController.foodMenuDrinkPhotoController,
              menuImages.length > 1 ? menuImages[1]?.toString() : null, 1);

          _setControllerFromUrl(FoodMenuController.foodMenu3PhotoController,
              menuImages.length > 2 ? menuImages[2]?.toString() : null, 2);

          _setControllerFromUrl(FoodMenuController.foodMenu4PhotoController,
              menuImages.length > 3 ? menuImages[3]?.toString() : null, 3);

          _setControllerFromUrl(FoodMenuController.foodMenu5PhotoController,
              menuImages.length > 4 ? menuImages[4]?.toString() : null, 4);

          setState(() {
            _existingImagesCount = menuImages.length;
          });


          debugPrint('✅ Menu controllers pre-populated with ${menuImages.length} images');
        }
      }
    } catch (e) {
      debugPrint('Failed to fetch existing menu: $e');
    } finally {
      if (mounted) {
        setState(() => _isLoadingMenu = false);
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
      title: Text("Food Menu"),

    ),
      body: _isLoadingMenu
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        10.height(),
          Text("Menu",
          style: context.titleMedium()?.copyWith(
            fontWeight: FontWeight.bold
          ),
          ),
            20.height(),

            CustomFilePickerContainer
              (title: "Food", controller: FoodMenuController.foodMenuPhotoController)
      ,20.height(),
            CustomFilePickerContainer
              (title: "Drinks", controller: FoodMenuController.foodMenuDrinkPhotoController)
            ,20.height(),
            CustomFilePickerContainer
              (title: "Snacks", controller: FoodMenuController.foodMenu3PhotoController)
            ,20.height(),
            CustomFilePickerContainer
              (title: "Other", controller: FoodMenuController.foodMenu4PhotoController),
          20.height(),
            CustomFilePickerContainer
              (title: "USP", controller: FoodMenuController.foodMenu5PhotoController)
            ,20.height(),


            BlocListener<FoodMenuBloc,
          FoodMenuState>(
                bloc: foodMenuBloc,
                listener: (BuildContext context,
            FoodMenuState state
            ){

              state is FoodLoadingState?OverlayLoadingProgress.start(context):OverlayLoadingProgress.stop();

                if(state is FoodSuccessState)
                {
                 showSuccessAlert(context: context, title: "Menu Uploaded",
                 callBack: (){
                   context.pop();
                   context.pop();
                 });
                }else if(state is FoodErrorState){
                  showAlert(context, state.errorMsg);
                }
            },child: SizedBox.shrink(),),

            40.height(),



            CustomButton(buttonText: "Submit",
                onPress: ()async {
                  Map<int, File> imagesWithIndex = {};

                  if (FoodMenuController.foodMenuPhotoController.text != _initialFileNames[0]) {
                    File? file = await loadFile(fileName: FoodMenuController.foodMenuPhotoController.text);
                    if (file != null) imagesWithIndex[0] = file;
                  }
                  if (FoodMenuController.foodMenuDrinkPhotoController.text != _initialFileNames[1]) {
                    File? file = await loadFile(fileName: FoodMenuController.foodMenuDrinkPhotoController.text);
                    if (file != null) imagesWithIndex[1] = file;
                  }
                  if (FoodMenuController.foodMenu3PhotoController.text != _initialFileNames[2]) {
                    File? file = await loadFile(fileName: FoodMenuController.foodMenu3PhotoController.text);
                    if (file != null) imagesWithIndex[2] = file;
                  }
                  if (FoodMenuController.foodMenu4PhotoController.text != _initialFileNames[3]) {
                    File? file = await loadFile(fileName: FoodMenuController.foodMenu4PhotoController.text);
                    if (file != null) imagesWithIndex[3] = file;
                  }
                  if (FoodMenuController.foodMenu5PhotoController.text != _initialFileNames[4]) {
                    File? file = await loadFile(fileName: FoodMenuController.foodMenu5PhotoController.text);
                    if (file != null) imagesWithIndex[4] = file;
                  }

                   // Calculate removed indices (images that were initially there but are now removed/cleared)
                  List<int> removedIndices = [];

                  if (_initialFileNames[0].isNotEmpty &&
                      (FoodMenuController.foodMenuPhotoController.text == AppStr.filePickerDefaultText ||
                       FoodMenuController.foodMenuPhotoController.text.isEmpty)) {
                    removedIndices.add(0);
                  }
                  if (_initialFileNames[1].isNotEmpty &&
                      (FoodMenuController.foodMenuDrinkPhotoController.text == AppStr.filePickerDefaultText ||
                       FoodMenuController.foodMenuDrinkPhotoController.text.isEmpty)) {
                    removedIndices.add(1);
                  }
                  if (_initialFileNames[2].isNotEmpty &&
                      (FoodMenuController.foodMenu3PhotoController.text == AppStr.filePickerDefaultText ||
                       FoodMenuController.foodMenu3PhotoController.text.isEmpty)) {
                    removedIndices.add(2);
                  }
                  if (_initialFileNames[3].isNotEmpty &&
                      (FoodMenuController.foodMenu4PhotoController.text == AppStr.filePickerDefaultText ||
                       FoodMenuController.foodMenu4PhotoController.text.isEmpty)) {
                    removedIndices.add(3);
                  }
                  if (_initialFileNames[4].isNotEmpty &&
                      (FoodMenuController.foodMenu5PhotoController.text == AppStr.filePickerDefaultText ||
                       FoodMenuController.foodMenu5PhotoController.text.isEmpty)) {
                    removedIndices.add(4);
                  }

                  foodMenuBloc.add(FoodMenuUploadEvent(
                    vendorId: BusinessProfileData.vendorId() ?? '',
                    imagesWithIndex: imagesWithIndex,
                    existingImagesCount: _existingImagesCount,
                    removedIndices: removedIndices,
                  ));
                })



          ],),
      ),
      ),
    );
  }
}
