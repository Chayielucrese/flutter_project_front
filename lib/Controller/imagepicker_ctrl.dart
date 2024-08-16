 import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ImagepickerCtrl extends GetxController {
  late final void Function(int, File) onImagePick;


  Future<void> _pickImage(BuildContext context, int index) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      onImagePick(index, File(pickedFile.path));
    }
  }

}