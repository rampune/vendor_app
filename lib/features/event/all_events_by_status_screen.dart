// import 'package:flutter/material.dart';
// import 'package:new_pubup_partner/features/event/event_show/views/event_view.dart';
// import 'package:new_pubup_partner/features/event/model/EventPostModel.dart';
//
// class AllEventsByStatusScreen extends StatefulWidget {
//   final List<EventPostModel> events;
//   final String status;
//
//   const AllEventsByStatusScreen({
//     super.key,
//     required this.events,
//     required this.status,});
//
//   @override
//   State<AllEventsByStatusScreen> createState() => _AllEventsByStatusScreenState();
// }
//
// class _AllEventsByStatusScreenState extends State<AllEventsByStatusScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("${widget.status} Events"),
//       ),
//       body: ListView.separated(
//         itemBuilder: (context, index) {
//           return Column(
//             children: [
//               EventView(getEventModel: widget.events[index]),
//               Divider(color: Colors.black,thickness: 0.6,),
//             ],
//           );
//         },
//
//         separatorBuilder: (context, index) => SizedBox(),
//         itemCount: widget.events.length,
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/event/bloc/event_post_bloc.dart';
import 'package:new_pubup_partner/features/event/event_show/views/event_view.dart';
import 'package:new_pubup_partner/features/event/model/EventPostModel.dart';

class AllEventsByStatusScreen extends StatefulWidget {
  final String status; // Remove events; fetch fresh always

    final List<EventPostModel>? events;

  const AllEventsByStatusScreen({
    super.key,
    required this.status,
    this.events
  });

  @override
  State<AllEventsByStatusScreen> createState() => _AllEventsByStatusScreenState();
}

class _AllEventsByStatusScreenState extends State<AllEventsByStatusScreen> {
  late EventPostBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = EventPostBloc();
    // Trigger initial fetch
    bloc.add(EventGetEvent());
  }

  @override
  void dispose() {
    bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.status} Events"),
      ),
      body: BlocProvider.value(
        value: bloc,
        child: BlocConsumer<EventPostBloc, EventPostState>(
          listener: (context, state) {
            if (state is EventPostSuccessState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Action completed successfully'),
                  duration: Duration(seconds: 2),
                ),
              );
            } else if (state is EventPostErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMsg),
                  backgroundColor: Colors.red,
                  duration: Duration(seconds: 3),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is EventPostLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventGetSuccessState) {
              final allEvents = state.getEventModelList;
              final filteredEvents = allEvents.where((event) {
                return event.status?.toLowerCase().trim().contains(
                  widget.status.toLowerCase().trim(),
                ) ?? false;
              }).toList();

              if (filteredEvents.isEmpty) {
                return const Center(child: Text('No events found'));
              }

              return ListView.separated(
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      EventView(getEventModel: filteredEvents[index]),
                      const Divider(color: Colors.black, thickness: 0.6),
                    ],
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(),
                itemCount: filteredEvents.length,
              );
            } else if (state is EventPostErrorState) {
              return Center(child: Text('Error: ${state.errorMsg}'));
            }
            return const Center(child: Text('Press to load events'));
          },
        ),
      ),
    );
  }
}