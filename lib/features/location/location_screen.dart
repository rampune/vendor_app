import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:new_pubup_partner/config/extensions.dart';

import '../../config/assets.dart';
import '../../config/common_functions.dart';
import '../../config/config.dart';
import '../../config/routes.dart';
import '../../services/lat_log_to_address.dart';
import '../../services/location_service.dart';
import '../common_widgets/custom_button.dart';
import '../common_widgets/overlay_loading_progress.dart';
import '../common_widgets/suffix_icon_button.dart';



class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
          Expanded(child: SizedBox.shrink()),
        Expanded(child: Container(

            decoration: BoxDecoration(
          color: dynamicThemeColor(context),

          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30)
          )
            ),
            width: double.infinity,
            child: Column(children: [
        20.height(),
        Text("You're All Set!",
          style: context.titleLarge()?.copyWith(
            fontWeight: FontWeight.bold
          ),
        ),

        Expanded(child: Image.asset(AppAssetsPath.location)),

        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: SuffixIconButton(title: "Detect My Location",isIcon: false,
            onTap: ()async{
              OverlayLoadingProgress.start(context);
              Position? position=await   LocationService().getPosition(context,timeoutSecond: 10);
              String ? address=await getAddressFromLatLng(position?.latitude??0.0, position?.longitude??0.0);
              OverlayLoadingProgress.stop();
              showDialog(
                  barrierDismissible: false,
                  context: context, builder: (_)=>AlertDialog(
                actions: [
                 Center(
                   child: CustomButton(
                       
                       buttonText: "Ok", onPress: (){
                     Navigator.pop(context);
                     Navigator.pushNamed(context, AppRoutes.homeScreen);

                   },
                   buttonColor: dynamicThemeColor(context),),
                 )
                ],
                content: Text("${address}"),
              ));

// if(position!=null){
//   Navigator.pushNamed(context, AppRoutes.homeScreen);
// }
         showToast(" latitude is ${position?.latitude}  longitude is ${position?.longitude}");
            },
            ))
        ,10.height(),
            InkWell(
              onTap: (){
                Navigator.pushNamed(context, AppRoutes.homeScreen);
              },
              child: Text("Not Now",
                style: context.titleSmall(),
              ),
            )
            ,30.height(),
            ],),


        ))
            ,

          ],
        ),
      ),

    );
  }
}
