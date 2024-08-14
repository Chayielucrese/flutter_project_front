import 'package:flutter_application_1/Screens/Client_dashboard/Welcome/welcome_ctrl.dart';
import 'package:get/get.dart';

class ClientWelcomeBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  ClientWelcomeController());
 }
}