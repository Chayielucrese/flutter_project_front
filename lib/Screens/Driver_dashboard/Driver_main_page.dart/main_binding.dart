
import 'package:flutter_application_1/Screens/Driver_dashboard/Driver_main_page.dart/main_ctrl.dart';
import 'package:get/get.dart';

class DriverMainPageBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  DriverMainPageController());
 }
}