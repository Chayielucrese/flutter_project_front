import 'package:flutter_application_1/Screens/Driver_dashboard/Request/Request_tabview_pages/Filter_request/filter_ctrl.dart';
import 'package:get/get.dart';

class FilterRequestBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  FilterRequestController());
 }
}