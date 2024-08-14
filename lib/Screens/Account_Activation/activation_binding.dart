import 'package:flutter_application_1/Screens/Account_Activation/activation_ctrl.dart';

import 'package:get/get.dart';

class ActivationBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  ActivationController());
 }
}