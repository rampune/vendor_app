import 'package:flutter/cupertino.dart';

class KycController{

  static GlobalKey<FormState> businessKycFormKey=GlobalKey<FormState>();
  static GlobalKey<FormState> bankKycFormKey=GlobalKey<FormState>();
  static GlobalKey<FormState> ownerKycFormKey=GlobalKey<FormState>();
  static GlobalKey<FormState> uploadKycFormKey=GlobalKey<FormState>();

static int  ?selectedTypeIndex;
static TextEditingController vendorName=TextEditingController();
  static TextEditingController businessName=TextEditingController();
  static TextEditingController businessDescription = TextEditingController();
  static TextEditingController gst=TextEditingController();
  static TextEditingController panCard=TextEditingController();
  static TextEditingController fssai=TextEditingController();
  static TextEditingController constitution=TextEditingController();
  static TextEditingController bankName=TextEditingController();
  static TextEditingController accountNumber=TextEditingController();
  static TextEditingController accountName=TextEditingController();
  static TextEditingController ifscCode=TextEditingController();
  static TextEditingController ownerName=TextEditingController();
  static TextEditingController ownerEmailId=TextEditingController();
  static TextEditingController ownerContactNumber=TextEditingController();

  static TextEditingController checkPhoto=TextEditingController();
static TextEditingController logoPhoto=TextEditingController();
static TextEditingController businessLogoPhoto=TextEditingController();
static TextEditingController businessProofPhoto=TextEditingController();
static TextEditingController gstCertificatePhoto=TextEditingController();
static TextEditingController panCertificatePhoto=TextEditingController();
static TextEditingController fssaiCertificatePhoto=TextEditingController();

}