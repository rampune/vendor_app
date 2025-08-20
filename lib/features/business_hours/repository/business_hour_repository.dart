import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:new_pubup_partner/data/source/network/dio_client.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';

class BusinessHourRepository{
  static businessHourPostRepository({required Map<String ,dynamic > data}){
    print("\n\n\namra007////postdata -${jsonEncode(data)}");
    return DioClient(
      baseUrl: EndPoints.baseUrl

    ).postData(endPoint: "operational_hour/",
    data: data,
      contentType: Headers.jsonContentType
    );
  }
  static businessHourGetRepository({required String vendorId}){
    print("\n\n\namra007////getData -get $vendorId");
    return DioClient(
        baseUrl: EndPoints.baseUrl

    ).getData(endPoint: "operational_hour/$vendorId/"
    );
  }
  static businessHourPatchRepository({required Map<String ,dynamic > data,
    required String vendorId
  }){

  print("\n\n\namra007////patchdata -${jsonEncode(data)}");
    return DioClient(
        baseUrl: EndPoints.baseUrl,

    ).patchData(endPoint: "operational_hour/$vendorId/",data: data
    );
  }
}