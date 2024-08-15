import 'dart:convert';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ViewVehicleController extends AppController {
  List<dynamic> vehicles = [];
  String? token;

  @override
  void onInit() {
    super.onInit();
    _loadToken().then((_) => fetchVehicles());
  }

  Future<void> _loadToken() async {
    token = await _getToken();
    print("Loaded token: $token");
  }

  Future<String?> _getToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print("Retrieved token: $token");
    return token;
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
        update(); // Notify listeners
      } else {
        print("Failed to fetch vehicles: ${response.statusCode}");
      }
    } catch (e) {
      alertError("An error occurred, please try again later.");
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
        alertError("Failed to delete vehicle.");
      }
    } catch (e) {
      alertError("An error occurred, please try again later.");
    }
  }

  Future<void> addVehicle(Map<String, dynamic> vehicleData) async {
    try {
      final response = await http.post(
        Uri.parse('${Config.apiUrl}/addVehicle'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(vehicleData),
      );

      if (response.statusCode == 200) {
        update();
        fetchVehicles();
      } else {
        alertError("Failed to add vehicle.");
      }
    } catch (e) {
      alertError("An error occurred, please try again later.");
    }
  }
}
