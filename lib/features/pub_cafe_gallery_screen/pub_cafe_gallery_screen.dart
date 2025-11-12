import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/navigation_util.dart';
import 'package:new_pubup_partner/features/pub_cafe_gallery_screen/pub_cafe_gallery_controller.dart';
import 'package:new_pubup_partner/features/pub_cafe_gallery_screen/state/pub_cafe_gallery_state.dart';

import '../../config/common_functions.dart';
import '../../data/source/local/global_data/profile_data.dart';
import '../../data/source/network/dio_client.dart';
import '../../utils/save_and_retrive_file.dart';
import '../common_widgets/custom_button.dart';
import '../common_widgets/custom_file_picker_container.dart';
import '../common_widgets/overlay_loading_progress.dart';
import 'bloc/pub_cafe_gallery_bloc.dart';
import 'event/pub_cafe_gallery_event.dart';

class PubCafeGalleryScreen extends StatelessWidget {
   PubCafeGalleryScreen({super.key});

  PubCafeGalleryBloc pubCafeGalleryBloc=PubCafeGalleryBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Gallery"),
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
              Text("PubCafeGallery",
                style: context.titleMedium()?.copyWith(
                    fontWeight: FontWeight.bold
                ),
              ),
              20.height(),

              CustomFilePickerContainer
                (title: "Image 1", controller: PubCafeGalleryController.pubCafe1PhotoController)
              ,20.height(),
              CustomFilePickerContainer
                (title: "Image 2", controller: PubCafeGalleryController.pubCafe2DrinkPhotoController)
              ,20.height(),
              CustomFilePickerContainer
                (title: "Image 3", controller: PubCafeGalleryController.pubCafe3PhotoController)
              ,20.height(),
              CustomFilePickerContainer
                (title: "Image 4", controller: PubCafeGalleryController.pubCafe4PhotoController)
              ,20.height(),

              BlocListener<PubCafeGalleryBloc,
                  PubCafeGalleryState>(
                bloc: pubCafeGalleryBloc,
                listener: (BuildContext context,
                    PubCafeGalleryState state
                    ){

                  state is PubCafeGalleryLoadingState?OverlayLoadingProgress.start(context):OverlayLoadingProgress.stop();

                  if(state is PubCafeGallerySuccessState)
                  {
                    showSuccessAlert(context: context, title: "Gallery Uploaded",
                        callBack: (){
                          context.pop();
                          context.pop();
                        });
                  }else if(state is PubCafeGalleryErrorState){
                    showAlert(context, state.errorMsg);
                  }
                },child: SizedBox.shrink(),),

              40.height(),
              CustomButton(buttonText: "Submit",
                  onPress: ()async {
                    File? menu1=    await loadFile(fileName: PubCafeGalleryController.pubCafe1PhotoController.text);
                    File? menu2=    await loadFile(fileName: PubCafeGalleryController.pubCafe2DrinkPhotoController.text);
                    File? menu3=    await loadFile(fileName: PubCafeGalleryController.pubCafe3PhotoController.text);
                    File? menu4=    await loadFile(fileName: PubCafeGalleryController.pubCafe4PhotoController.text);

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
                    pubCafeGalleryBloc.add(PubCafeGalleryUploadEvent(vendorId: BusinessProfileData.vendorId()??'',
                        listImageUploadModel: listFile.map((item)=>
                            ImageUploadModel(file: item, fileName: "gallery")
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
