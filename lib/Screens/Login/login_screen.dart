import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/TextField.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Login/Login_ctrl.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didpop) {
        if (didpop) {
          return;
        }
        Get.toNamed(AppRoutes.welcome);
      }),
      child: GetBuilder<LoginController>(
        builder: (controller) => Scaffold(
          body: Stack(
            children: [
              // Background image
              Positioned.fill(
                child: Image.asset(
                  'Assets/taxi.jpg', // Update with your image path
                  fit: BoxFit.cover,
                ),
              ),
              // Semi-transparent overlay
              Positioned.fill(
                child: Container(
                  color: Colors.black54
                      .withOpacity(0.8), // Semi-transparent black overlay
                ),
              ),
              // Centered content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Header with app name and login text
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 40.0),
                      child: Column(
                        children: [
                          Text(
                            'eTravel',
                            style: TextStyle(
                              fontSize: 40.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.pink,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Form section
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.formKey,
                          child: Container(
                            width: 320.0,
                            height: 290.0, // Adjust height as needed
                            padding: EdgeInsets.all(20.0),
                            margin: EdgeInsets.symmetric(
                                vertical:
                                    28.0), // Margin to space out from header
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black54, width: 1.0),
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners
                              color: Colors.white.withOpacity(
                                  0.9), // Semi-transparent white background
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                appTextField(
                                  labelText: 'Email',
                                  icon: Icons.email,
                                  controller: controller.emailController,
                                  isEmail: true,
                                ),
                                SizedBox(height: 10.0),
                                appTextField(
                                  labelText: 'Password',
                                  obscureText: true,
                                  icon: Icons.lock,
                                  controller: controller.passwordController,
                                ),
                                SizedBox(height: 20.0),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                      onPressed: controller.submitForm,
                                      child: Text(
                                        'Forgot Password?',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.black54),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: controller.submitForm,
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.0, vertical: 10.0),
                                        backgroundColor: Colors.pink,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              10.0), // Rounded corners
                                        ),
                                      ),
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Center(
                                      child: TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(
                                              context, '/signup');
                                        },
                                        child: Text(
                                          'Create an Account',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              color: Colors.pink),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
