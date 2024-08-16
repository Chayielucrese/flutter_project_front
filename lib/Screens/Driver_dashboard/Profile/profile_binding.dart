import 'package:flutter_application_1/Screens/Driver_dashboard/Profile/profile_ctrl.dart';

import 'package:get/get.dart';

class DriverProfileBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  DriverProfileController());
 }
}