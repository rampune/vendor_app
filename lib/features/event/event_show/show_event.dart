import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import 'package:new_pubup_partner/config/theme.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/empty_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/overlay_loading_progress.dart';
import 'package:new_pubup_partner/features/event/all_events_by_status_screen.dart';
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
  EventPostBloc eventPostBloc = EventPostBloc();

  @override
  void initState() {
    eventPostBloc.add(EventGetEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Events")),
      body: BlocBuilder<EventPostBloc, EventPostState>(
        bloc: eventPostBloc,
        builder: (BuildContext context, EventPostState state) {
          if (state is EventPostLoadingState) {
            return CustomLoadingWidget();
          } else if (state is EventGetSuccessState) {
            if (state.getEventModelList.isEmpty) {
              return CustomEmptyWidget(message: "Event not available");
            } else {
              return successView(state: state);

            }
          } else if (state is EventPostErrorState) {
            debugPrint('Error...${state.errorMsg}');
            return CustomErrorWidget(
              msg: state.errorMsg,
              retryCallBack: () {
                eventPostBloc.add(EventGetEvent());
              },
            );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }





  /// old code of Amara ram  11/09/2025
  // Widget successView({required EventGetSuccessState state}) {
  //   Map<String, List<EventPostModel>> allEventFilter = {};
  //
  //   for (var model in state.getEventModelList) {
  //     final status = model.status;
  //     if (status != null) {
  //       allEventFilter.putIfAbsent(status, () => []).add(model);
  //     }
  //   }
  //
  //   print("map is $allEventFilter");
  //
  //   List<String> keys = allEventFilter.keys.toList() ?? [];
  //   return ListView.separated(
  //     itemBuilder: (BuildContext context, int index) {
  //       return Padding(
  //         padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
  //
  //
  //
  //
  //         child: CustomExpansionTile(
  //           title:
  //               "${keys[index]} Event (${allEventFilter[keys[index]]?.length})",
  //           leadingIcon: Icons.event_available_outlined,
  //           children:
  //               allEventFilter[keys[index]]
  //                   ?.map(
  //                     (item) => Column(
  //                       children: [
  //                         EventView(getEventModel: item),
  //                         Divider(),
  //
  //                       ],
  //                     ),
  //                   )
  //                   .toList() ??
  //               [],
  //
  //
  //         ),
  //
  //       );
  //     },
  //
  //     separatorBuilder: (BuildContext context, int index) {
  //       return 0.height();
  //     },
  //     itemCount: keys.length,
  //   );
  // }






/// New code of Saransh 11/09/2025
  Widget successView({required EventGetSuccessState state}) {
    Map<String, List<EventPostModel>> allEventFilter = {};

    for (var model in state.getEventModelList) {
      final status = model.status;
      if (status != null) {
        allEventFilter.putIfAbsent(status, () => []).add(model);
      }
    }

    print("map is $allEventFilter");

    List<String> keys = allEventFilter.keys.toList();
    return ListView.separated(
      itemBuilder: (BuildContext context, int index) {
        final key = keys[index];
        final events = allEventFilter[key] ?? [];
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: ListTile(
              leading: Icon(Icons.event_available_outlined),
              title: Text(key, style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
              subtitle: Text("${events.length} Events"),
              onTap: () {

                // Navigate to event list screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllEventsByStatusScreen(
                      events: events,
                      status: key,
                    ),
                  ),
                );

              },
              trailing: Icon(Icons.arrow_right_outlined,size: 30,),
            ),
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return SizedBox(height: 0);
      },
      itemCount: keys.length,
    );
  }






}




