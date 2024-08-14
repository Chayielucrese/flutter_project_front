import 'package:flutter_application_1/Screens/Driver_dashboard/Vehicles/vehicle_ctrl.dart';
import 'package:get/get.dart';

class DriverVehicleBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  DriverVehicleController());
 }
}