import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/common_widgets/custom_carouselSlider.dart';
import '../features/common_widgets/custom_error_widget.dart';
import '../features/common_widgets/custom_loading_widget.dart';
import '../features/common_widgets/custom_progessive_image.dart';

import 'bloc/promotion_bloc.dart';
import 'model/promotion_model.dart';
class PromotionCardSlider extends StatefulWidget {
  const PromotionCardSlider({super.key, this.index = 0});
  final int index;
  @override
  State<PromotionCardSlider> createState() => _UpcomingEventWidgetState();
}
class _UpcomingEventWidgetState extends State<PromotionCardSlider> {
  PromotionBloc promotionBloc=PromotionBloc();
  @override
  void initState() {
   promotionBloc.add(PromotionGetBannerEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PromotionBloc, PromotionState>(
      bloc: promotionBloc,
      builder: (context, state) {
if(state is PromotionLoadingState){
  return    loadingOrErrorWidget(
    CustomLoadingWidget()

  );
}else if(state is PromotionErrorState){
  return loadingOrErrorWidget(CustomErrorWidget(
    msg: state.errorMsg,
    retryCallBack: (){
      promotionBloc.add(PromotionGetBannerEvent());
    },
  ));
}

if(state is PromotionSuccessState){

List<PromotionDataModel> listPromotion=
(state.promotionModel.promotionDataModel??[]).where((item)=>item.status??false).toList();
  return CustomCarouselSlider(listWidget:
    listPromotion.map((item)=>
        Card(

          child: Column(
            children: [
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:
//'https://picsum.photos/${700}/300'
                    CustomProgressiveImage(imgUrl:"https://adminapi.perseverancetechnologies.com${item.image}",)
                    ,
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              //   child: Row(
              //
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Text(item.name??'',
              //             style: context.titleSmall()?.copyWith(
              //                 fontWeight: FontWeight.bold
              //             ),),
              //           5.height(),
              //           Text(item.promotionType??'',
              //               style: context.bodySmall())
              //         ],
              //       ),
              //       CustomOutlinedButton(context: context,
              //           text: "Book tickets", callback: () {})
              //     ],),
              // )

            ],
          ),)
    ).toList()
    ,);
}

      return  CustomCarouselSlider(listWidget: [
        Card(

        child: Column(
        children: [
          Expanded(
          child: SizedBox(
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10)
            ),
            child:

            CustomProgressiveImage(imgUrl: 'https://picsum.photos/${700}/300',)
            ,
          ),
        ),
        ),
        // Container(
        // margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        // child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // children: [
        // Column(
        // children: [
        // Text("Title",
        // style: context.titleSmall()?.copyWith(
        // fontWeight: FontWeight.bold
        // ),),
        // 5.height(),
        // Text("Title",
        // style: context.bodySmall())
        // ],
        // ),
        // CustomOutlinedButton(context: context,
        // text: "Book tickets", callback: () {})
        // ],),
        // )

        ],
        ),)
        ],);



      },
    );
  }

  loadingOrErrorWidget(Widget widget){
    return SizedBox(
        height: 240,
        width: double.infinity,
        child: Card(
          child: widget,
        ));
  }
}
