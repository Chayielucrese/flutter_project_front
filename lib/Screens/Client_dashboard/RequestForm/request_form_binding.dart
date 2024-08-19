import 'package:flutter_application_1/Screens/Client_dashboard/RequestForm/request_form_ctrl.dart';
import 'package:flutter_application_1/Screens/Client_dashboard/RideDetails/ride_details_ctrl.dart';
import 'package:get/get.dart';


class RequestFormBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  RequestFormController());
 }
}