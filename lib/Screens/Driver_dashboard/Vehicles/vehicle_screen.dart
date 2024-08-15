import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/mypopup.dart'; // Import your MyPopupComponent
import 'package:flutter_application_1/Components/vehicleTextFiellds.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Vehicles/vehicle_ctrl.dart';
import 'package:get/get.dart';

class DriverVehiclePage extends StatelessWidget {
  const DriverVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didpop) {
        if (didpop) {
          return;
        } else {
          Get.toNamed(AppRoutes.viewvehicle);
        }
      }),
      child: GetBuilder<DriverVehicleController>(
        builder: (controller) => Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.pink,
            automaticallyImplyLeading: false,
            title: Text(
              "Add Vehicle",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Upper div with background image and opacity
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'Assets/city_driver.png'), // Replace with your image path
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black
                          .withOpacity(0.5), // Black overlay with opacity
                    ),
                  ),
                ),

                // Lower div with form elements
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Select Vehicle Type',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          VehicleOption(
                            label: 'Car',
                            value: 'car',
                            groupValue: controller.selectedVehicleType,
                            onChanged: (value) {
                              controller.updateValue(value!);
                            },
                          ),
                          VehicleOption(
                            label: 'Motorbike',
                            value: 'motobike',
                            groupValue: controller.selectedVehicleType,
                            onChanged: (value) {
                              controller.updateValue(value!);
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 0),
                      Text(
                        'Vehicle Details',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink,
                        ),
                      ),
                      SizedBox(height: 10),
                      Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            buildTextField(
                              controller: controller.plateNumberController,
                              labelText: 'Number Plating e.g CE-123-AM',
                              icon: Icons.car_crash_sharp,
                              isPlateNumber: true,
                            ),
                            SizedBox(height: 10),
                            buildTextField(
                              controller: controller.modelController,
                              labelText: "Model",
                              icon: Icons.model_training_outlined,
                            ),
                            SizedBox(height: 10),
                            buildTextField(
                              controller: controller.vehicleMarkController,
                              labelText: 'Brand',
                              icon: Icons.car_repair_outlined,
                              isPlateNumber: true,
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () async {
                                if (controller.formKey.currentState!
                                    .validate()) {
                                  // Show the popup and wait for it to complete
                                  await showPopup(
                                    context,
                                    (index, pickedFile) {
                                      if (pickedFile != null) {
                                        switch (index) {
                                          case 0:
                                            controller.vehicleInsurCert =
                                                pickedFile;
                                            break;
                                          case 1:
                                            controller.vehicleRegCert =
                                                pickedFile;
                                            break;
                                          case 2:
                                            controller.vehicleRoadWthRep =
                                                pickedFile;
                                            break;
                                          case 3:
                                            controller.vehicleSaleCert =
                                                pickedFile;
                                            break;
                                        }
                                        controller.update();
                                        print('Document Index: $index');
                                        print(
                                            'Selected File: ${pickedFile.path},hello: $pickedFile');
                                      }
                                    },
                                  );

                                  await controller.submitForm();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.pink,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 60.0, vertical: 16.0),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                              child: Text(
                                'Add Vehicle',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void main() {
    runApp(const MaterialApp(
      home: DriverVehiclePage(),
    ));
  }
}

List<String> vehicleMarks = [
  'Toyota',
  'Honda',
  'Ford',
  'Chevrolet',
  'Nissan',
  'BMW',
  'Mercedes-Benz',
  'Audi',
  'Hyundai',
  'Kia',
  'Volkswagen',
  'Mazda',
  'Tesla',
  'Subaru',
  'Lexus',
  'Jaguar',
  'Land Rover',
  'Volvo',
  'Porsche',
  'Ferrari',
  'Lamborghini',
  'Mitsubishi',
  'Peugeot',
  'Renault',
  'Fiat',
  'Alfa Romeo',
  'Dodge',
  'Jeep',
  'Cadillac',
  'Acura',
  'Infiniti',
  'Lincoln'
];
