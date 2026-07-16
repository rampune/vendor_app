// import 'dart:convert';
// import 'dart:developer';
// import 'package:new_pubup_partner/features/admin_details/model/business_resister_model.dart';
// import 'package:new_pubup_partner/features/event/model/artist_model.dart';
//
// import '../../config/string.dart';
// import '../../data/source/local/global_data/profile_data.dart';
// import '../../data/source/local/hive_box.dart';
// import 'event_controller/event_controller.dart';
// import 'model/EventPostModel.dart';
// class LoadSaveEvent{
//   LoadSaveEvent._private();
//   static LoadSaveEvent instance=LoadSaveEvent._private();
//   factory LoadSaveEvent()=>instance;
//   saveEventToHive() {
//
//     BusinessData ?businessData=BusinessProfileData.getBusinessRegistrationData()?.businessData;
//
//     EventPostModel eventPostModel =
//     EventPostModel(
//         parkingType: EventController.parkingTypeCotroller.text,
//         eventName: EventController.eventNameController.text,
//         eventDate: EventController.eventDateController.text,
//         startTime: EventController.eventStartTimeController.text,
//         endTime: EventController.eventEndTimeController.text,
//         venue: EventController.venueController.text,
//         keywords: EventController.keywordController.text,
//         description: EventController.descriptionController.text,
//         minumumAgeRequirements: EventController.minimumAgeRequired.text,
//         termConditions: EventController.eventTermAndCondition.text,
//         vendorData: BusinessProfileData.vendorId()??"",
//         faqDetails: "sdfsdfsd",
//         seatingArrangement: "sdfsdfsd",
//         kidsFriendly:'kids',
//         petsFriendly: "pet freindly",
//         layout: EventController.venueLayout.text,
//         bannerImg: EventController.eventBannerPhoto.text,
//         galaryImagePath1: EventController.venueGalleryPhoto1.text,
//         galaryImagePath2: EventController.venueGalleryPhoto2.text,
//         galaryImagePath3: EventController.venueGalleryPhoto3.text,
//         location: jsonEncode({
//           "address":businessData?.address,
//           "state":businessData?.state,
//           "city":businessData?.city,
//           "pinCode":businessData?.pinCode
//         }..removeWhere((key,value)=>value==null)),
//
//         artists: jsonEncode(EventController.artistDataList),
//
//         ticketModelInString:jsonEncode(EventController.listTickets),
//         event_category_data: "${EventController.categoryListInt}".replaceAll("[", "").replaceAll("]", ""),
//         tables:jsonEncode(EventController.listEventTable)
//
//     );
//
//     MyHiveBox.instance.getBox().put(
//         AppStr.saveEventData, jsonEncode(eventPostModel.toJson()));
//   }
//
//   loadEventFromHive() {
//     if (MyHiveBox.instance.getBox().get(
//         AppStr.saveEventData) != null) {
//       log("data loged ${ MyHiveBox.instance.getBox().get(
//           AppStr.saveEventData)}");
//       try {
//         EventPostModel model = EventPostModel.fromJson(
//             jsonDecode(MyHiveBox.instance.getBox().get(
//                 AppStr.saveEventData, defaultValue: "{}")));
//         EventController.eventNameController.text = model.eventName ?? '';
//         EventController.eventDateController.text = model.eventDate ?? '';
//         EventController.eventStartTimeController.text = model.startTime ?? '';
//         EventController.eventEndTimeController.text = model.endTime ?? '';
//         EventController.venueController.text = model.venue ?? '';
//         EventController.keywordController.text = model.keywords?? '';
//         EventController.descriptionController.text = model.description ?? '';
//         EventController.minimumAgeRequired.text = model.minumumAgeRequirements ?? '';
//         EventController.eventTermAndCondition.text = model.termConditions ?? '';
//         EventController.venueLayout.text=model.layout??"";
//         EventController.eventBannerPhoto.text=model.bannerImg??"";
//         EventController.venueGalleryPhoto1.text=model.galaryImagePath1??"";
//         EventController.venueGalleryPhoto2.text=model.galaryImagePath2??"";
//         EventController.venueGalleryPhoto3.text=model.galaryImagePath3??"";
//         EventController.parkingTypeCotroller.text=model.parkingType??"";
//         //load  data artist,table and
//         List<dynamic> data=jsonDecode(model.ticketModelInString??"[]");
//         List<TicketModel> listTicketModel=data.map((item)=>TicketModel.fromJson(item)).toList();
//         EventController.listTickets=listTicketModel;
// //load artist
//         List<dynamic> artistData=jsonDecode(model.artists??"[]");
//         List<ArtistsModel> artistModelList=artistData.map((item)=>ArtistsModel.fromJson(item)).toList();
//         EventController.artistDataList=artistModelList;
//
// //load table
//         List<dynamic> tableData=jsonDecode(model.tables??"[]");
//         List<EventTableModel> eventTableList=tableData.map((item)=>EventTableModel.fromJson(item)).toList();
//         EventController.listEventTable=eventTableList;
//
//         print("amra009----$listTicketModel");
//
//
//       }catch(exception){
//         log("\n\namra007 ${exception} \n\n\n\n");
//       }
//     }else{
//
//
//       EventController.eventNameController.clear();
//       EventController.eventDateController.clear();
//       EventController.eventStartTimeController.clear();
//       EventController.eventEndTimeController.clear();
//       EventController.venueController.clear();
//       EventController.keywordController.clear();
//       EventController.descriptionController.clear();
//       EventController.minimumAgeRequired.clear();
//       EventController.eventTermAndCondition.clear();
//       EventController.venueLayout.clear();
//       EventController.eventBannerPhoto.clear();
//       EventController.venueGalleryPhoto1.clear();
//       EventController.venueGalleryPhoto2.clear();
//       EventController.venueGalleryPhoto3.clear();
//       EventController.parkingTypeCotroller.clear();
//       EventController.listTickets=[];
//       EventController.artistDataList=[];
//       EventController.listEventTable=[];
//
//
//     }
//
//
//   }
// }







