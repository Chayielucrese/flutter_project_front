import 'package:flutter_application_1/Screens/Driver_dashboard/View_vehicles/view_vehicle_ctrl.dart';
import 'package:get/get.dart';

class ViewVehicleBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  ViewVehicleController());
 }
}