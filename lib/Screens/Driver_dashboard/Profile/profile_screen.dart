import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/TextField.dart';
import 'package:flutter_application_1/Controller/local_storage.retrieve.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Profile/profile_ctrl.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class DriverProfilePage extends StatelessWidget {
  DriverProfilePage({super.key});
  final LocalData data = Get.put(LocalData());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DriverProfileController>(
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Edit Profile",
            style: TextStyle(
              color: Colors.pink,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Colors.white,
          iconTheme: const IconThemeData(color: Colors.pink),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile Image
              Center(
                child: GestureDetector(
                  onTap: () => controller.pickImage(0),
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: controller.profileImage != null
                        ? FileImage(controller.profileImage!)
                        : const AssetImage('Assets/Profile pic-cuate.png')
                            as ImageProvider,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Driver's Name
              FutureBuilder<String>(
                future: data.getUserName(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return Text(
                      snapshot.data ?? 'Unknown',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Driver's Email
                  FutureBuilder<String>(
                    future: data.getUserEmail(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data ?? 'johndoe@example.com',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        );
                      }
                    },
                  ),
                  FutureBuilder<String>(
                    key: controller.formKey,
                    future: data.getUserPhone(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else {
                        return Text(
                          snapshot.data ?? 'johndoe@example.com',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.grey,
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Driver Details
              appTextField(
                labelText: "Account Password",
                icon: Icons.password,
                controller: controller.passwordController,
              ),
              const SizedBox(height: 20),
              appTextField(
                labelText: "Phone",
                icon: Icons.phone,
                controller: controller.phoneController,
              ),
              const SizedBox(height: 20),
              appTextField(
                labelText: "Email",
                icon: Icons.email,
                controller: controller.emailController,
              ),
              const SizedBox(height: 40),

              // Save Profile Button
              ElevatedButton(
                onPressed: () {
                  controller.submitForm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text(
                  'Save Profile',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
