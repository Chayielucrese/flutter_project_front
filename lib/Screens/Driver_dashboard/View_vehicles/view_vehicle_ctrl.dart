import 'dart:convert';

import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewVehicleController extends AppController {
  List<dynamic> vehicles = [];
  String? token;

  void initState() {
    super.onInit();
    retrieveToken().then((_) => fetchVehicles());
  }

  Future<void> retrieveToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    token = prefs.getString('token');
    update();
  }

  Future<void> fetchVehicles() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.apiUrl}/viewAllVehicles'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        List<dynamic> vehiclesList = responseJson['msg'];
        vehicles = vehiclesList;
        update();
      } else {
        print("Failed to fetch vehicles: ${response.statusCode}");
      }
    } catch (e) {
      alertError("an error occured please try again later");
    }
  }

  Future<void> deleteVehicle(int id) async {
    try {
      final response = await http.delete(
        Uri.parse('${Config.apiUrl}/deleteVehicleById/$id'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        fetchVehicles(); // Refresh the list after deletion
      } else {
        alertError("fail to delete vehicle");
      }
    } catch (e) {
      alertError("an error occured please try again later");
    }
  }
}
