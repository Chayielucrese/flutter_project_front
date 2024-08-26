import 'package:flutter/material.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Welcome/welcome_ctrl.dart';
import 'package:get/get.dart';

class DriverHomePage extends StatelessWidget {
  const DriverHomePage({super.key});


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<DriverWelcomeController>(
        builder: (controller) => Scaffold(
          backgroundColor: Colors.black,
          body: Stack(
            children: [
              // Full-screen background image
              Positioned.fill(
                child: Image.asset(
                  'Assets/city_driver.png', // Your background image here
                  fit: BoxFit.cover,
                ),
              ),
              // Dark overlay
              Positioned.fill(
                child: Container(
                  color: Colors.black.withOpacity(0.3), // Dark overlay
                ),
              ),
              // Main content
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text(
                  //   'WELCOME TO THE DRIVER APPLICATION.',
                  //   style: TextStyle(
                  //     color: Colors.black,
                  //     fontWeight: FontWeight.bold,
                  //     fontSize: 30,
                  //   ),
                  //   textAlign: TextAlign.center,
                  // ),
                  SizedBox(height: 50),
                  Text(
                    'Driver Dashboard loading...',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.white.withOpacity(0.3),
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.yellow),
                      minHeight: 8,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
