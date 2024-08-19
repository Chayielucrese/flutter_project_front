import 'package:flutter_application_1/Screens/Client_dashboard/Welcome/welcome_ctrl.dart';
import 'package:flutter_application_1/Screens/Client_dashboard/client_profile/client_profile_ctrl.dart';
import 'package:get/get.dart';

class ClientProfileBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  ClientProfileController());
 }
}