class ApiResults {
  dynamic data;
  int? statusCode;
  String? message;
  ApiResults(this.data, this.statusCode, this.message);
}

// class ApiResponseToRealModel{
// final String status;
// final dynamic data;
// ApiResponseToRealModel({required this.data,required this.status});
// factory ApiResponseToRealModel.fromJson(Map<String,dynamic> map){
//   return ApiResponseToRealModel(data:map["data"] , status: map["status"]);
// }
//
// }
