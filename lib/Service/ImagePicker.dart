import 'dart:io';

import 'package:image_picker/image_picker.dart';


Future<void> pickImage(File image)async {

    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
  
        image = File(pickedFile.path);

    }
  }