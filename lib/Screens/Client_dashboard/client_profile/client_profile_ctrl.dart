import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Upload/upload_ctrl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class ClientProfileController extends AppController {
  final formKey = GlobalKey<FormState>();
  TokenController token = Get.put(TokenController());
  DriverUploadController uploadController = Get.put(DriverUploadController());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  File? image;

  @override
  void onInit() {
    super.onInit();
    getTokenAndLoadUserProfile();
  }

  @override
  void onClose() {
    passwordController.dispose();
    emailController.dispose();
    cityController.dispose();
    phoneController.dispose();
  }

  void getTokenAndLoadUserProfile() async {
    String? tokens = await token.retriveToken();
    if (tokens != null) {
      userProfile(tokens);
    } else {
      print("No token found");
      // Handle the case where the token is null
    }
  }
String name = "";
String email = "";
String city = "";
String phone = "";
String profileImage = "";


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
        profileImage = response['msg']['profileImage'];
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

  Future<void> pickImage(int index) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    File selectedFile = File(pickedFile!.path);

    if (index == 0) {
      image = selectedFile;
    }

    update();
  }

  Future<http.Response> editProfile(String email, String phone, String city,
      String password, String base64ProfileImage) async {
    final tok = await token.retriveToken();
    return await http.put(
      Uri.parse("${Config.apiUrl}/editProfile"),
      headers: {
        'Authorization': 'Bearer $tok',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'password': password,
        'email': email,
        'profileImage': base64ProfileImage,
        'city': city,
        'phone': phone,
      }),
    );
  }

  Future<void> submitForm(BuildContext context) async {
    String email = emailController.text;
    String password = passwordController.text;
    String phone = phoneController.text;
    String city = cityController.text;
    String base64ProfileImage = await uploadController.getBase64(image!);
    try {
      if (email != null ||
          password != null ||
          phone != null ||
          city != null ||
          base64ProfileImage != null) {
        print("$base64ProfileImage");
        final response =
            await editProfile(email, phone, city, password, base64ProfileImage);
        final responseJson = json.decode(response.body);
        if (response.statusCode == 200) {
          Navigator.of(context).pop();
          alertSuccess('${responseJson['msg']}');
        } else {
          alertError("${responseJson['msg']}");
        }
      } else {
        alertError("You are required to fill atleast a field");
      }
    } catch (e) {
      print("Error occurred during profile editing: $e");
    }
  }
}
