import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';
import '../../../config/assets.dart';
import '../../../config/theme.dart';
class CustomSlider extends StatelessWidget {
  const CustomSlider({super.key,
  required this.widget});
final Widget widget;
  @override
  Widget build(BuildContext context) {
    return  CarouselSlider.builder(
      itemCount:2,
      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
        Text("Grow Your Venue with Us",
          textAlign: TextAlign.center,
          style: context.titleLarge()?.copyWith(
              fontWeight: FontWeight.bold
          ),),
        20.height(),
        Text("List your pub or club and reach\nthousands of nightlife lovers\ninstantly.",
          textAlign: TextAlign.center,
          style: context.titleSmall()?.copyWith(
              color: AppColors.darkGray
          ),
        ),
        10.height(),
        Expanded(

            child: Image.asset(AppAssetsPath.partnerLoginLogo,
              fit: BoxFit.fill,)),
      ],)


      , options: CarouselOptions(
      autoPlay: true,
      enlargeCenterPage: true,
      viewportFraction: 0.9,
      aspectRatio: 2.0,
      initialPage: 2,
    ),
    );
  }
}
