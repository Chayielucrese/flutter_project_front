import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

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

  void submitForm() async {
    if (formKey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text;

      try {
        final response = await _loginUser(email, password);
        if (response.statusCode == 200 || response.statusCode == 201) {
          final responseJson = json.decode(response.body);
          _loginToken(responseJson['token']['token']);

          await _getAllRoles();
          String? userRole = await _getUserRole();
          print("userRole: ${userRole}");

          roles?.forEach((name, id) async {
            if (name == "client" && int.parse(userRole) == id) {
              Get.toNamed(AppRoutes.clientwelcome);
            } 
             if (name == "driver" && int.tryParse(userRole) == id) {
              print("${name},  ${userRole}");
              Get.toNamed(AppRoutes.driverwelcome);
            }
          });
          formKey.currentState!.reset();
        } else {
          final errorResponse = json.decode(response.body);
          print("Registration failed: ${errorResponse['msg']}");
          print(response.body);
          alertError("${errorResponse['msg']}");
        }
      } catch (e) {
        print("Error occurred during registration: $e");
      }
      // Handle the response, e.g., navigate to another screen, show an error, etc.
    }
  }

  Future<String> _getUserRole() async {
    Map<String, String> userParams = await _getUserParams();
    return userParams['role'] ?? 'Unknown';
  }

  Map<String, int>? roles;

  Future<Object?> _getAllRoles() async {
    try {
      final res = await _role();
      print("Raw response body: ${res.body}");
      if (res.statusCode == 200) {
        Map<String, dynamic> response = json.decode(res.body);
        List<dynamic> rolesList = response['success'];

        roles = {for (var role in rolesList) role['name']: role['id']};
        update();
      } else {
        print("fail to get role: ${res.statusCode}");
      }
    } catch (e) {
      print("Error occurred while fetching roles: $e");
    }
    return null;
  }

  Future<http.Response> _role() async {
    final response = await http.get(Uri.parse("${Config.apiUrl}/getRoles"));
    return response;
  }

  Future<void> _loginToken(String token) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString("token", token);
  }

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
