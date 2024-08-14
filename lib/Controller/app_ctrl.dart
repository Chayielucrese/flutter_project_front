import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AppController extends GetxController {


void alertError(String message) {
    Get.snackbar("Error", message,
        colorText: Colors.white, backgroundColor: Colors.red);
  }

  void alertSuccess(String message) {
    Get.snackbar("Success", message,
        colorText: Colors.white, backgroundColor: Colors.pink);
  }
}
