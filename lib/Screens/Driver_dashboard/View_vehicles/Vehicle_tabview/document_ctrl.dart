import 'dart:convert';

import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DriverVehicleDocumentController extends AppController {
  TokenController token = Get.put(TokenController());

  // void getTokenAndLoadUserDocuments() async {
  //   String? tokens = await token.retriveToken();
  //   if (tokens != null) {
  //     userDocuments(tokens);
  //   } else {
  //     print("No token found");
  //     // Handle the case where the token is null
  //   }
  // }

  String CNI = "";
  String vehiclePhoto = "";
  String drivingLicense = "";

  // Future<void> userDocuments(String newToken) async {
  //   try {
  //     final res = await getDocuments(newToken);
  //     if (res.statusCode == 200) {
  //       final response = json.decode(res.body);
  //       print("${response['msg']}: user profile");

  //       vehiclePhoto = response['msg']['vehiclePhoto'];
  //       CNI = response['msg']['CNI'];
  //       drivingLicense = response['msg']['drivingLicense'];


  //     } else {
  //       print("Failed to get userDocuments: ${res.statusCode}");
  //     }
  //   } catch (e) {
  //     print("Error occurred while fetching userDocuments: $e");
  //   }
  // }

  // Future<http.Response> getDocuments(String newToken) async {
  //   return await http.get(
  //     Uri.parse("${Config.apiUrl}/viewUploadedDocuments"),
  //     headers: {
  //       'Authorization': 'Bearer $newToken',
  //       'Content-Type': 'application/json',
  //     },
  //   );
  // }
}
