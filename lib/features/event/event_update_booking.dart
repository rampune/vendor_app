import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/config.dart';
import 'package:new_pubup_partner/config/navigation_util.dart';
import 'package:new_pubup_partner/config/string.dart';
import 'package:new_pubup_partner/data/source/local/hive_box.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/event/event_booking.dart';
import 'package:new_pubup_partner/features/event/load_save_event.dart';
import 'package:new_pubup_partner/features/event/model/event_faq_model.dart';
import 'package:new_pubup_partner/utils/save_and_retrive_file.dart';
import '../../config/common_functions.dart';
import '../../config/theme.dart';
import '../common_widgets/custom_button.dart';
import '../common_widgets/custom_view_pager.dart';
import 'bloc/event_post_bloc.dart';
import 'event_controller/event_controller.dart';
import 'fragments/event_add_artists.dart';
import 'fragments/event_add_table.dart';
import 'fragments/event_book1.dart';
import 'fragments/event_book3.dart';
import 'fragments/event_book_2.dart';
import 'fragments/event_faq.dart';
import 'fragments/event_t_c.dart';
import 'model/EventPostModel.dart';

class EventUpdateBooking extends StatefulWidget {
  final EventPostModel existingEvent;
  const EventUpdateBooking({super.key, required this.existingEvent});
  @override
  State<EventUpdateBooking> createState() => _EventUpdateBookingState();
}
class _EventUpdateBookingState extends State<EventUpdateBooking> {
  EventPostBloc eventPostBloc=EventPostBloc();
  int screen = 0;
  @override
  void initState() {
    LoadSaveEvent.instance.loadEventFromHive();
    _populateExistingData();
    super.initState();
  }

  void _populateExistingData() {
    final model = widget.existingEvent;
    // Populate controllers and lists from existing model
    EventController.eventNameController.text = model.eventName ?? '';
    EventController.eventDateController.text = model.eventDate ?? '';
    EventController.eventStartTimeController.text = model.startTime ?? '';
    EventController.eventEndTimeController.text = model.endTime ?? '';
    EventController.descriptionController.text = model.description ?? '';
    EventController.eventTermAndCondition.text = model.termConditions ?? '';

    // Categories (assume parsed from model.categoryIds or similar; adjust as needed)
    // EventController.categoryListInt = model.categoryIds ?? [];

    // Tickets
    EventController.listTickets = ticketStringToModel(model.ticketModelInString) ?? [];

    // Tables
    // Parse from model.tables JSON string if available
    // EventController.listEventTable = parseTables(model.tables ?? '[]');

    // Artists
    // Parse from model.artists JSON string
    // EventController.artistDataList = parseArtists(model.artists ?? '[]');

    // FAQs and toggles
    // Populate EventFaqModel from model.faqDetails
    if (model.faqDetails != null) {
      final faqJson = jsonDecode(model.faqDetails!);
      EventFaqModel.loadFromJson(faqJson); // Assume you add this method to EventFaqModel
    }

    // Other fields like min age, venue layout, etc.
    EventController.minimumAgeRequired.text = model.minumumAgeRequirements ?? '';
    EventController.venueLayout.text = model.layout ?? '';
    // Photos: Set to existing URLs or keep default for new uploads
    EventController.eventBannerPhoto.text = model.bannerImg ?? AppStr.filePickerDefaultText;
    // Similarly for other photos

    // Location/Venue
    // Parse model.location JSON and populate venue fields if needed
  }

  List<TicketModel>? ticketStringToModel(String? rawString) {
    List<TicketModel>? listTicketModel;
    try {
      print("$rawString");

      List<dynamic> listDynamic = jsonDecode(rawString ?? '');
      listTicketModel = listDynamic
          .map((item) => TicketModel.fromJson(item))
          .toList();
      return listTicketModel;
    } catch (exception) {
      print("--$exception");
      return null;
    }
  }

  List<ArtistsModel>? parseArtists(String? rawString) {
    if (rawString == null || rawString.isEmpty) return [];
    try {
      List<dynamic> listDynamic = jsonDecode(rawString);
      return listDynamic.map((item) => ArtistsModel.fromJson(item)).toList();
    } catch (e) {
      print("Error parsing artists: $e");
      return [];
    }
  }

  List<EventTableModel>? parseTables(String? rawString) {
    if (rawString == null || rawString.isEmpty) return [];
    try {
      List<dynamic> listDynamic = jsonDecode(rawString);
      return listDynamic.map((item) => EventTableModel.fromJson(item)).toList();
    } catch (e) {
      print("Error parsing tables: $e");
      return [];
    }
  }

