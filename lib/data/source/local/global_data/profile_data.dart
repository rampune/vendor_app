import 'dart:convert';

import '../../../../config/string.dart';
import '../../../../features/admin_details/model/business_resister_model.dart';
import '../hive_box.dart';

class BusinessProfileData{
  static saveBusinessRegistrationData(BusinessRegisterModel model) {
    MyHiveBox.instance.getBox().put(AppStr.businessRegistration,
        jsonEncode(model.toJson()));
  }

  static BusinessRegisterModel? getBusinessRegistrationData() {
    if(MyHiveBox.instance
        .getBox().get(AppStr.businessRegistration)!=null){
      return BusinessRegisterModel.fromJson(jsonDecode(MyHiveBox.instance
          .getBox().get(AppStr.businessRegistration))) ;
    }else{
      return null;
    }

  }
  static String? vendorId() {
    return getBusinessRegistrationData()?.businessData?.vendorId ;
  }
  static PhoneOrEmailModel getProfilePhoneOrEmail(){
   String data= MyHiveBox.instance
        .getBox().get(AppStr.loginPhoneOrEmail)??"0000000000";

    return PhoneOrEmailModel(isPhone:!data.contains("@") , phoneOrEmail: data);
  }

}
class PhoneOrEmailModel{
  final bool isPhone;
  final String phoneOrEmail;
  PhoneOrEmailModel({required this.isPhone,required this.phoneOrEmail});
}