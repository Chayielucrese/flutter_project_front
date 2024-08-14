import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Upload/upload_ctrl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DriverVehicleController extends AppController {
  DriverUploadController uploadController = Get.put(DriverUploadController());

  final formKey = GlobalKey<FormState>();
  final plateNumberController = TextEditingController();
  final modelController = TextEditingController();
  final vehicleMarkController = TextEditingController();
  // File? vehicleRegCert;
  // File? vehicleSaleCert;
  // File? vehicleInsurCert;
  // File? vehicleRoadWthRep;

  String? selectedVehicleType;
  String? token;

  void dispose() {
    plateNumberController.dispose();
    modelController.dispose();
    super.dispose();
  }

  void initState() {
    super.onInit();
    _retrieveToken();
  }

  Future<void> updateValue(String value) async {
    selectedVehicleType = value;
    update();
  }

  Future<void> _retrieveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
    update();
  }


  Future<http.Response> _createVehicle(
      String vehicleModel,
      String? vehicleType,
      String plateNumber,
      String vehicleMark,
      // String vehicleRegCert,
      // String vehicleSaleCert,
      // String vehicleRoadWthRep,
      // String vehicleInsurCert
      ) async {
  
    final response = await http.post(
      Uri.parse('${Config.apiUrl}/addVehicle'),
      headers: {
        'Authorization': 'bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'vehicleType': vehicleType,
        'vehicleModel': vehicleModel,
        'plateNumber': plateNumber,
        'vehicleMark': vehicleMark,
        // 'vehicleRegistrationCertificate': vehicleRegCert,
        // 'vehicleInsuranceCertificate': vehicleInsurCert,
        // 'vehicleSalesCertificate': vehicleSaleCert,
        // 'vehicleRoadWorthinessReport': vehicleRoadWthRep
      }),
    );
    return response;
  }

  Future<void> submitForm() async {
    // if (vehicleInsurCert != null &&
    //     vehicleRoadWthRep != null &&
    //     vehicleRoadWthRep != null &&
    //     vehicleSaleCert != null) {
      if (formKey.currentState!.validate()) {
        String vehicleModel = modelController.text.toLowerCase();
        String? vehicleType = selectedVehicleType?.toLowerCase();
        String? vehicleMark = vehicleMarkController.text;
        String plateNumber = plateNumberController.text;
        // String base64VehicleInsurCert =
        //     await uploadController.getBase64(vehicleInsurCert!);
        // String base64VehicleRegCert =
        //     await uploadController.getBase64(vehicleRegCert!);
        // String base64VehicleSaleCert =
        //     await uploadController.getBase64(vehicleSaleCert!);
        // String base64VehicleRoadWthRep =
        //     await uploadController.getBase64(vehicleRoadWthRep!);

        try {
          final response = await _createVehicle(
              vehicleModel,
              vehicleType,
              plateNumber,
              vehicleMark);
              // base64VehicleRoadWthRep,
              // base64VehicleSaleCert,
              // base64VehicleRegCert,
              // base64VehicleInsurCert);
          print('vehicleModel:${vehicleModel}');
          print('vehicleType:${vehicleType}');
          print('plateNumber:${plateNumber}');
          // print("base64VehicleRegCert:${base64VehicleRegCert}");

          if (response.statusCode == 201 || response.statusCode == 200) {
            final successResponse = json.decode(response.body);
            formKey.currentState!.reset();
            Get.toNamed(AppRoutes.viewvehicle);
            selectedVehicleType = null;
            plateNumberController.clear();
            modelController.clear();
            update();

            alertSuccess("${successResponse['msg']}");

            Get.toNamed(AppRoutes.viewvehicle);
          } else {
            final errorResponse = json.decode(response.body);

            alertError(
              "${errorResponse['msg']}",
            );
          }
        } catch (e) {
          print("error occcured: ${e}");
          alertError("An error occurred. Please try again later.");
        }
      }
    }
  }

  

  String? validatePlateNumber(String plateNumber, String countryCode) {
    if (plateNumber.isEmpty) {
      return 'Plate number is required';
    }

    Map<String, RegExp> patterns = {
      'CM': RegExp(r'^[A-Z]{2}-\d{3}-[A-Z]{2}$'),
    };

    final pattern = patterns[countryCode];

    if (pattern == null) {
      return 'Unsupported country code';
    }

    if (!pattern.hasMatch(plateNumber)) {
      return 'Invalid plate number format for $countryCode';
    }

    return null;
  }

