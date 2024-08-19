import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Upload/upload_ctrl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriverProfileController extends AppController {
  TokenController tokenController = Get.put(TokenController());
  DriverUploadController uploadController = Get.put(DriverUploadController());

  
  final passwordController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  
  final formKey = GlobalKey<FormState>();

  File? profileImage;
  String? token;

  @override
  void onInit() {
    super.onInit();
    loadToken();
    update();
  }

  Future<void> loadToken() async {
    token = await _getToken();
    print("Loaded token: $token");
  }



  Future<String?> _getToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print("Retrieved token: $token");
    return token;
  }

  Future<void> pickImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File selectedFile = File(pickedFile.path);

      if (index == 0) {
        profileImage = selectedFile;
      }
    }
    update();
  }

  Future<http.Response> editProfile(String password, String email,
      String base64ProfileImage, String phone) async {
    if (token == null) {
      await loadToken();
    }

    final response = await http.post(
      Uri.parse('${Config.apiUrl}/editProfile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'password': password,
        'email': email,
        'profileImage': base64ProfileImage,
        'phone': phone,
      }),
    );

    return response;
  }

  Future<void> submitForm() async {
  if (formKey.currentState!.validate()) {
    String email = emailController.text.trim();
    String password = passwordController.text;
    String phone = phoneController.text;

   
    String base64ProfileImage = await uploadController.getBase64(profileImage!);

    try {
      final response = await editProfile(password, email, base64ProfileImage, phone);

      if (response.statusCode == 201 || response.statusCode == 200) {
        final successResponse = json.decode(response.body);
        formKey.currentState!.reset();
        profileImage = null;
        emailController.clear();
        phoneController.clear();
        update();

        alertSuccess("${successResponse['msg']}");
        Get.toNamed(AppRoutes.driverStats);
      } else {
        final errorResponse = json.decode(response.body);
        alertError("${errorResponse['msg']}");
      }
    } catch (e) {
      print("Error occurred: $e");
      alertError("An error occurred. Please try again later.");
    }
  }
}
}
