import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
import '../../../config/logger.dart';
import 'api_result_handler.dart';
part  'api_utils.dart';
class DioClient {
  late Dio dio;
  DioClient({String baseUrl = "", bool verify = true,
  String  contentType="application/json"
  }) {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      contentType: contentType,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 60),
    );
    dio = Dio(baseOptions);
    if (!verify) {
      dio.httpClientAdapter = IOHttpClientAdapter(
        createHttpClient: () {
          HttpClient client = HttpClient();
          client.badCertificateCallback =
              ((X509Certificate cert, String host, int port) => true);
          return client;
        },
      );
    }

  }

  Future<ApiResults> patchData({
    required String endPoint,
    Object? data,
    ProgressCallback? uploadProgress,
    String? contentType
  }) async {


    try {
      var response = await dio.patch(
        endPoint,
        data: data,
        options: Options(
          contentType: contentType, // or Headers.jsonContentType
        ),
        onSendProgress: uploadProgress,
      );

      logger(
          'URL=$endPoint statusCode=${response.statusCode} and Response=${response.data}');

  return _apiSuccessResponse(response);
    } catch (e,s) {
  return _apiErrorResponse(e, s);
    }
  }


  Future<ApiResults?> patchMultipartData({
    required List<ImageUploadModel> listUploadModel,
    required Map<String,String> mapData,
    required String vendorId,required String endPoint}) async {
    try {
      FormData formData=FormData.fromMap(mapData);
formData.files.addAll(await _filesToMapEntry(listUploadModel));
      var response=await   dio.patch(
        "${EndPoints.baseUrl}$endPoint/$vendorId/",
        data: formData,
      );
      return _apiSuccessResponse(response);
    } catch(e,s){
      return _apiErrorResponse(e,s);
    }
  }


  Future<ApiResults> getData(
      {required String endPoint,
      Map<String, dynamic>? queryParameters,
      Options? options}) async {

      try {
        logger(
            'URL=${dio.options.baseUrl + endPoint + queryParameters.toString()}');

        var response = await dio.get(endPoint,
            queryParameters: queryParameters, options: options);
        logger('Response=${response.data}');
     return  _apiSuccessResponse(response);
      } catch(e,s){
        return _apiErrorResponse(e, s);
      }

  }






  Future<ApiResults> postData(
      {required String endPoint,
      Object? data,
      bool validateToken = true,
      ProgressCallback? uploadProgress,String contentType="application/json"}) async {
      try {
        logger('URL=${dio.options.baseUrl + endPoint}');
        logger('Posting data=$data');
        var response = await dio.post(endPoint,
            data: data,
            options: Options(
              contentType: contentType, // or Headers.jsonContentType
            ),
            onSendProgress: uploadProgress);
        return _apiSuccessResponse(response);
      } catch (e,s) {
      return _apiErrorResponse(e, s);
      }

  }



  Future<ApiResults> deleteData(
      {required String endPoint,
        Map<String, dynamic>? queryParameters,
        Options? options}) async {

    try {
      logger(
          'URL=${dio.options.baseUrl + endPoint + queryParameters.toString()}');

      var response = await dio.delete(endPoint,
          queryParameters: queryParameters, options: options);
      logger('Response=${response.data}');
      return  _apiSuccessResponse(response);
    } catch(e,s){
      return _apiErrorResponse(e, s);
    }

  }


  Future<ApiResults?> uploadImagesWithData({
    required List<ImageUploadModel> imageFiles,
    required Map<String, dynamic> data,
    required String endPoint,
  }) async {
final filteredMap = Map<String, dynamic>.from(data)
      ..removeWhere((key, value) => value == null);
    FormData formData = FormData();

    filteredMap.forEach((key, value) {
      String?encode;
      try
      {
        if(key=="artists"||key=="tickets"||key=="tables"){

       encode= jsonEncode(value.toString());}
      }catch(exception){
print("abc exception dio_client line 272");
      }
      formData.fields.add(MapEntry(key, encode??value.toString()));
    });

    // Ab imagess =--
    for (var file in imageFiles) {
      formData.files.add(
        MapEntry(
          file.fileName, //
          await MultipartFile.fromFile(
            file.file.path,
            filename: file.file.path.split('/').last,
          ),
        ),
      );
    }


    log("\n\n\nform data \n${formData.files.toSet()}\n\n  data is\n\n ${formData.fields.toSet()} \n  \n");
    // call to postjjj
    return  postData(
      endPoint: endPoint,
      data: formData, //
      contentType: "multipart/form-data",
      uploadProgress: (sent, total) {
        print("Uploading... ${(sent / total * 100).toStringAsFixed(2)}%");
      },
    );
  }

}

class ImageUploadModel{
String fileName;
File file;
ImageUploadModel({required this.file,
required this.fileName});
}