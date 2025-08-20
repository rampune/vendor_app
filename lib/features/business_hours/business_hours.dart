import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/features/business_hours/bloc/business_hour_bloc.dart';
import 'package:new_pubup_partner/features/business_hours/model/business_hour_model.dart';
import 'package:new_pubup_partner/features/business_hours/model/day_model.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/working_hour_tile.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/working_hours_bottom_sheet_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_file_picker_container.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';

import '../../data/source/local/global_data/profile_data.dart';
import 'business_hours_controller.dart';
import 'model/slot_model.dart';
class BusinessHours extends StatefulWidget {
  const BusinessHours({super.key});
  @override
  State<BusinessHours> createState() => _BusinessHoursState();
}
class _BusinessHoursState extends State<BusinessHours> {
  BusinessHourBloc businessHourBloc=BusinessHourBloc();
@override
  void initState() {
  businessHourBloc.add(BusinessHourGetEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      title: Text("Business Hours"),
    centerTitle: false,
    ),
    body: BlocBuilder<BusinessHourBloc,BusinessHourState>(
        bloc: businessHourBloc,
        builder:
            (BuildContext context,BusinessHourState state){
if(state is BusinessHourLoadingState){
  return CustomLoadingWidget();
}else if(state is BusinessHourErrorState){
            return CustomErrorWidget(retryCallBack: (){
              businessHourBloc.add(BusinessHourGetEvent());
            },);
          }else if(state is BusinessUserNotExistsState){
            return Center(child:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: CustomButton(buttonText: "Add Business Hours", onPress: (){
                BusinessHourData hourModel=       BusinessHourData(
                    vendorData: BusinessProfileData.vendorId()??"",
                    operationalTime: ["Sunday","Monday","Tuesday",
                      "Wednesday", "Thursday","Friday", "Saturday"].map((item)=>
                        OperationalTime(
                          day: item,)
                    ).toList()
                );
                businessHourBloc.add(
                    BusinessHourPostEvent(businessHourData: hourModel )
                );
              }),
            )

            );

          }else if(state is BusinessUserExistsState){
            return businessHourMainView(state: state);
          }

          return SizedBox.shrink();
        }),


    );
  }
  Widget businessHourMainView({required BusinessHourState state}){

  if(state is BusinessUserExistsState) {
    List<OperationalTime> listOperationTime =state.listOprTime;
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: ListView.separated(itemBuilder: (BuildContext context,int index){
        return  WorkingHourTile(
          subTitle: listOperationTime[index].day??'',
          day: listOperationTime[index].day??'',
          isOn: listOperationTime[index].isopen??false,
          leadingCallBack: (){

            // showAlert(context, ""
            //     "${listOperationTime[index].slot?.map((item)=>"${item.startTime} - ${item.endTime}\n\n").join()}"
            //     "");
          },
          onTap: (){
            showModalBottomSheet(
              backgroundColor: AppColors.transparent,
              context: context,

              builder: (_) {
                return BottomSheetWidget(businessHourBloc: businessHourBloc,
                  day:listOperationTime[index].day ??'',
                  isOpen:listOperationTime[index].isopen??false,
                  isPostRequest: state is BusinessUserNotExistsState,

                );
              },
            );
          },);
      },

          separatorBuilder: (BuildContext context,int index){
            return SizedBox(height: 10,);
          },
          itemCount:listOperationTime.length),

    );

  }
  return Text("${state}");



  }

}


/*

 */