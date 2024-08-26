import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/BottomNavigator.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Profile/profile_ctrl.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Statistics/statistics_ctrl.dart';
import 'package:get/get.dart';

class DriverDashboardPage extends StatelessWidget {
   DriverDashboardPage({super.key});
DriverProfileController userName = Get.put(DriverProfileController());

  // Manage the state here

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: GetBuilder<DriverDashboardController>(
        builder: (controller) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.pink,
            title: Text('Hello ${userName.name}!', style: TextStyle(color: Colors.white, fontSize: 17)),
            leading: IconButton(
              iconSize: 30,
              icon: CircleAvatar(
                backgroundImage:NetworkImage(userName.profilePicture),
                // Your profile image here
              ),
              onPressed: () {
                // Handle profile image click
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.edit, color: Colors.white),
                onPressed: () {
                 Get.toNamed(AppRoutes.driverprofile);
                },
              ),
              IconButton(
              icon: Icon(Icons.logout, color: Colors.white),
              onPressed: () {
              showLogoutDialogue(context, controller);
              },
            ),
            ],
          ),
          bottomNavigationBar: buildBottomNavigation(AppRoutes.driverStats),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  // Transparent red box message
                  Visibility(
                    visible: !controller.isDocumentVerified,
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      margin: const EdgeInsets.only(bottom: 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(color: Colors.red, width: 1.0),
                      ),
                      child: Text(
                        'You cannot access some functionalities until your documents are verified.',
                        style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: DashboardCard(
                                title: 'Number of Vehicles',
                                
                                value:"0",
                                icon: Icons.directions_car,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: DashboardCard(
                                title: 'Number of Requests',
                                value: '0',
                                icon: Icons.receipt_long,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: DashboardCard(
                                title: 'Accepted Requests',
                                value: '0',
                                icon: Icons.check_circle,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: DashboardCard(
                                title: 'Rejected Requests',
                                value: '0',
                                icon: Icons.cancel,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.0), // Space between rows
                        // Document and Account Status Row
                        Row(
                          children: [
                            Expanded(
                              child: DashboardCard(
                                title: 'Document Status',
                                value: 'Unverified',
                                icon: Icons.error,
                                color: Colors
                                    .red, // Set color to red for unverified status
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Expanded(
                              child: DashboardCard(
                                title: 'Account Status',
                                value: 'Pending...',
                                icon: Icons.account_circle,
                                color: Colors
                                    .green, // Set color to green for active status
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0), // Space between containers
                  // Second Container with Image
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      // borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(8.0), // Match border radius
                      child: Image.asset(
                        'Assets/city_driver.png', // Replace with your image path
                        fit: BoxFit.cover,
                        width: double.infinity, // Make image occupy full width
                        height: 200.0, // Adjust height as needed
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}


class DocumentCheck extends StatelessWidget {
  final bool isDocumentVerified;

  DocumentCheck({required this.isDocumentVerified}); // Receive parameter

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Visibility(
              visible: !isDocumentVerified,
              child: Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(bottom: 16.0),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.red, width: 1.0),
                ),
                child: Text(
                  'You cannot access some functionalities until your documents are verified.',
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
            // The rest of your DashboardPage content
          ],
        ),
      ),
    );
  }
}

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  
  final IconData icon;
  final Color color; // Added color parameter

  DashboardCard(
      {required this.title,
      required this.value,
      required this.icon,
      this.color = Colors.pink});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 18.0), // Use color parameter
            SizedBox(height: 4.0),
            Text(
              title,
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
            SizedBox(height: 4.0),
            Text(
              value,
              style: TextStyle(
                  fontSize: 18.0, fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

void showLogoutDialogue(
    BuildContext context, DriverDashboardController controller) {
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

class InfoBox extends StatelessWidget {
  final String title;
  final double progress; // Progress value for the circular indicator
  final Color progressColor; // Color for the progress indicator

  InfoBox({
    required this.title,
    required this.progress,
    this.progressColor = Colors.pink, // Default color
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: progress, // Set progress value (0.0 to 1.0)
            strokeWidth: 8.0, // Thickness of the progress indicator
            backgroundColor: Colors.grey[200], // Background color
            valueColor:
                AlwaysStoppedAnimation<Color>(progressColor), // Progress color
          ),
          SizedBox(height: 10.0),
          Text(
            title,
            style: TextStyle(fontSize: 14.0, color: Colors.black),
          ),
          SizedBox(height: 5.0),
          Text(
            '${(progress * 100).toStringAsFixed(0)}%', // Show percentage
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
