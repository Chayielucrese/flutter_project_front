import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Driver_main_page.dart/main_ctrl.dart';
import 'package:get/get.dart';

void main() {
  runApp(const DriverMiainPage());
}

class DriverMiainPage extends StatelessWidget {
  const DriverMiainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Driver Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const DriverStatsPage(),
    );
  }
}

class DriverStatsPage extends StatelessWidget {
  const DriverStatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverMainPageController>(
      builder: (controller) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title:
              Text('Driver Dashboard', style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.pink,
        ),
        body: IndexedStack(
            index: controller.selectedIndex, children: controller.pages),
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard),
              label: 'Dashboard',
              backgroundColor: Colors.pink,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_car),
              label: 'Vehicle',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.request_page),
              label: 'Request',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.subscriptions),
              label: 'Subscription',
            ),
          ],
          currentIndex: controller.selectedIndex, // Update this index as needed
          onTap: controller.onItemTapped,
        ),
      ),
    );
  }
}
