import 'package:flutter_application_1/Screens/Driver_dashboard/Wallet_Recharge/erecharge_ctrl.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Welcome/welcome_ctrl.dart';
import 'package:get/get.dart';

class WalletRechargeBinding extends Bindings {
  @override
 void dependencies(){
  Get.lazyPut(()=>  WalletRechargeController());
 }
}