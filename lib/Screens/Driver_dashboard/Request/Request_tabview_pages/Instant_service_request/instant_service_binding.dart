import 'package:flutter_application_1/Screens/Driver_dashboard/Request/Request_tabview_pages/Instant_service_request/instant_service_request_ctrl.dart';
import 'package:get/get.dart';

class InstantServiceRequestBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  InstantServiceRequestController());
 }
}