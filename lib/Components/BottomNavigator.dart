import 'package:flutter/material.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';


List<String> pages = [
  AppRoutes.driverStats,
  AppRoutes.viewvehicle,
  AppRoutes.driverrequest,
  AppRoutes.driversubscription,


];

Widget buildBottomNavigation(String goto) {
  int index = pages.indexOf(goto);
  return BottomNavigationBar(
    currentIndex: index < 0 ? 0 : index,
    onTap: (i) {
      Get.toNamed(pages[i]);
    },
    type: BottomNavigationBarType.fixed,
    backgroundColor: Colors.white,
    iconSize: 30,
    showSelectedLabels: true,
    showUnselectedLabels: false,
    selectedItemColor: const Color(0xFFF5365C),
    unselectedItemColor: Colors.grey,
    items: const [
      BottomNavigationBarItem(
        icon: Icon(Icons.dashboard),
        label: "Dashboard",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.directions_car),
        label: "Vehicle",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.request_page),
        label: "Request",
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.subscriptions),
        label: "Subscription",
      ),
   
    ],
  );
}
