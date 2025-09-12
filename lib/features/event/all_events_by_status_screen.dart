import 'package:flutter/material.dart';
import 'package:new_pubup_partner/features/event/event_show/views/event_view.dart';
import 'package:new_pubup_partner/features/event/model/EventPostModel.dart';

class AllEventsByStatusScreen extends StatefulWidget {
  final List<EventPostModel> events;
  final String status;

  const AllEventsByStatusScreen({
    super.key,
    required this.events,
    required this.status,});

  @override
  State<AllEventsByStatusScreen> createState() => _AllEventsByStatusScreenState();
}

class _AllEventsByStatusScreenState extends State<AllEventsByStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.status} Events"),
      ),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Column(
            children: [
              EventView(getEventModel: widget.events[index]),
              Divider(color: Colors.black,thickness: 0.6,),
            ],
          );
        },

        separatorBuilder: (context, index) => SizedBox(),
        itemCount: widget.events.length,
      ),
    );
  }
}
