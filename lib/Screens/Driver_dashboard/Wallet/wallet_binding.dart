import 'package:flutter_application_1/Screens/Driver_dashboard/Vehicles/vehicle_ctrl.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Wallet/wallet_ctrl.dart';
import 'package:get/get.dart';

class UserWalletBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  UserWalletController());
 }
}