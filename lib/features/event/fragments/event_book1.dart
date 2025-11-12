import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/features/admin_details/widget/custom_drop_down/custom_drop_down.dart';
import 'package:new_pubup_partner/features/admin_details/widget/custom_drop_down/multi_select_drop_down.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/slot_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
import 'package:new_pubup_partner/features/event/bloc/event_category_bloc.dart';
import '../../../config/string.dart';
import '../../../config/theme.dart';
import '../../../utils/pickers/pickers.dart';
import '../../common_widgets/custom_file_picker_container.dart';
import '../../common_widgets/custom_text_field.dart';
import '../event_controller/event_controller.dart';
class EventBookingScreen1 extends StatefulWidget {
  const EventBookingScreen1({super.key});
  @override
  State<EventBookingScreen1> createState() => _EventBookingScreen1State();
}
class _EventBookingScreen1State extends State<EventBookingScreen1>
    with AutomaticKeepAliveClientMixin {
  EventCategoryBloc eventCategoryBloc = EventCategoryBloc();
  @override
  void initState() {
    eventCategoryBloc.add(EventCategoryGetEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SingleChildScrollView(
        child: Form(
          key: EventController.booking1FromKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Turn vibes Into Bookings",
                style: context.titleLarge(),),
              10.height(),
              Text(
                "Get Discovered by the right crowd .Post your event in minutes.",
                style: context.titleSmall(),),
              10.height(),
              CustomTextField(
                textController: EventController.eventNameController,
                title: "Event Name",
                validator: (String? data) {
                  if (data?.isEmpty ?? true) {
                    return "Enter valid value";
                  }
                },
              ),
              10.height(),
              CustomTextField(
                focusColor: AppColors.darkGray,
                readOnly: true,
                textController: EventController.eventDateController,
                title: "Event Date",
                validator: (String? data) {
                  if (data?.isEmpty ?? true) {
                    return "Enter valid value";
                  }
                },
                onTap: () async {
                  EventController.eventDateController.text =
                  await AppPickers.datePicker(
                      context, startDate: DateTime.now());
                },
                suffix: Icon(Icons.calendar_month_outlined,
                  color: AppColors.darkGray,),
              ),
              10.height(),
              SlotWidget(title: "",
                startTimeController: EventController.eventStartTimeController,
                endTimeController: EventController.eventEndTimeController,
                timeGapInMinute: 10,
              validator: (String ?data){
                print("data $data");
                if(data?.isEmpty??true){
                  return "select valid time";
                }
              },),
10.height(),
              BlocBuilder<EventCategoryBloc,
                  EventCategoryState>(
                bloc: eventCategoryBloc,
                builder: (context, state) {
                  if(state is EventCategoryLoadingState){
                   return CustomLoadingWidget();
                  } else if (state is EventCategorySuccessState) {
                    return MultiSelectDropDown(

                      placeHolder: "select category",
                      title: "Event Category",

                      validator: (String? data){
                        if(data?.isEmpty??true){
                          return "Select category";
                        }
                      },
                      heading: "Select Event Category",
                        controller: EventController.eventCategoryController,
                        listCustomDropDownModel:
                        state.eventCategoryModel.data?.map((item)=>
                            CustomDropDownModel(name: item.name??''
                            ,id: item.id??0,
                              imgUrl: item.image??''
                            ),
                        ).toList()??[],
                        onSelect: (List<CustomDropDownModel> list){
                        EventController.categoryListInt=list.map((item)=>item.id??0).toList()??[];
                        EventController.eventCategoryController.text="${list.map((item)=>item.name??"").toList()}";
                        print("${list}");
                        });
                  }else if(state is EventCategoryErrorState){
                   return CustomErrorWidget(
                     msg: state.errorMsg,
                     retryCallBack: (){
                     eventCategoryBloc.add(EventCategoryGetEvent());
                   },);
                  }
                  return Text("$state");
                },
              ),

              10.height(),
              CustomFilePickerContainer(title: "Event Banner",
                controller: EventController.eventBannerPhoto,
                validator: (String ? data){
                  if(data==AppStr.filePickerDefaultText){
                    return "please select minimum age";
                  }
                },
              ),
              10.height(),
              CustomTextField(textController:
              EventController.descriptionController,
                title: "Description",
                length: 300,
                validator: (String? data) {
                  if (data?.isEmpty ?? true) {
                    return "Enter valid value";
                  }
                },
                maxLines: 8,
                minLines: 5,
              ),

            ],),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}








