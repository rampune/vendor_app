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
part 'utils/event_utils.dart';
class EventBooking extends StatefulWidget {
  const EventBooking({super.key});
  @override
  State<EventBooking> createState() => _EventBookingState();
}
class _EventBookingState extends State<EventBooking> {
  EventPostBloc eventPostBloc=EventPostBloc();
  int screen = 0;
  @override
  void initState() {
  LoadSaveEvent.instance.loadEventFromHive();
    super.initState();
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
                      EventController.buttonTextNotifier.value = "Submit";
                      return;
                    } else {
                      EventController.buttonTextNotifier.value = "Save &  Next";
                    }
                  },
                  listScreens: [
                    EventBookingScreen1(),
                    EventBookingScreen2(),
                    EventAddTable(),
                    EventBook3(),
                    EventFaq(),
                    EventAddArtists(),
                    EventTC()
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
                            showSuccessAlert(context: context, title: "Your event has been successfully scheduled! You can view or edit it from your dashboard.",
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
                                "Submit") {
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
eventPostBloc.add(
    EventUploadPostEvent(
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