import 'dart:convert';
import 'dart:developer';
import 'package:new_pubup_partner/data/source/local/hive_box.dart';
import 'package:new_pubup_partner/features/admin_details/model/business_resister_model.dart';
import 'package:new_pubup_partner/features/event/event_controller/event_controller.dart';
import 'package:new_pubup_partner/features/event/fragments/event_add_artists.dart';
import 'package:new_pubup_partner/features/event/model/EventPostModel.dart';
import '../../config/string.dart';
import '../../data/source/local/global_data/profile_data.dart';


class LoadSaveEvent {
  LoadSaveEvent._private();
  static final LoadSaveEvent instance = LoadSaveEvent._private();
  factory LoadSaveEvent() => instance;

  void saveEventToHive() {
    BusinessData? businessData = BusinessProfileData.getBusinessRegistrationData()?.businessData;

    EventPostModel eventPostModel = EventPostModel(
      parkingType: EventController.parkingTypeCotroller.text,
      eventName: EventController.eventNameController.text,
      eventDate: EventController.eventDateController.text,
      startTime: EventController.eventStartTimeController.text,
      endTime: EventController.eventEndTimeController.text,
      venue: EventController.venueController.text,
      keywords: EventController.keywordController.text,
      description: EventController.descriptionController.text,
      minumumAgeRequirements: EventController.minimumAgeRequired.text,
      foodType: EventController.foodTypeController.text,
      termConditions: EventController.eventTermAndCondition.text,
      vendorData: BusinessProfileData.vendorId() ?? "",
      faqDetails: "temp", // will be replaced on submit
      seatingArrangement: "temp",
      kidsFriendly: 'kids',
      petsFriendly: "pet friendly",
      layout: EventController.venueLayout.text,
      venueLayoutPhoto: EventController.venueLayoutPhoto.text,
      bannerImg: EventController.eventBannerPhoto.text,
      galaryImagePath1: EventController.venueGalleryPhoto1.text,
      galaryImagePath2: EventController.venueGalleryPhoto2.text,
      galaryImagePath3: EventController.venueGalleryPhoto3.text,
      location: jsonEncode({
        "address": businessData?.address,
        "state": businessData?.state,
        "city": businessData?.city,
        "pinCode": businessData?.pinCode,
        "latitude": businessData?.latitude,
        "longitude": businessData?.longitude,
      }..removeWhere((key, value) => value == null)),


      // NEW: Save only selected artist IDs
      artistsDatas: EventAddArtists.getSelectedArtistIds(),

      ticketModelInString: jsonEncode(EventController.listTickets),
      event_category_data: EventController.categoryListInt.isEmpty
          ? ""
          : EventController.categoryListInt.join(","),
      tables: jsonEncode(EventController.listEventTable),
    );

    MyHiveBox.instance.getBox().put(AppStr.saveEventData, jsonEncode(eventPostModel.toJson()));
  }

