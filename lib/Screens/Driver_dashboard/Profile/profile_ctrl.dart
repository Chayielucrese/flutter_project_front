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
  TokenController tokens = Get.put(TokenController());

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
    getTokenAndLoadUserProfile();
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

  void getTokenAndLoadUserProfile() async {
    String? myToken = await tokens.retriveToken();
    if (myToken != null) {
      userProfile(myToken);
      update();
    } else {
      print("No token found");
      // Handle the case where the token is null
    }
  }

  String name = "";
  String email = "";
  String city = "";
  String phone = "";
  String profilePicture = "";

  Future<void> userProfile(String newToken) async {
    try {
      final res = await getProfile(newToken);
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        print("${response['msg']}: user profile");

        name = response['msg']['name'];
        email = response['msg']['email'];
        city = response['msg']['city'];
        phone = response['msg']['phone'];
        profilePicture = response['msg']['profileImage'];
        update();
      } else {
        print("Failed to get profile: ${res.statusCode}");
      }
    } catch (e) {
      print("Error occurred while fetching profile: $e");
    }
  }

  Future<http.Response> getProfile(String newToken) async {
    return await http.get(
      Uri.parse("${Config.apiUrl}/getUserProfile"),
      headers: {
        'Authorization': 'Bearer $newToken',
        'Content-Type': 'application/json',
      },
    );
  }

  Future<void> submitForm() async {
    String email = emailController.text.trim();
    String password = passwordController.text;
    String phone = phoneController.text;

    String base64ProfileImage = await uploadController.getBase64(profileImage!);
    try {
      if (email != null ||
          password != null ||
          phone != null ||
          base64ProfileImage != null) {
        final response =
            await editProfile(password, email, base64ProfileImage, phone);

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
      } else {
        alertError("Fill atleast a field to proceed");
      }
    } catch (e) {
      print("Error occurred: $e");
      alertError("An error occurred. Please try again later.");
    }
  }
}

//get user profile
