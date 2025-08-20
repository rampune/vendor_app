part of 'dio_client.dart';
ApiResults _apiSuccessResponse(Response response) {
  logger("--- SUCCESS Response ---"
      "\nStatus Code: ${response.statusCode}"
      "\nMessage: ${response.statusMessage}"
      "\nData: ${response.data}\n");

  if (response.statusCode == 200 ||
      response.statusCode == 201 ||
      response.statusCode == 202) {
    return ApiResults(
      response.data,
      200,
      response.statusMessage,
    );
  } else {
    return ApiResults(
      response.data,
      response.statusCode,
      response.statusMessage ?? "Unexpected status",
    );
  }
}

ApiResults _apiErrorResponse(dynamic exception, StackTrace stacktrace) {
  if (exception is DioException) {
    final response = exception.response;

    logger("---  DIO ERROR ---"
        "\nURL: ${response?.realUri}"
        "\nStatus Code: ${response?.statusCode}"
        "\nMessage: ${response?.statusMessage ?? exception.message}"
        "\nResponse Data: ${response?.data}"
        "\nType: ${exception.type}"
        "\nError: ${exception.error}"
        "\nStacktrace: $stacktrace\n");

    return ApiResults(
      response?.data ?? exception.message,
      response?.statusCode ?? 500,
      response?.statusMessage ?? exception.message,
    );
  }

  logger("---  UNKNOWN ERROR ---"
      "\nException: $exception"
      "\nStacktrace: $stacktrace\n");

  return ApiResults(
    exception.toString(),
    500,
    "Unexpected Error: $stacktrace",
  );
}


Future <List<MapEntry<String, MultipartFile>>>  _filesToMapEntry(List<ImageUploadModel> listUploadModel)async{
  List<MapEntry<String, MultipartFile>> listMapEntry=[];
  for (var uploadModel in listUploadModel) {
    listMapEntry.add(  MapEntry(
      uploadModel.fileName, // field name, backend should accept 'images' or 'images[]'
      await MultipartFile.fromFile(uploadModel.file.path,
          filename: uploadModel.file.path.split('/').last),
    ));
  }
  return listMapEntry;
}