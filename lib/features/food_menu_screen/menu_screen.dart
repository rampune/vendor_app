import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/navigation_util.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_file_picker_container.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/food_menu_screen/bloc/food_menu_bloc.dart';
import 'package:new_pubup_partner/utils/save_and_retrive_file.dart';
import 'menu_controller.dart';
class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});
  @override
  State<MenuScreen> createState() => _MenuScreenState();
}
class _MenuScreenState extends State<MenuScreen> {
  FoodMenuBloc foodMenuBloc=FoodMenuBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Food Menu"),

    ),
    body: SingleChildScrollView(
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
              (title: "food", controller: FoodMenuController.foodMenuPhotoController)
      ,20.height(),
            CustomFilePickerContainer
              (title: "drinks", controller: FoodMenuController.foodMenuDrinkPhotoController)
            ,20.height(),
            CustomFilePickerContainer
              (title: "snacks", controller: FoodMenuController.foodMenu3PhotoController)
            ,20.height(),
            CustomFilePickerContainer
              (title: "other", controller: FoodMenuController.foodMenu4PhotoController)
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
          File? menu1=    await loadFile(fileName: FoodMenuController.foodMenuPhotoController.text);
          File? menu2=    await loadFile(fileName: FoodMenuController.foodMenuDrinkPhotoController.text);
          File? menu3=    await loadFile(fileName: FoodMenuController.foodMenu3PhotoController.text);
          File? menu4=    await loadFile(fileName: FoodMenuController.foodMenu4PhotoController.text);

          List<File> listFile=[];
          if(menu1!=null){
            listFile.add(menu1);
          }
          if(menu2!=null){
            listFile.add(menu2);
          }
          if(menu3!=null){
            listFile.add(menu3);
          }
          if(menu4!=null){
            listFile.add(menu4);
          }
          foodMenuBloc.add(FoodMenuUploadEvent(vendorId: BusinessProfileData.vendorId()??'',

    listImageUploadModel: listFile.map((item)=>
    ImageUploadModel(file: item, fileName: "menu")
    ).toList()

          )


          );
                })


          ],),
      ),
    ),

    );
  }
}
