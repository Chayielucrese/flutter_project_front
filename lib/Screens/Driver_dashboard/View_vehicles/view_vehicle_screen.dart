
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/BottomNavigator.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/View_vehicles/view_vehicle_ctrl.dart';
import 'package:get/get.dart';



class ViewVehiclePage extends StatelessWidget {
  const ViewVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didpop) {
        if (didpop) {
          return;
        }
      }),
      child: GetBuilder<ViewVehicleController>(
        builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false, // Remove the back button
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Your Vehicle",
                  style: TextStyle(color: Colors.pink, fontSize: 16, fontWeight: FontWeight.bold, ),
                ),
                IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      Get.toNamed(AppRoutes.drivervehicle);
                    }),
              ],
            ),
            backgroundColor: Colors.white, // Set background color if needed
          ),
          bottomNavigationBar: buildBottomNavigation(AppRoutes.viewvehicle),
          body: controller.vehicles.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'Assets/Front car-rafiki.png', // Update with the path to your image asset
                        width: 300,
                        height: 200,
                      ),
                      SizedBox(height: 20),
                      Text(
                        'No vehicle found',
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
                      color: Colors.white,
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 17),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(10),
                        title: Text(
                          '${vehicle['vehicleModel']} ${vehicle['vehicleType']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          'Plate Number: ${vehicle['plateNumber']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Delete Vehicle',
                                  style: TextStyle(color: Colors.pink),
                                ),
                                content: Text(
                                    'Are you sure you want to delete this vehicle?'),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('No',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      controller.deleteVehicle(vehicle['id']);
                                      controller.fetchVehicles();
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('Yes',
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }

   void main() {
    runApp(const MaterialApp(
      home: ViewVehiclePage(),
    ));
  }
}
