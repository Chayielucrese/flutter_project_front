import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class LoginController extends AppController {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<http.Response> _role() async {
    final response = await http.get(Uri.parse("${Config.apiUrl}/getRoles"));
    return response;
  }

  Future<http.Response> _loginUser(String email, String password) async {
    final response = await http.post(
      Uri.parse("${Config.apiUrl}/userLogin"),
      body: {
        "email": email,
        "password": password,
      },
    );
    return response;
  }

  Future<void> _loginToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    bool result = await pref.setString("token", token);
    print("Token stored: $result"); // Check if token storage was successful
  }

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text;

      try {
        final response = await _loginUser(email, password);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseJson = json.decode(response.body);
          String? token = responseJson['token']['token'];

          if (token != null) {
            print("token :$token");
            _loginToken(token);

            // Decode the token
            Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
            int? userRole = decodedToken['Role'];

            print("my decodedToken role: $userRole");
            final res = await _role();
            print("Raw response body: ${res.body}");
            if (res.statusCode == 200) {
              Map<String, dynamic> response = json.decode(res.body);
              List<dynamic> rolesList = response['success'];
              Map<String, int>? roles;
              roles = {for (var role in rolesList) role['name']: role['id']};
              roles.forEach((name, id) async {
                print("${roles?['name']}: role name");
                if (name == "client" && userRole == id) {
                  Get.toNamed(AppRoutes.clientwelcome);
                }
                if (name == "driver" && userRole == id) {
                  print("${name},  ${userRole}");
                  Get.toNamed(AppRoutes.driverwelcome);
                }
              });
              formKey.currentState!.reset();
            } else {
              print("Token is null, cannot decode.");
            }
          }
        }
      } catch (e) {
        print("Error occurred during registration: $e");
      } // Handle the response, e.g., navigate to another screen, show an error, etc.
    }
  }

  // Future<Object?> _getAllRoles() async {
  //   try {
  //     final res = await _role();
  //     print("Raw response body: ${res.body}");
  //     if (res.statusCode == 200) {
  //       Map<String, dynamic> response = json.decode(res.body);
  //       List<dynamic> rolesList = response['success'];

  //       roles = {for (var role in rolesList) role['name']: role['id']};
  //       update();
  //     } else {
  //       print("fail to get role: ${res.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error occurred while fetching roles: $e");
  //   }
  //   return null;
  // }

  Future<Map<String, String>> _getUserParams() async {
    final pref = await SharedPreferences.getInstance();
    String? jsonString = pref.getString('userAttributes');
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = jsonDecode(jsonString);
      return jsonMap.map((key, value) => MapEntry(key, value.toString()));
    }
    return {};
  }
}
