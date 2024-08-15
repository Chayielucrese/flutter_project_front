import 'package:flutter_application_1/Screens/Driver_dashboard/Request/request_ctrl.dart';
import 'package:get/get.dart';

class DriverRequestBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  DriverRequestController());
 }
}