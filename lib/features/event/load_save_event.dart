import 'dart:convert';
import 'dart:developer';
import 'package:new_pubup_partner/features/admin_details/model/business_resister_model.dart';

import '../../config/string.dart';
import '../../data/source/local/global_data/profile_data.dart';
import '../../data/source/local/hive_box.dart';
import 'event_controller/event_controller.dart';
import 'model/EventPostModel.dart';
class LoadSaveEvent{
  LoadSaveEvent._private();
  static LoadSaveEvent instance=LoadSaveEvent._private();
  factory LoadSaveEvent()=>instance;
  saveEventToHive() {

    BusinessData ?businessData=BusinessProfileData.getBusinessRegistrationData()?.businessData;

    EventPostModel eventPostModel =
    EventPostModel(
        parkingType: EventController.parkingTypeCotroller.text,
        eventName: EventController.eventNameController.text,
        eventDate: EventController.eventDateController.text,
        startTime: EventController.eventStartTimeController.text,
        endTime: EventController.eventEndTimeController.text,
        venue: EventController.venueController.text,
        keywords: EventController.keywordController.text,
        description: EventController.descriptionController.text,
        minumumAgeRequirements: EventController.minimumAgeRequired.text,
        termConditions: EventController.eventTermAndCondition.text,
        vendorData: BusinessProfileData.vendorId()??"",
        faqDetails: "sdfsdfsd",
        seatingArrangement: "sdfsdfsd",
        kidsFriendly:'kids',
        petsFriendly: "pet freindly",
        layout: EventController.venueLayout.text,
        bannerImg: EventController.eventBannerPhoto.text,
        galaryImagePath1: EventController.venueGalleryPhoto1.text,
        galaryImagePath2: EventController.venueGalleryPhoto2.text,
        galaryImagePath3: EventController.venueGalleryPhoto3.text,
        location: jsonEncode({
          "address":businessData?.address,
          "state":businessData?.state,
          "city":businessData?.city,
          "pinCode":businessData?.pinCode
        }..removeWhere((key,value)=>value==null)),

        artists: jsonEncode(EventController.artistDataList),
        ticketModelInString:jsonEncode(EventController.listTickets),
        event_category_data: "${EventController.categoryListInt}".replaceAll("[", "").replaceAll("]", ""),
        tables:jsonEncode(EventController.listEventTable)

    );

    MyHiveBox.instance.getBox().put(
        AppStr.saveEventData, jsonEncode(eventPostModel.toJson()));
  }




  loadEventFromHive() {
    if (MyHiveBox.instance.getBox().get(
        AppStr.saveEventData) != null) {
      log("data loged ${ MyHiveBox.instance.getBox().get(
          AppStr.saveEventData)}");
      try {
        EventPostModel model = EventPostModel.fromJson(
            jsonDecode(MyHiveBox.instance.getBox().get(
                AppStr.saveEventData, defaultValue: "{}")));
        EventController.eventNameController.text = model.eventName ?? '';
        EventController.eventDateController.text = model.eventDate ?? '';
        EventController.eventStartTimeController.text = model.startTime ?? '';
        EventController.eventEndTimeController.text = model.endTime ?? '';
        EventController.venueController.text = model.venue ?? '';
        EventController.keywordController.text = model.keywords?? '';
        EventController.descriptionController.text = model.description ?? '';
        EventController.minimumAgeRequired.text = model.minumumAgeRequirements ?? '';
        EventController.eventTermAndCondition.text = model.termConditions ?? '';
        EventController.venueLayout.text=model.layout??"";
        EventController.eventBannerPhoto.text=model.bannerImg??"";
        EventController.venueGalleryPhoto1.text=model.galaryImagePath1??"";
        EventController.venueGalleryPhoto2.text=model.galaryImagePath2??"";
        EventController.venueGalleryPhoto3.text=model.galaryImagePath3??"";
        EventController.parkingTypeCotroller.text=model.parkingType??"";
        //load  data artist,table and
        List<dynamic> data=jsonDecode(model.ticketModelInString??"[]");
        List<TicketModel> listTicketModel=data.map((item)=>TicketModel.fromJson(item)).toList();
        EventController.listTickets=listTicketModel;
//load artist
        List<dynamic> artistData=jsonDecode(model.artists??"[]");
        List<ArtistsModel> artistModelList=artistData.map((item)=>ArtistsModel.fromJson(item)).toList();
        EventController.artistDataList=artistModelList;
//load table
        List<dynamic> tableData=jsonDecode(model.tables??"[]");
        List<EventTableModel> eventTableList=tableData.map((item)=>EventTableModel.fromJson(item)).toList();
        EventController.listEventTable=eventTableList;

        print("amra009----$listTicketModel");


      }catch(exception){
        log("\n\namra007 ${exception} \n\n\n\n");
      }
    }else{


      EventController.eventNameController.clear();
      EventController.eventDateController.clear();
      EventController.eventStartTimeController.clear();
      EventController.eventEndTimeController.clear();
      EventController.venueController.clear();
      EventController.keywordController.clear();
      EventController.descriptionController.clear();
      EventController.minimumAgeRequired.clear();
      EventController.eventTermAndCondition.clear();
      EventController.venueLayout.clear();
      EventController.eventBannerPhoto.clear();
      EventController.venueGalleryPhoto1.clear();
      EventController.venueGalleryPhoto2.clear();
      EventController.venueGalleryPhoto3.clear();
      EventController.parkingTypeCotroller.clear();
      EventController.listTickets=[];
      EventController.artistDataList=[];
      EventController.listEventTable=[];


    }


  }
}