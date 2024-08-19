import 'package:flutter_application_1/Screens/Client_dashboard/RideDetails/ride_details_ctrl.dart';
import 'package:get/get.dart';


class RideDetailBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  RideDetailsController());
 }
}