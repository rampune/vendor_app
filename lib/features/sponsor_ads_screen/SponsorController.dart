import 'package:flutter/cupertino.dart';
import 'package:new_pubup_partner/features/sponsor_ads_screen/bloc/sponsor_ads_bloc.dart';

class SponsorController{

  static TextEditingController adsName=TextEditingController();
  static TextEditingController adDuration=TextEditingController();
  static TextEditingController promotionType=TextEditingController();
  static TextEditingController adStartDate=TextEditingController();
  static TextEditingController bannerPhoto=TextEditingController();

  static GlobalKey<FormState> formKey=GlobalKey<FormState>();
  static SponsorAdsBloc sponsorAdsBloc=SponsorAdsBloc();
  static clearSponsorController(){

    adsName.clear();
    adDuration.clear();
    promotionType.clear();
    adStartDate.clear();
    bannerPhoto.clear();

  }
}