import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SignupController extends GetxController {
    final formKey = GlobalKey<FormState>();
  // Define controllers
  final name = TextEditingController();
  final surname = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final phone = TextEditingController();
  final city = TextEditingController();
  final agencyAddress = TextEditingController();
  final agencyName = TextEditingController();
  final agencyLicense = TextEditingController();
  final submitAgency = TextEditingController();
  final companyRegistrationNumber = TextEditingController();
  final companyName = TextEditingController();
  final companyAddress = TextEditingController();
  final companyOwner = TextEditingController();
  final companyEmailAddress = TextEditingController();
  final companyBusStation = TextEditingController();


  var selectedRole = 'client';
  var roles = <String, int>{}.obs;

  @override
  void onClose() {
    // Dispose controllers when the controller is closed
    name.dispose();
    surname.dispose();
    email.dispose();
    password.dispose();
    phone.dispose();
    city.dispose();
    agencyAddress.dispose();
    agencyLicense.dispose();
    agencyName.dispose();
    submitAgency.dispose();
    companyRegistrationNumber.dispose();
    companyName.dispose();
    companyAddress.dispose();
    companyOwner.dispose();
    companyEmailAddress.dispose();
    companyBusStation.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    super.onInit();
    getAllRoles();
  }

  Future<void> getAllRoles() async {
    try {
      final res = await role();
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        final rolesList = response['success'] as List<dynamic>;

        roles.assignAll({for (var role in rolesList) role['name']: role['id']});
      } else {
        print("Failed to get roles: ${res.statusCode}");
      }
    } catch (e) {
      print("Error occurred while fetching roles: $e");
    }
  }

  Future<http.Response> role() async {
    return await http.get(Uri.parse("${Config.apiUrl}/getRoles"));
  }

 Future<void> submitForm() async {

  if (formKey.currentState != null && formKey.currentState!.validate()) {
   
    String name = this.name.text;
    String surname = this.surname.text;
    String email = this.email.text.trim();
    String phone = this.phone.text;
    String password = this.password.text;
    String city = this.city.text;
    print("$name, $surname, $email, $password, $phone, $city");
    int role = roles[selectedRole] ?? 0;

    try {
   
      final response = await createUser(name, surname, email, password, phone, city, role);
   print("hello");
      if (response.statusCode == 201) {
        print("User created successfully.");

        _setUserParams(name, surname, role.toString(), email, password, city, phone);

        roles.forEach((name, id) {
          if (name == selectedRole) {
            role = id;
          }
        });

        Get.offNamed('/activate');
        formKey.currentState!.reset();
      } else {
        final errorResponse = json.decode(response.body);
        Get.snackbar('Registration failed', errorResponse['msg'],
            backgroundColor: Colors.pink, colorText: Colors.white);
      }
    } catch (e) {
      print("Error occurred during registration: $e");
    }
  } else {
    print("Form is invalid or formKey.currentState is null.");
  }
}


  Future<http.Response> createUser(String name, String surname, String email, String password, String phone, String city, int role) async {
    return await http.post(
      Uri.parse("${Config.apiUrl}/createUser"),
      body: {
        "name": name,
        "surname": surname,
        "email": email,
        "password": password,
        "phone": phone,
        "city": city,
        "role": role.toString(),
      },
    );
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    final cleanedValue = value.trim();
    final phonePattern = RegExp(r'^[6-9]\d{8}$');
    if (!phonePattern.hasMatch(cleanedValue)) {
      return 'Enter a valid phone number';
    }
    return null;
  }

  String? validatePassword(String? value) {
    final cleanValue = value?.trim();
    if (cleanValue!.length <= 8) {
      return "Must be 8-characters long";
    }
    return null;
  }

  Future<void> updateSelectedRole(String newValue) async {
    selectedRole = newValue;
    update();
  }

  Future<void> _setUserParams(String name, String surname, String role, String email, String password, String city, String phone) async {
    final pref = await SharedPreferences.getInstance();
    final attributes = {
      'name': name,
      'surname': surname,
      'email': email,
      'password': password,
      'city': city,
      'phone': phone,
      'role': role
    };
    final jsonString = jsonEncode(attributes);
    await pref.setString('userAttributes', jsonString);
  }

  Future<void> uploadCheck() async {
    final role = roles[selectedRole] ?? 0;
    if (formKey.currentState!.validate()) {
      await _setUserParams(name.text, surname.text, role.toString(), email.text.trim(), password.text, city.text, phone.text);
      Get.toNamed(AppRoutes.driverupload);
    } else {
      alertError("Fill in required fields properly");
    }
  }

  void alertError(String message) {
    Get.snackbar("Error", message, colorText: Colors.white, backgroundColor: Colors.pink);
  }
}
