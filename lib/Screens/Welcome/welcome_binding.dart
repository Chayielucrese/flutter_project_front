import 'package:flutter_application_1/Screens/Welcome/welcome_ctrl.dart';
import 'package:get/get.dart';

class WelcomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WelcomeCtrl());
  }
}
