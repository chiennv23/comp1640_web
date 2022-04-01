import 'dart:io';

import 'package:comp1640_web/modules/posts/controlls/post_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<String> allowFileList = [
  'pdf',
  'zip',
  'doc',
  'docx',
  'jpg',
  'jpeg',
  'png',
];

Future<FilePickerResult> pickFile(
    {String fileName, ValueChanged<FilePickerResult> onDroppedFile}) async {
  PostController postController = Get.find();
  FilePickerResult result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpg', 'png', 'pdf', 'doc', 'docx'],
  );

  if (result != null) {
    onDroppedFile(result);
    postController.fileName.value = result.files.single.name;
    return result;
    // File file = File(result.files.single.bytes);
  } else {
    // User canceled the picker
  }
}
