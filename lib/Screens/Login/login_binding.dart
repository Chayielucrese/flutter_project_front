import 'package:flutter_application_1/Screens/Login/Login_ctrl.dart';

import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  LoginController());
 }
}