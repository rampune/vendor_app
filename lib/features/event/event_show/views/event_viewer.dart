import 'package:flutter/material.dart';


import '../../../../config/theme.dart';
import '../../../common_widgets/custom_scaffold.dart';
import '../../model/EventPostModel.dart';
import 'event_view.dart';

class EventViewer extends StatelessWidget {
  const EventViewer({super.key,required this.getEventModelList  });
  final List<EventPostModel> getEventModelList;
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: Text("${getEventModelList}"),
      ),
      body: SafeArea(
        child: ListView.separated(itemBuilder: (BuildContext context,int index){
          return EventView(getEventModel: getEventModelList[index],);

        },
          separatorBuilder: (BuildContext context, int index){
            return Divider(color: AppColors.darkGray,thickness: 2,);
          },
          itemCount: getEventModelList.length,
        ),
      ),);
  }
}
