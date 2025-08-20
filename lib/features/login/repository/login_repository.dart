import '../../../data/source/network/api_result_handler.dart';
import '../../../data/source/network/dio_client.dart';
class LoginRepository{
  static Future<ApiResults?> sendOtpRepository({required String mobileNumber,
  required String otp
  })async{
    return DioClient(baseUrl:"https://adminapi.pubup.in.apxfarms.com/" ).
    postData(endPoint: "send_otp/",data: {
      "mobile_no": mobileNumber,
      "otp": otp
    });
  }
}