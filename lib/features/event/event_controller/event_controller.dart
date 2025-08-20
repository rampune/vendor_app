import 'package:flutter/cupertino.dart';


import '../model/EventPostModel.dart';
import '../model/event_table_model.dart' hide EventTableModel;
import '../model/ticket_model.dart';

class EventController{
static List<ArtistsModel> artistDataList=[];
static List<TicketModel> listTickets=[];
static List<EventTableModel> listEventTable=[];

  static GlobalKey<FormState> booking1FromKey=GlobalKey<FormState>();
  static GlobalKey<FormState> booking2FormKey=GlobalKey<FormState>();
  static GlobalKey<FormState> booking3FromKey=GlobalKey<FormState>();
  static GlobalKey<FormState> bookingFaqFormKey=GlobalKey<FormState>();
  static GlobalKey<FormState> booingTcFormKey=GlobalKey<FormState>();
  static GlobalKey<FormState> bookingAddArtistFormKey=GlobalKey<FormState>();
static GlobalKey<FormState> addTableFormKey=GlobalKey<FormState>();


 static TextEditingController numbTableController=TextEditingController();
static TextEditingController sittingTableController=TextEditingController();
static TextEditingController priceTableController=TextEditingController();
static TextEditingController coverChargeTableController=TextEditingController();


static TextEditingController eventNameController=TextEditingController();
  static TextEditingController eventDateController=TextEditingController();
  static TextEditingController eventStartTimeController=TextEditingController();
  static TextEditingController eventEndTimeController=TextEditingController();
  static TextEditingController venueController=TextEditingController();
  static TextEditingController keywordController=TextEditingController();
  static TextEditingController descriptionController=TextEditingController();
  static TextEditingController ticketType=TextEditingController();
  static TextEditingController ticketDescription=TextEditingController();
  static TextEditingController ticketPrice=TextEditingController();
  static TextEditingController minimumAgeRequired=TextEditingController();
  static TextEditingController venueLayout=TextEditingController();
static TextEditingController parkingTypeCotroller=TextEditingController();
  static TextEditingController eventBannerPhoto=TextEditingController();
static TextEditingController venueLayoutPhoto=TextEditingController();
static TextEditingController venueGalleryPhoto1=TextEditingController();
static TextEditingController venueGalleryPhoto2=TextEditingController();
static TextEditingController venueGalleryPhoto3=TextEditingController();
  static TextEditingController artistNameController=TextEditingController();
  static TextEditingController artistCategoryController=TextEditingController();
  static TextEditingController artistAboutController=TextEditingController();
  static TextEditingController artistPhotoController=TextEditingController();
  static TextEditingController ticketCoverCharges=TextEditingController();
static TextEditingController eventTermAndCondition=TextEditingController();
static TextEditingController eventCategoryController=TextEditingController();
static List<int> categoryListInt=[];
  static   PageController eventPageController=PageController();

  static ValueNotifier<String> buttonTextNotifier=ValueNotifier("Save & Next");

}