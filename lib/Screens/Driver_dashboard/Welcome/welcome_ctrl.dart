import 'dart:async';

import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';

class DriverWelcomeController extends AppController {
  @override
  void onInit() {
    super.onInit();

    // Navigate after a delay of 4 seconds
    Timer(const Duration(seconds: 4), () {
      Get.toNamed(AppRoutes.driverStats);
    });
    update();
  }
}
