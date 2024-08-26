import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Statistics/statistics_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Vehicles/vehicle_screen.dart';

class DriverMainPageController extends AppController {
  bool isDocumentVerified = false;
  int selectedIndex = 0;

  final List<Widget> pages = [
     DriverDashboardPage(),
    const DriverVehiclePage(),
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    update(); // This will ensure the UI is refreshed
  }
}
