import 'package:flutter_application_1/Screens/Driver_dashboard/Welcome/welcome_ctrl.dart';
import 'package:get/get.dart';

class DriverWelcomeBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  DriverWelcomeController());
 }
}