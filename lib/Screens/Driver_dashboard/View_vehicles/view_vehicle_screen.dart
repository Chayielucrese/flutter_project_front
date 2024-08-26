import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/BottomNavigator.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Request/Request_tabview_pages/Instant_service_request/instant_service_request_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/View_vehicles/Vehicle_tabview/document_screen.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/View_vehicles/view_vehicle_ctrl.dart';
import 'package:get/get.dart';

class ViewVehiclePage extends StatelessWidget {
  const ViewVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.find<ViewVehicleController>().fetchVehicles();
        return true;
      },
      child: GetBuilder<ViewVehicleController>(
        builder: (controller) => DefaultTabController(
          length: 2,
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              automaticallyImplyLeading: false, // Remove the back button
              title: Text(
                "Your Vehicles",
                style: TextStyle(
                  color: Colors.pink,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                if (controller.vehicles
                    .isEmpty) // Show Add button only if there are no vehicles
                  IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Get.toNamed(AppRoutes.drivervehicle)?.then((_) {
                        controller
                            .fetchVehicles(); // Refresh the list after returning
                      });
                    },
                  ),
              ],
              backgroundColor: Colors.white, // Set background color if needed
              bottom: TabBar(
                tabs: [
                  Tab(text: 'Details'),
                  Tab(text: 'Documents'),
                ],
                indicatorColor: Colors.pink,
                labelColor: Colors.pink,
                unselectedLabelColor: Colors.grey,
              ),
            ),
            bottomNavigationBar: buildBottomNavigation(AppRoutes.viewvehicle),
         body: TabBarView(
  children: [
    controller.vehicles.isEmpty
      ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'Assets/Front car-rafiki.png',
                width: 300,
                height: 200,
              ),
              SizedBox(height: 20),
              Text(
                'No vehicles found',
                style: TextStyle(fontSize: 18, color: Colors.black),
              ),
            ],
          ),
        )
      : ListView.builder(
          itemCount: controller.vehicles.length,
          itemBuilder: (context, index) {
            final vehicle = controller.vehicles[index];
            return Card(
              elevation: 1,
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Padding(
                padding: const EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 250,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              vehicle['vehicleType'] == 'car'
                                  ? 'Assets/Front car-pana.png'
                                  : 'Assets/motoride.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '(${vehicle['vehicleMark']}) ${vehicle['vehicleModel']}',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Plate Number: ${vehicle['plateNumber']}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Vehicle Type: ${vehicle['vehicleType']}',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          _showDeleteConfirmationDialog(context, vehicle, controller);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
    // Vehicle Documents Tab
    const DriverDocumentsPage(), // Ensure DriverDocumentsPage is properly initialized here
  ],
),

          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context,
      Map<String, dynamic> vehicle, ViewVehicleController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Confirm Deletion',
            style: TextStyle(
              color: Colors.pink,
            ),
          ),
          content: Text('Are you sure you want to delete this vehicle?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                controller.deleteVehicle(vehicle['id']);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
