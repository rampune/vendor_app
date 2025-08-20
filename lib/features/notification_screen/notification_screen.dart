import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_error_widget.dart';
import 'package:new_pubup_partner/features/common_widgets/custom_loading_widget.dart';

import '../common_widgets/overlay_loading_progress.dart';
import '../dashboard_screen/bloc/status_bloc.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key,required this.vendorId});
  final String vendorId;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  StatusBloc statusBloc=StatusBloc();
  @override
  void initState() {
    statusBloc.add(
      StatusGetKycEvent(
        vendorId: widget.vendorId?? '',
      ),
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("Notification"),
    ),
    body: Center(
      child: BlocBuilder<StatusBloc, StatusState>(
        bloc: statusBloc,
        builder: (BuildContext context, StatusState state) {
         if( state is StatusLoadingState){
           return CustomLoadingWidget();
         }else if (state is StatusKycApprovalState) {
           return Text("Kyc approved");
          } else if (state is StatusKycRejectedState) {
            return Text("Kyc Rejected");

          } else if (state is StatusKycPendingState) {
    return Text("kyc Pending");
            return ListView.builder(itemBuilder: (BuildContext context, int index){
              return ListTile(title: Text("dsfs"),

              shape: RoundedRectangleBorder(

              ),);
            });
          } else if (state is StatusKycFreshUserState) {
         return Text("kyc not send");
          }else if(state is  StatusErrorState){
           return CustomErrorWidget(retryCallBack: (){
             statusBloc.add(
               StatusGetKycEvent(
                 vendorId: widget.vendorId?? '',
               ),
             );
           },);
          }
          return SizedBox.shrink();
        },

      ),
    ),
    );
  }
}
