import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';

import '../config/common_functions.dart';




Future<void> saveFile({required String fileName, File? file}) async {
  if (file != null) {
    final directory = await getApplicationDocumentsDirectory();
    final savedPath = '${directory.path}/$fileName';
    final File newImage = await File(file.path).copy(savedPath);

  }
}

Future<File?> loadFile({required String fileName}) async {
  final directory = await getApplicationDocumentsDirectory();
  final imagePath = '${directory.path}/$fileName';
  final file = File(imagePath);
  if (await file.exists()) {

    return file;
  } else {
    return null;

  }
}