  List<int> parseCategories(String? rawString) {
    if (rawString == null || rawString.isEmpty) return [];
    try {
      List<dynamic> listDynamic = jsonDecode(rawString);
      return listDynamic.cast<int>();
    } catch (e) {
      print("Error parsing categories: $e");
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                    onTap: () {
                      askConfirmation(context, "Are you sure exit to Dashboard?",
                          confirmCallBack: () {
                            Navigator.pop(context);
                          });
                    },
                    child: Icon(Icons.close_sharp,
                      color: AppColors.redLight,)),
              ),

              Expanded(
                child: CustomViewPager
                  (
                    callBack: (int index) {
                      screen = index;
                      if (screen == 6) {
                        EventController.buttonTextNotifier.value = "Update";
                        return;
                      } else {
                        EventController.buttonTextNotifier.value = "Save &  Next";
                      }
                    },
                    listScreens: [
                      // EventBookingScreen1(isUpdate: true),
                      // EventBookingScreen2(isUpdate: true),
                      // EventAddTable(isUpdate: true),
                      // EventBook3(isUpdate: true),
                      // EventFaq(isUpdate: true),
                      // EventAddArtists(isUpdate: true),
                      // EventTC(isUpdate: true)
                    ],
                    controller: EventController.eventPageController),
              ),
              ValueListenableBuilder(
                  valueListenable: EventController.buttonTextNotifier,
                  builder: (context, btnText, child) {
                    return Column(
                      children: [
                        BlocListener<EventPostBloc,EventPostState>
                          (
                          bloc: eventPostBloc,
                          listener: (BuildContext context,
                              EventPostState state){
                            state is EventPostLoadingState?OverlayLoadingProgress.start(context):
                            OverlayLoadingProgress.stop();
                            if(state is EventPostSuccessState){
                              MyHiveBox.instance.getBox().delete(AppStr.saveEventData);
                              showSuccessAlert(context: context, title: "Your event has been successfully updated! You can view or edit it from your dashboard.",
                                  callBack: (){
                                    context.pop();
                                    context.pop();
                                  });
                            }else if(state is EventPostErrorState){
                              showAlert(context, state.errorMsg);
                            }
                          },child: SizedBox.shrink(),),
                        CustomButton(
                            buttonColor: dynamicThemeColor(context),
                            buttonText:
                            btnText,
                            onPress: () async{
                              hideKeyboard();
                              LoadSaveEvent.instance.saveEventToHive();
                              if (EventController.buttonTextNotifier.value ==
                                  "Update") {
                                if (!(EventController.booking1FromKey.currentState
                                    ?.validate() ?? false)) {
                                  screen = 0;
                                  moveTo(screen);
                                  return;
                                } else if (!(EventController.booking3FromKey
                                    .currentState?.validate() ?? false)) {
                                  screen = 3;
                                  moveTo(screen);
                                  return;
                                } else if (!(EventController.bookingFaqFormKey
                                    .currentState?.validate() ?? false)) {
                                  screen = 4;
                                  moveTo(screen);
                                  return;
                                }
                                else{
                                  if (!(EventController.booingTcFormKey
                                      .currentState?.validate() ?? false)) {
                                    screen = 6;
                                    moveTo(screen);
                                    return;
                                  }
                                  if (MyHiveBox.instance.getBox().get(
                                      AppStr.saveEventData) != null) {
                                    log("data loged55 ${ MyHiveBox.instance.getBox().get(
                                        AppStr.saveEventData)}");
                                    try {
                                      EventPostModel model = EventPostModel.fromJson(
                                          jsonDecode(MyHiveBox.instance.getBox().get(
                                              AppStr.saveEventData, defaultValue: "{}")));
                                      try {
                                        List<dynamic> listTicket=jsonDecode(model.ticketModelInString??'[]');
                                        if(listTicket.isEmpty){
                                          moveTo(1);
                                          showToast("Add At least One Ticket");
                                          return ;
                                        }
                                        List<dynamic> listArtist=jsonDecode(model.artists??'[]');
                                        if(listArtist.isEmpty){
                                          moveTo(5);
                                          showToast("Add At least One Artist");

                                          return ;
                                        }
                                        model.faqDetails = jsonEncode(EventFaqModel.loadFaq());

                                      }catch(exception){
                                        print("exception   $exception");
                                      }
// Dispatch update event with existing ID
                                      eventPostBloc.add(
                                          EventUpdatePostEvent(
                                              eventId: widget.existingEvent.id!,
                                              categoryList: EventController.categoryListInt,
                                              listImageUploadModel:
                                              await  eventImageList(model: model)
                                              ,eventPostModel: model));

                                    }catch(exception){
                                      print("somthing wrong in ev");
                                    }


                                  }

                                }
                              }

                              screen++;
                              moveTo(screen);
                            }),
                      ],
                    );
                  }
              ),
            ],
          ),
        ),
      )
      ,);
  }
  moveTo(int index) {
    screen=index;
    EventController.eventPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }


}