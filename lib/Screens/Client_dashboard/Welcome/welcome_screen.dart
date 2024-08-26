import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/Map/map_api.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Client_dashboard/Welcome/welcome_ctrl.dart';
import 'package:get/get.dart';

class ClientHomePage extends StatelessWidget {
  const ClientHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: RideSelectionScreen(),
    );
  }
}

class RideSelectionScreen extends StatelessWidget {
  RideSelectionScreen({super.key});
  TokenController token = Get.put(TokenController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientWelcomeController>(
      builder: (controller) => PopScope(
        canPop: false,
        child: Scaffold(
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.pink,
                  ),
                  child: Text(
                    'Menu',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.person, color: Colors.pink),
                  title: Text('Profile', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Get.toNamed(AppRoutes.clientprofile);
                  },
                ),
                ListTile(
                  leading:
                      Icon(Icons.account_balance_wallet, color: Colors.pink),
                  title: Text('Wallet', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    Get.toNamed(AppRoutes.userwallet);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.pink),
                  title: Text('Logout', style: TextStyle(color: Colors.black)),
                  onTap: () {
                    showLogoutDialogue(context, controller);
                  },
                ),
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    MapScreen(),
                    Positioned(
                      top: 16,
                      right: 16,
                      child: GestureDetector(
                        onTap: () {
                          Get.toNamed(AppRoutes.clientprofile);
                        },
                        child: CircleAvatar(
                          radius: 24,
                          backgroundColor: Colors.pink,
                          child: Icon(Icons.person, color: Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 16,
                      left: 16,
                      child: Builder(builder: (context) {
                        return GestureDetector(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.pink,
                            child: Icon(Icons.menu, color: Colors.white),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Choose A Ride",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink),
                        ),
                        SizedBox(height: 20),
                        // Use Obx to reactively display ride options
                        Obx(() {
                          if (controller.rides.isEmpty) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.pink,
                              ),
                            );
                          }
                          return Column(
                            children: controller.rides.entries.map((entry) {
                              return GestureDetector(
                                onTap: () {
                                  showLoadingDialog(context);
                                },
                                child: RideOption(
                                  rideType: entry.key,
                                  description: entry.value,
                                  price:
                                      "0 FCFA", // You can adjust this if needed
                                  icon: Icons
                                      .directions_car, // You can change this based on ride type
                                ),
                              );
                            }).toList(),
                          );
                        }),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            PaymentOption(
                              label: "With Wallet",
                              icon: Icons.account_balance_wallet,
                            ),
                            PaymentOption(
                              label: "With Cash",
                              icon: Icons.money,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.pink,
              ),
              SizedBox(height: 16),
              Text('Looking for a driver please wait 5 seconds.....'),
              SizedBox(height: 16),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss dialog
              },
              child:
                  Text('Cancel Request', style: TextStyle(color: Colors.pink)),
            ),
          ],
        );
      },
    );

    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pop();
      Get.toNamed(AppRoutes.reservationscreen);
    });
  }
}

class RideOption extends StatelessWidget {
  final String rideType;
  final String description;
  final String price;
  final IconData icon;

  const RideOption({
    Key? key,
    required this.rideType,
    required this.description,
    required this.price,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.pink, size: 30),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      rideType,
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.pink),
                    ),
                    Text(description, style: TextStyle(color: Colors.black54)),
                  ],
                ),
              ],
            ),
            Text(price,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.pink)),
          ],
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String label;
  final IconData icon;

  const PaymentOption({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    );
  }
}

void showLogoutDialogue(
    BuildContext context, ClientWelcomeController controller) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: Colors.pink,
            ),
            SizedBox(height: 16),
            Text(
              'Logout Confirmation',
              style: TextStyle(color: Colors.pink, fontSize: 20),
            ),
            SizedBox(height: 16),
            Text("Are your sure to quit this page? ")
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Dismiss dialog
            },
            child: Text('Cancel', style: TextStyle(color: Colors.pink)),
          ),
          TextButton(
            onPressed: () {
              controller.removeTokenFromLocalStorage();
              Get.toNamed(AppRoutes.welcome);
            },
            child: Text('yes', style: TextStyle(color: Colors.pink)),
          ),
        ],
      );
    },
  );
}
