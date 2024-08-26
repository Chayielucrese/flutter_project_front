import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UserWalletController extends AppController {
  TokenController tokenController = Get.put(TokenController());
  final passwordController = TextEditingController();
  String? token;
  @override
  void onInit() {
    super.onInit();
    loadToken();
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

  Future<http.Response> createWallet(String password, String newToken) async {
    return await http.post(Uri.parse("${Config.apiUrl}/createWallet"),
        headers: {
          'Authorization': 'Bearer $newToken',
          'Content-Type': 'application/json',
        },
        body: json.encode({"password": password}));
  }

  String? mytoken;
  Future<void> submitForm() async {
    mytoken = await tokenController.retriveToken();
    String password = passwordController.text;

    try {
      if (password != null) {
        print("my pwd: $password");
        final response = await createWallet(password, token!);

        if (response.statusCode == 201 || response.statusCode == 200) {
          final successResponse = json.decode(response.body);
          passwordController.clear();
          update();

          alertSuccess("${successResponse['msg']}");
          Get.toNamed(AppRoutes.walletrecharge);
        } else if (response.statusCode == 409) {
          Get.toNamed(AppRoutes.walletrecharge);
               passwordController.clear();
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
