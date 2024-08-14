import 'package:flutter_application_1/Screens/Driver_dashboard/Statistics/statistics_ctrl.dart';
import 'package:get/get.dart';

class DriverDashboardBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  DriverDashboardController());
 }
}