import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/SignUp/signup_controller.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ActivationController extends AppController {
  final SignupController signupController = Get.put(SignupController());

  String selectedRole = '';
  var roles = <String, int>{}.obs;

  final formKey = GlobalKey<FormState>();
  final List<TextEditingController> codeCollector =
      List.generate(5, (index) => TextEditingController());

  // sending request and fetching request

  Future<http.Response> _activateAccount(String code, String email) async {
    final response = await http.put(
      Uri.parse("${Config.apiUrl}/activateAccount"),
      body: {
        "code_send": code,
        "email": email,
       
      },
    );
    return response;
  }

  //verifying code
  void validateCode(BuildContext context) async {
    String code = codeCollector.map((controller) => controller.text).join();
    print("Collected code: $code"); // Debugging statement
    String? email = await getUserEmail();

    print("Retrieved email: $email"); // Debugging statement

    // Debugging statements
    print("Code: $code");
    print("Email: $email");

    if (code.length == 5) {
      print("Validating code and email..."); // Debugging statement
      final res = await _activateAccount(code, email);
      print("Response received"); // Debugging statement

      if (res.statusCode == 200) {
        // Handle successful activation
        print('Activation successful');
        final responseJson = json.decode(res.body);
         print("hey: ${responseJson}");
        setToken(responseJson['token']['token']);
     
       
        String? userRole = await getUserRole();
        print('userCurrentRole: $userRole $roles');
      signupController.roles.forEach((name, id) async {
          if (name == 'client' && int.parse(userRole) == id) {
           
            Get.toNamed(AppRoutes.clientwelcome);
          } else if (name == 'driver' && int.parse(userRole) == id) {
            Get.toNamed(AppRoutes.driverwelcome);
          }
        });
      } else {
        print("Activation failed with status code: ${res.statusCode}");
        final errorResponse = json.decode(res.body);
        print("Invalid code: ${res.body}, code: ${code}");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "${errorResponse['msg']}",
              style: TextStyle(fontSize: 18),
            ),
            backgroundColor: Colors.pink,
          ),
        );
      }
    } else {
      // Show an error message
      print('Invalid code or email');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Invalid code or email',
            style: TextStyle(fontSize: 18),
          ),
          backgroundColor: Colors.pink,
        ),
      );
    }
  }

// get user email
  Future<Map<String, String>> _getUserParams() async {
    final pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString('userAttributes');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }
    return {};
  }

  Future<String> getUserEmail() async {
    Map<String, String> userParams = await _getUserParams();
    return userParams['email'] ?? 'Unknown';
  }

  // get user role
  Future<String> getUserRole() async {
    Map<String, String> userParams = await _getUserParams();
    return userParams['role'] ?? 'Unknown';
  }

//setting token after a successful validation
  Future<void> setToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
  }
}
