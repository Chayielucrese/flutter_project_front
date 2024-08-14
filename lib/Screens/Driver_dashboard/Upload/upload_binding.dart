import 'package:flutter_application_1/Screens/Driver_dashboard/Upload/upload_ctrl.dart';
import 'package:get/get.dart';

class DriverUploadBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  DriverUploadController());
 }
}