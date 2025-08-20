import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:new_pubup_partner/config/extensions.dart';


import '../../../config/assets.dart';
import '../../../config/config.dart';
import '../../../config/routes.dart';
import '../../../config/theme.dart';
import '../../common_widgets/custom_scaffold.dart';
import '../../common_widgets/suffix_icon_button.dart';

class PartnerLoginModel{
  String title,description,imgPath;
  PartnerLoginModel({required this.title,
  required this.description,required this.imgPath});
}
class PartnerLogin extends StatelessWidget {
  const PartnerLogin({super.key});
static List<PartnerLoginModel> partnerLoginModel=[PartnerLoginModel

  (title: "Grow Your Venue with Us", description: "List your pub or club and reach thousands of nightlife lovers instantly.",
    imgPath: AppAssetsPath.partnerLoginLogo),
  PartnerLoginModel

    (title: "Promote Events in Minutes", description: "From DJ nights to theme parties, manage everything with just a few taps.",
      imgPath: AppAssetsPath.promoLoginLogo)
];
  @override
  Widget build(BuildContext context) {
    return  CustomScaffold(
      body: SafeArea(child: Column(
        children: [
          Expanded(
            child: CarouselSlider(

              options: CarouselOptions(height: 400.0,
                  aspectRatio:1,
                  viewportFraction: 1,
              autoPlay: true),
              items: [0,1].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(


                      ),

                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(partnerLoginModel[i].title,
                            textAlign: TextAlign.center,
                            style: context.titleLarge()?.copyWith(
                                fontWeight: FontWeight.bold
                            ),),
                          20.height(),
                          Text(partnerLoginModel[i].description,
                            textAlign: TextAlign.center,
                            style: context.titleSmall()?.copyWith(
                                color: AppColors.darkGray
                            ),
                          ),
                          20.height(),
                          Expanded(
                            // height: 300,
                            // width:double.infinity,

                            child: Image.asset(partnerLoginModel[i].imgPath,
                              fit: BoxFit.fill,),
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ),







          Container(
            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
            decoration: BoxDecoration(color: AppColors.black),
            child: Column(
              children: [
                10.height(),
                SuffixIconButton(title: "Login", onTap: (){
          Navigator.pushNamed(context, AppRoutes.mobileLoginScreen);
                },backgroundColor: dynamicThemeColor(context),),
                20.height(),
                SuffixIconButton(title: "Partner with PubUp", onTap: (){

                }),
                20.height(),
                Text.rich(TextSpan(children: [
                  TextSpan(text: "By continuing, you agree with our\n",
                  style: context.bodySmall()?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: dynamicWhiteBtnTheme(context)
                  )),
                  TextSpan(text: "Term of Use",
                    style: context.bodySmall()?.copyWith(
                      color: AppColors.green
                    )
                  ),
                  TextSpan(text: " and ",
                      style: context.bodySmall()?.copyWith(
                        color: dynamicWhiteBtnTheme(context)
                      )),
                  TextSpan(text: "Privacy policy",
                      style: context.bodySmall()?.copyWith(
                          color: AppColors.green
                      )
                  ),

                ])),
                10.height()

              ],
            ),

          )

        ],
      )),
    );
  }
}
