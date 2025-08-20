import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:new_pubup_partner/config/common_functions.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/data/source/local/global_data/profile_data.dart';
import 'package:new_pubup_partner/features/business_hours/model/business_hour_model.dart';
import 'package:new_pubup_partner/features/business_hours/utils.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/bottom_sheet_button.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/custom_check_box.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/custom_slot_card.dart';
import 'package:new_pubup_partner/features/business_hours/widgets/slot_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_button.dart';
import '../../../config/theme.dart';
import '../bloc/business_hour_bloc.dart';
class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key,required this.businessHourBloc,
  required this.day,this.isOpen,this.isPostRequest=false});
final BusinessHourBloc businessHourBloc;
final String day;

final bool isPostRequest;

final bool ? isOpen;


  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  BusinessHourBloc businessHourBloc=BusinessHourBloc();


  @override
  void initState() {
    BusinessHourUtils.listSlot.clear();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


  return

    widget.isOpen??false?
        SafeArea(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 50,vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
              CustomButton(
                  buttonColor: AppColors.redLight,
                  buttonText: "Off on ${widget.day}", onPress: (){

                BusinessHourData hourModel=       BusinessHourData(


                    vendorData: BusinessProfileData.vendorId()??"",


                    operationalTime: [
                      OperationalTime(
                          day: widget.day,
                          isopen: false,
                          slot: []
                      ),

                    ]
                );
                widget.businessHourBloc.add(
                    BusinessHourPatchEvent(businessHourData: hourModel ));

                Navigator.pop(context);
              })
            ],),

          ),
        )
        :

    Container(
      padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Text(widget.day,
                style: context.titleSmall()?.copyWith(
                  fontWeight: FontWeight.bold
                ),
              ),
              InkWell(
                  onTap: (){
        Navigator.pop(context);
                  },
                  child: Icon(Icons.close,color: AppColors.redLight,))

            ],),
            10.height(),

            Wrap(children: BusinessHourUtils.listSlot.map((item)=>
            CustomSlotCard(slot: item,onTap: (){

              BusinessHourUtils.listSlot.removeLast();
              setState(() {

              });
              //daySlotList.removeLast();
            },)
            ).toList(),),

            SlotWidget(
              startTimeController: startTimeController,
              endTimeController: endTimeController,
              timeGapInMinute: 10,
              title:
            '',
              deleteCallBack: () {

              },
            ),

            20.height(),
            Align(alignment: Alignment.center,
            child:    FloatingActionButton(
            backgroundColor: AppColors.black,
            onPressed: (){
              if(startTimeController.text.isNotEmpty&&endTimeController.text.isNotEmpty){
                BusinessHourUtils.addToSlotList(Slot(startTime:startTimeController.text,
                    endTime: endTimeController.text,slotName: "slot ${BusinessHourUtils.listSlot.length}"));

                setState(() {
startTimeController.clear();
endTimeController.clear();


                });

              }else{
                showToast("Add Start time and End time");
              }

            },child: Icon(Icons.add),),),

            10.height(),

            //
            // CustomCheckBox(),


            BottomSheetButton(onTap: (){
              if(BusinessHourUtils.listSlot.isEmpty&&startTimeController.text.isNotEmpty&&endTimeController.text.isNotEmpty){
                BusinessHourUtils.addToSlotList(Slot(startTime:startTimeController.text,
                    endTime: endTimeController.text,slotName: "slot ${BusinessHourUtils.listSlot.length}")) ;
              }else
              if(BusinessHourUtils.listSlot.isEmpty){

                showToast("Add at least one slot");
                return;
              }


             BusinessHourData hourModel=       BusinessHourData(


         vendorData: BusinessProfileData.vendorId()??"",


         operationalTime: [
           OperationalTime(
             day: widget.day,
             isopen: !(widget.isOpen??false),
             slot: BusinessHourUtils.listSlot
           ),

         ]
             );


                widget.businessHourBloc.add(
                    BusinessHourPatchEvent(businessHourData: hourModel )
                );



              Navigator.pop(context);


            },),
            30.height()
          ],
        ),
      ),
    );


  }
}
