import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Account_Activation/activation_binding.dart';
import 'package:flutter_application_1/Screens/Account_Activation/activation_screen.dart';
import 'package:flutter_application_1/Screens/Client_dashboard/Welcome/welcome_binding.dart';
import 'package:flutter_application_1/Screens/Client_dashboard/Welcome/welcome_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Profile/profile_binding.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Profile/profile_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Request/request_binding.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Request/request_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Subscription/subcription_binding.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Subscription/subcription_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Vehicles/vehicle_binding.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Vehicles/vehicle_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/View_vehicles/view_vehicle_biding.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/View_vehicles/view_vehicle_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Welcome/welcome_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Statistics/statastics_binding.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Statistics/statistics_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Upload/upload_binding.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Upload/upload_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Welcome/welcome_binding.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Driver_main_page.dart/main_binding.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Driver_main_page.dart/main_screen.dart';
import 'package:flutter_application_1/Screens/Login/login_binding.dart';
import 'package:flutter_application_1/Screens/Login/login_screen.dart';

import 'package:flutter_application_1/Screens/SignUp/signup_binding.dart';
import 'package:flutter_application_1/Screens/SignUp/signup_screen.dart';
import 'package:flutter_application_1/Screens/Welcome/welcome_binding.dart';
import 'package:flutter_application_1/Screens/Welcome/welcome_screen.dart';
import 'package:get/get.dart';

class AppPages {
  static final pages = [
    GetPage(
        name: AppRoutes.welcome,
        page: () => const WelcomeScreen(),
        binding: WelcomeBinding()),
    GetPage(
        name: AppRoutes.signup,
        page: () => const SignUpPage(),
        binding: SignupBinding()),
    GetPage(
        name: AppRoutes.activation,
        page: () => const ActivationPage(),
        binding: ActivationBinding()),
    GetPage(
        name: AppRoutes.clientwelcome,
        page: () => const ClientHomePage(),
        binding: ClientWelcomeBinding()),
    GetPage(
        name: AppRoutes.driverwelcome,
        page: () => const DriverHomePage(),
        binding: DriverWelcomeBinding()),
    GetPage(
        name: AppRoutes.driverupload,
        page: () => const DriverUploadPage(),
        binding: DriverUploadBinding()),
    GetPage(
        name: AppRoutes.driverStats,
        page: () => const DriverDashboardPage(),
        binding: DriverDashboardBinding()),
    GetPage(
        name: AppRoutes.drivervehicle,
        page: () => const DriverVehiclePage(),
        binding: DriverVehicleBinding()),
        GetPage(
        name: AppRoutes.drivermain,
        page: () => const DriverMiainPage(),
        binding: DriverMainPageBinding()),
      GetPage(
        name: AppRoutes.viewvehicle,
        page: () => const ViewVehiclePage(),
        binding: ViewVehicleBinding()),
             GetPage(
        name: AppRoutes.login,
        page: () => const LoginPage(),
        binding: LoginBinding()),
            GetPage(
        name: AppRoutes.driverrequest,
        page: () =>  DriverRequestPage(),
        binding: DriverRequestBinding()),
          GetPage(
        name: AppRoutes.driversubscription,
        page: () =>  const DriverSubscriptionPage(),
        binding: DriverSubscriptionBinding()),
          GetPage(
        name: AppRoutes.driverprofile,
        page: () =>   DriverProfilePage(),
        binding: DriverProfileBinding()),
  ];
}
