import 'package:flutter_application_1/Screens/Driver_dashboard/Subscription/subcription_ctrl.dart';
import 'package:get/get.dart';

class DriverSubscriptionBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  DriverSubscriptionController());
 }
}