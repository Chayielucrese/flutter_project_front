import 'package:flutter_application_1/Screens/Driver_dashboard/Request/Request_tabview_pages/Advance_service_request/advance_request_ctrl.dart';

import 'package:get/get.dart';

class AdvanceServiceRequestBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  AdvanceServiceRequestController());
 }
}