  void loadEventFromHive() {
    final savedData = MyHiveBox.instance.getBox().get(AppStr.saveEventData);
    if (savedData == null) {
      _clearAllFields();
      return;
    }

    try {
      final Map<String, dynamic> json = jsonDecode(savedData);
      EventPostModel model = EventPostModel.fromJson(json);

      // Restore text fields
      EventController.eventNameController.text = model.eventName ?? '';
      EventController.eventDateController.text = model.eventDate ?? '';
      EventController.eventStartTimeController.text = model.startTime ?? '';
      EventController.eventEndTimeController.text = model.endTime ?? '';
      EventController.venueController.text = model.venue ?? '';
      EventController.keywordController.text = model.keywords ?? '';
      EventController.descriptionController.text = model.description ?? '';
      EventController.minimumAgeRequired.text = model.minumumAgeRequirements ?? '';
      EventController.foodTypeController.text = model.foodType?? '';
      EventController.eventTermAndCondition.text = model.termConditions ?? '';
      EventController.venueLayout.text = model.layout ?? "";
      EventController.venueLayoutPhoto.text = model.venueLayoutPhoto ?? "";
      EventController.eventBannerPhoto.text = model.bannerImg ?? "";
      EventController.venueGalleryPhoto1.text = model.galaryImagePath1 ?? "";
      EventController.venueGalleryPhoto2.text = model.galaryImagePath2 ?? "";
      EventController.venueGalleryPhoto3.text = model.galaryImagePath3 ?? "";
      EventController.parkingTypeCotroller.text = model.parkingType ?? "";

      // Restore tickets
      List<dynamic> ticketJson = jsonDecode(model.ticketModelInString ?? "[]");
      EventController.listTickets = ticketJson.map((e) => TicketModel.fromJson(e)).toList();

      // Restore tables
      List<dynamic> tableJson = jsonDecode(model.tables ?? "[]");
      EventController.listEventTable = tableJson.map((e) => EventTableModel.fromJson(e)).toList();

      // Restore selected artist IDs
      final ids = model.artistsDatas ?? [];
      EventAddArtists.restoreSelectedArtistIds(ids);

      log("Loaded ${ids.length} artist IDs from draft: $ids");

      // Clear old artist list (we don't need full objects anymore)
      EventController.artistDataList.clear();

    } catch (e) {
      log("Error loading event from Hive: $e");
      _clearAllFields();
    }
  }

  void _clearAllFields() {
    EventController.eventNameController.clear();
    EventController.eventDateController.clear();
    EventController.eventStartTimeController.clear();
    EventController.eventEndTimeController.clear();
    EventController.venueController.clear();
    EventController.keywordController.clear();
    EventController.descriptionController.clear();
    EventController.minimumAgeRequired.clear();
    EventController.foodTypeController.clear();
    EventController.eventTermAndCondition.clear();
    EventController.venueLayout.clear();
    EventController.eventBannerPhoto.clear();
    EventController.venueGalleryPhoto1.clear();
    EventController.venueGalleryPhoto2.clear();
    EventController.venueGalleryPhoto3.clear();
    EventController.parkingTypeCotroller.clear();
    EventController.listTickets.clear();
    EventController.listEventTable.clear();
    EventController.artistDataList.clear();
    EventAddArtists.clearSelectedArtistIds();
  }
}