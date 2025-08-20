import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
class CustomCarouselSlider extends StatelessWidget {
  const CustomCarouselSlider({super.key,required this.listWidget,this.height,
    this.viewPortWidth,this.autoPlay});
  final List<Widget> listWidget;
  final double? height;
  final double ?viewPortWidth;
  final bool ?autoPlay;
  static CarouselSliderController buttonCarouselController = CarouselSliderController();
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController:buttonCarouselController ,
      items:listWidget ,
      options: CarouselOptions(
        height:height?? 240,
        aspectRatio: 16 / 9,
        viewportFraction: viewPortWidth??1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay:autoPlay?? true,
        autoPlayInterval: Duration(seconds: 3),
        autoPlayAnimationDuration: Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        enlargeFactor: 0.2,
        onPageChanged: (int index, changeRes) {
          print("$index");
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
