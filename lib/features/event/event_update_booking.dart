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
    // LoadSaveEvent.instance.loadEventFromHive(); // Avoid overwriting if we have existing data
    _populateExistingData();
    super.initState();
  }

  void _populateExistingData() {
    final model = widget.existingEvent;
    
    // Clear static data first
    _clearEventController();

    // Basic Info
    EventController.eventNameController.text = model.eventName ?? '';
    EventController.eventDateController.text = model.eventDate ?? '';
    EventController.eventStartTimeController.text = model.startTime ?? '';
    EventController.eventEndTimeController.text = model.endTime ?? '';
    EventController.descriptionController.text = model.description ?? '';
    EventController.eventTermAndCondition.text = model.termConditions ?? '';
    EventController.venueController.text = model.venue ?? '';
    EventController.keywordController.text = model.keywords ?? '';

    // Categories
    EventController.categoryListInt = model.getCategoryIds();
    EventController.eventCategoryController.text = model.getCategoryNames();

    // Tickets
    EventController.listTickets = ticketStringToModel(model.ticketModelInString) ?? [];

    // Tables
    if (model.tables != null) {
      EventController.listEventTable = parseTables(model.tables) ?? [];
    }

    // Artists
    if (model.artistsDatas != null) {
      EventAddArtists.restoreSelectedArtistIds(model.artistsDatas!);
    }

    // FAQs
    if (model.faqDetails != null) {
      try {
        final faqJson = jsonDecode(model.faqDetails!);
        EventFaqModel.loadFromJson(faqJson);
      } catch (_) {}
    }

    // Photos
    EventController.eventBannerPhoto.text = (model.bannerImg?.isNotEmpty ?? false) ? model.bannerImg! : AppStr.filePickerDefaultText;
    EventController.venueLayout.text = model.layout ?? '';
    EventController.venueLayoutPhoto.text = (model.venueLayoutPhoto?.isNotEmpty ?? false) ? model.venueLayoutPhoto! : AppStr.filePickerDefaultText;
    EventController.venueGalleryPhoto1.text = (model.galaryImagePath1?.isNotEmpty ?? false) ? model.galaryImagePath1! : AppStr.filePickerDefaultText;
    EventController.venueGalleryPhoto2.text = (model.galaryImagePath2?.isNotEmpty ?? false) ? model.galaryImagePath2! : AppStr.filePickerDefaultText;
    EventController.venueGalleryPhoto3.text = (model.galaryImagePath3?.isNotEmpty ?? false) ? model.galaryImagePath3! : AppStr.filePickerDefaultText;

    // Additional Details
    EventController.minimumAgeRequired.text = model.minumumAgeRequirements ?? '';
    EventController.foodTypeController.text = model.foodType ?? '';
    EventController.parkingTypeCotroller.text = model.parkingType ?? '';
  }

  void _clearEventController() {
    EventController.eventNameController.clear();
    EventController.eventDateController.clear();
    EventController.eventStartTimeController.clear();
    EventController.eventEndTimeController.clear();
    EventController.descriptionController.clear();
    EventController.eventTermAndCondition.clear();
    EventController.venueController.clear();
    EventController.keywordController.clear();
    EventController.minimumAgeRequired.clear();
    EventController.foodTypeController.clear();
    EventController.parkingTypeCotroller.clear();
    EventController.eventBannerPhoto.text = AppStr.filePickerDefaultText;
    EventController.venueLayoutPhoto.text = AppStr.filePickerDefaultText;
    EventController.venueGalleryPhoto1.text = AppStr.filePickerDefaultText;
    EventController.venueGalleryPhoto2.text = AppStr.filePickerDefaultText;
    EventController.venueGalleryPhoto3.text = AppStr.filePickerDefaultText;
    EventController.listTickets = [];
    EventController.listEventTable = [];
    EventController.categoryListInt = [];
    EventController.eventCategoryController.clear();
    EventAddArtists.clearSelectedArtistIds();
    EventFaqModel.clear(); 
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(Icons.close_sharp, color: AppColors.redLight),
                  onPressed: () {
                    askConfirmation(context, "Are you sure exit to Dashboard?", confirmCallBack: () {
                      Navigator.pop(context);
                    });
                  },
                ),
              ),
              Expanded(
                child: CustomViewPager(
                  callBack: (int index) {
                    setState(() {
                      screen = index;
                    });
                    if (screen == 6) {
                      EventController.buttonTextNotifier.value = "Update";
                    } else {
                      EventController.buttonTextNotifier.value = "Save & Next";
                    }
                  },
                  listScreens: const [
                    EventBookingScreen1(),
                    EventBookingScreen2(),
                    EventAddTable(),
                    EventBook3(),
                    EventFaq(),
                    EventAddArtists(),
                    EventTC(),
                  ],
                  controller: EventController.eventPageController,
                ),
              ),
              ValueListenableBuilder(
                valueListenable: EventController.buttonTextNotifier,
                builder: (context, btnText, child) {
                  if (screen == 1 || screen == 2 || screen == 5) {
                    return const SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      BlocListener<EventPostBloc, EventPostState>(
                        bloc: eventPostBloc,
                        listener: (BuildContext context, EventPostState state) {
                          if (state is EventPostLoadingState) {
                            OverlayLoadingProgress.start(context);
                          } else {
                            OverlayLoadingProgress.stop();
                          }
                          if (state is EventPostSuccessState) {
                            MyHiveBox.instance.getBox().delete(AppStr.saveEventData);
                            showSuccessAlert(
                              context: context,
                              title: "Your event has been successfully updated!",
                              callBack: () {
                                Navigator.pop(context); // Close Update screen
                                Navigator.pop(context); // Go back to List
                              },
                            );
                          } else if (state is EventPostErrorState) {
                            showAlert(context, state.errorMsg);
                          }
                        },
                        child: const SizedBox.shrink(),
                      ),
                      CustomButton(
                        buttonColor: dynamicThemeColor(context),
                        buttonText: btnText,
                        onPress: () async {
                          hideKeyboard();
                          if (EventController.buttonTextNotifier.value == "Update") {
                            // Validate all forms before update
                            if (!_validateAll()) return;

                            LoadSaveEvent.instance.saveEventToHive();
                            final data = MyHiveBox.instance.getBox().get(AppStr.saveEventData);
                            if (data != null) {
                              try {
                                final model = EventPostModel.fromJson(jsonDecode(data));
                                model.faqDetails = jsonEncode(EventFaqModel.loadFaq());
                                model.artistsDatas = EventAddArtists.getSelectedArtistIds();
                                
                                eventPostBloc.add(
                                  EventUpdatePostEvent(
                                    eventId: widget.existingEvent.id!,
                                    categoryList: EventController.categoryListInt,
                                    listImageUploadModel: await eventImageList(model: model),
                                    eventPostModel: model,
                                  ),
                                );
                              } catch (e) {
                                showToast("Error preparing update data");
                              }
                            }
                            return;
                          }
                          
                          // Move to next page
                          screen++;
                          moveTo(screen);
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _validateAll() {
    if (!(EventController.booking1FromKey.currentState?.validate() ?? false)) {
      moveTo(0);
      return false;
    }
    // if (EventController.listTickets.isEmpty) {
    //   moveTo(1);
    //   showToast("Add at least one ticket");
    //   return false;
    // }
    if (!(EventController.booking3FromKey.currentState?.validate() ?? false)) {
      moveTo(3);
      return false;
    }
    if (!(EventController.bookingFaqFormKey.currentState?.validate() ?? false)) {
      moveTo(4);
      return false;
    }
    if (!(EventController.booingTcFormKey.currentState?.validate() ?? false)) {
      moveTo(6);
      return false;
    }
    return true;
  }

  moveTo(int index) {
    setState(() {
      screen = index;
    });
    EventController.eventPageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 1000),
      curve: Curves.easeInOut,
    );
  }


}