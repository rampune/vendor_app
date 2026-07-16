import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:new_pubup_partner/data/source/network/end_points.dart';
import 'package:new_pubup_partner/features/event/fragments/event_add_artists.dart';
import '../../../config/logger.dart';
import 'api_result_handler.dart';
import 'package:path/path.dart' as path;

part  'api_utils.dart';
class DioClient {
  late Dio dio;
  DioClient({
    String baseUrl = "",
    bool verify = true,
    String contentType = "application/json",
    Duration? connectTimeout,
    Duration? receiveTimeout,
    Duration? sendTimeout,
  }) {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: baseUrl,
      contentType: contentType,
      receiveDataWhenStatusError: true,
      connectTimeout: connectTimeout ?? const Duration(seconds: 30),
      receiveTimeout: receiveTimeout ?? const Duration(seconds: 60),
      sendTimeout: sendTimeout ?? const Duration(seconds: 60),
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
    bool isUpdate = false,
    ProgressCallback? uploadProgress,
  }) async {
    final filteredMap = Map<String, dynamic>.from(data)
      ..removeWhere((key, value) => value == null || (value is String && value.isEmpty));

    FormData formData = FormData();

    final List<int> artistIds = EventAddArtists.getSelectedArtistIds();
    filteredMap.remove('artists_datas'); // Just in case, remove old one

    // Now add all other fields
    filteredMap.forEach((key, value) {
      if (key == 'tickets' || key == 'tables' || key == 'faq_details') {
        formData.fields.add(MapEntry(key, jsonEncode(value)));
      } else if (value is List) {
        formData.fields.add(MapEntry(key, jsonEncode(value)));
      } else {
        formData.fields.add(MapEntry(key, value.toString()));
      }
    });

    // NOW ADD ARTIST IDS CORRECTLY — REPEATED FIELD WITHOUT BRACKETS
    for (var id in artistIds) {
      formData.fields.add(MapEntry('artists_datas', id.toString()));
    }

    // Add images
    for (var file in imageFiles) {
      formData.files.add(MapEntry(
        file.fileName,
        await MultipartFile.fromFile(file.file.path, filename: file.file.path.split('/').last),
      ));
    }

    // DEBUG LOG — YOU SHOULD SEE TWO LINES
    formData.fields
        .where((e) => e.key == 'artists_datas')
        .forEach((e) => log("→ Sending artists_datas = ${e.value}"));

    log("FINAL FORM FIELDS COUNT: ${formData.fields.length}");
    log("ARTIST IDS SENT: $artistIds");

    if (isUpdate) {
      return patchData(
        endPoint: endPoint,
        data: formData,
        contentType: 'multipart/form-data',
        uploadProgress: uploadProgress,
      );
    } else {
      return postData(
        endPoint: endPoint,
        data: formData,
        contentType: 'multipart/form-data',
        uploadProgress: uploadProgress,
      );
    }
  }







}



class ImageUploadModel{
String fileName;
File file;
ImageUploadModel({required this.file,
required this.fileName});
}