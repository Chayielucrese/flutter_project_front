import 'package:flutter_application_1/Screens/Driver_dashboard/View_vehicles/Vehicle_tabview/document_ctrl.dart';
import 'package:get/get.dart';

class DriverVehicleDocumentBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  DriverVehicleDocumentController());
 }
}