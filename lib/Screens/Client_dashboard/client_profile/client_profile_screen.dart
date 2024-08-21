import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/TextField.dart';
import 'package:flutter_application_1/Controller/local_storage.retrieve.dart';
import 'package:flutter_application_1/Screens/Client_dashboard/client_profile/client_profile_ctrl.dart';
import 'package:get/get.dart';

void main() {
  runApp(ClientProfileApp());
}

class ClientProfileApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Client Profile',
      theme: ThemeData(
        primaryColor: Colors.pink,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: ClientProfilePage(),
    );
  }
}

class ClientProfilePage extends StatelessWidget {
  ClientProfilePage({super.key});
  LocalData data = Get.put(LocalData());

  void editProfile(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return GetBuilder<ClientProfileController>(
          builder: (controller) => AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              'Edit Profile',
              style: TextStyle(color: Colors.pink),
            ),
            content: SingleChildScrollView(
              child: Column(
                key: controller.formKey,
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 10.0),
                  appTextField(
                      controller: controller.passwordController,
                      obscureText: true,
                      icon: Icons.password,
                      labelText: "Password"),
                  SizedBox(height: 10.0),
                  appTextField(
                      controller: controller.emailController,
                      labelText: "Email",
                      icon: Icons.email_rounded),
                  SizedBox(height: 10.0),
                  appTextField(
                      controller: controller.cityController,
                      labelText: "City",
                      icon: Icons.location_city),
                  SizedBox(height: 10.0),
                  appTextField(
                      controller: controller.phoneController,
                      labelText: "phone",
                      icon: Icons.phone),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel', style: TextStyle(color: Colors.pink)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('Save', style: TextStyle(color: Colors.pink)),
                onPressed: () {
                  controller.submitForm(context);
                  controller.getTokenAndLoadUserProfile();
                  
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ClientProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Profile Info',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.pink,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: controller.profileImage != null
                        ? NetworkImage(controller.profileImage)
                        : AssetImage('Assets/Profile pic-cuate.png'),
                    backgroundColor: Colors.pink,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: IconButton(
                      icon:
                          Icon(Icons.camera_alt, color: Colors.white, size: 30),
                      onPressed: () {
                        controller.pickImage(0);
                      },
                      color: Colors.pink,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),
              buildProfileRow("Name", controller.name),
              SizedBox(height: 16),
              buildProfileRow("phone", controller.phone),
              SizedBox(height: 16),
              buildProfileRow("Email", controller.email),
              SizedBox(height: 16),
              buildProfileRow("City", controller.city),
              SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pink,
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        8.0), // Rounded corners for the button
                  ),
                ),
                onPressed: () {
                  editProfile(context);
                },
                child: Text('Edit Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              '$label:',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.pink),
            ),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }
}
