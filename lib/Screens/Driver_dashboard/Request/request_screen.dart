import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/BottomNavigator.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Request/Request_tabview_pages/Advance_service_request/advance_request_screen.dart';

import 'package:flutter_application_1/Screens/Driver_dashboard/Request/Request_tabview_pages/Instant_service_request/instant_service_request_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Request/Request_tabview_pages/Request_historry.dart/history_screen.dart';

class DriverRequestPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length:3 ,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Request Information', style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.pink,
            iconTheme: IconThemeData(
            color: Colors.white, // Set the back arrow color to white
          ),
          bottom: const TabBar(
          tabs: [
              Tab(child: Text('Instant Resquest ', style: TextStyle(color: Colors.white ))),
              Tab(child: Text('Advanced Requests', style: TextStyle(color: Colors.white))),
              Tab(child: Text('Ride History', style: TextStyle(color: Colors.white))),
          
            ],
          ),
        ),
        bottomNavigationBar: buildBottomNavigation(AppRoutes.driverrequest),
        body:  TabBarView(
          children: [
            
            const Center(child: InstanceServiceRequestPage()),
            Center(child: AdvancedServiceRequestPage()),
            Center(child: RequestHistoryPage()),
         
          ],
        ),
      ),
    );
  }
}