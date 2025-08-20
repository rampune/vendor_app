import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/empty_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/event/bloc/event_post_bloc.dart';
import 'package:new_pubup_partner/features/event/event_show/views/custom_expansion_tile.dart';
import 'package:new_pubup_partner/features/event/event_show/views/event_view.dart';
import 'package:new_pubup_partner/features/event/model/EventPostModel.dart';


class ShowEvent extends StatefulWidget {
  const ShowEvent({super.key});

  @override
  State<ShowEvent> createState() => _ShowEventState();
}

class _ShowEventState extends State<ShowEvent> {
  EventPostBloc eventPostBloc=EventPostBloc();

  @override
  void initState() {
    eventPostBloc.add(EventGetEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("All Events"),

),
    body: BlocBuilder<EventPostBloc,EventPostState>
      (
        bloc: eventPostBloc,
        builder: (

            BuildContext context,EventPostState state){
  if(state is EventPostLoadingState){
    return CustomLoadingWidget();

  }else        if(state is EventGetSuccessState){

if(state.getEventModelList.isEmpty){
  return CustomEmptyWidget(message: "Event not available");
}else{
  return  successView(state: state);
}





          }else if(state is EventPostErrorState){
            return CustomErrorWidget(msg: state.errorMsg,
            retryCallBack: (){
              eventPostBloc.add(EventGetEvent());

            },
            );
          }


          return  SizedBox.shrink();
        })
    );
  }

  Widget successView({required EventGetSuccessState state}){


    Map<String, List<EventPostModel>> allEventFilter = {};

    for (var model in state.getEventModelList) {
      final status = model.status;
      if (status != null) {
        allEventFilter.putIfAbsent(status, () => []).add(model);
      }
    }

    print("map is $allEventFilter");

    List<String> keys=allEventFilter.keys.toList()??[];
   return  ListView.separated

      (itemBuilder: (BuildContext context,int index){

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: CustomExpansionTile(title: "${keys[index]} Event (${allEventFilter[keys[index]]?.length})",
          leadingIcon: Icons.event_available_outlined, children: allEventFilter[keys[index]]?.map((item)=>
              Column(children: [EventView(getEventModel: item),
                Divider()
              ],)).toList()??[],
          ));




    },

        separatorBuilder:  (BuildContext context,int index){
          return 0.height();
        }, itemCount: keys.length);
  }
}
