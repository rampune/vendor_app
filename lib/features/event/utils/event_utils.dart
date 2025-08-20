part of '../event_booking.dart';
Future<List<ImageUploadModel>> eventImageList({required EventPostModel model})async{



  List<ImageUploadModel> listImages=[];

  List<dynamic> listDynamic= jsonDecode(model.artists??"[]");
  List<ArtistsModel>?list=   listDynamic.map((item)=>ArtistsModel.fromJson(item)).toList();
  print("--0009 $list");
  for(int index=0;index<(list.length);index++){

    File ?file= await loadFile(fileName: list[index].imgPath??'');
    if(file!=null){
      listImages.add(ImageUploadModel(file: file, fileName: "artist_image_$index"));
    }

  }


  File?galaryImage1,galaryImage2,galaryImage3,bannerImage,vanueLayoutPhoto;
  try{
    galaryImage1=await loadFile(fileName: EventController.venueGalleryPhoto1.text);
    if(galaryImage1!=null){
      listImages.add(ImageUploadModel(file: galaryImage1, fileName: "galleries"));
    }
    galaryImage2=await loadFile(fileName: EventController.venueGalleryPhoto2.text);
    if(galaryImage2!=null){
      listImages.add(ImageUploadModel(file: galaryImage2, fileName: "galleries"));
    }

    galaryImage3=await loadFile(fileName: EventController.venueGalleryPhoto3.text);
    if(galaryImage3!=null){
      listImages.add(ImageUploadModel(file: galaryImage3, fileName: "galleries"));
    }


    bannerImage=await loadFile(fileName: EventController.eventBannerPhoto.text);
    if(bannerImage!=null){
      listImages.add(ImageUploadModel(file: bannerImage, fileName: "event_banner"));
    }

    vanueLayoutPhoto=await loadFile(fileName: EventController.venueLayoutPhoto.text);
    if(vanueLayoutPhoto!=null){
      listImages.add(ImageUploadModel(file: vanueLayoutPhoto, fileName: "venue_layout"));
    }
  }catch(exception){
    print("--0009$exception");

  }

  return listImages;

}