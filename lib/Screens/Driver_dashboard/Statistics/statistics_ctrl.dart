import 'dart:convert';
import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class DriverDashboardController extends AppController {
  bool isDocumentVerified = false;
  String? token;
  int numOfVehicles = 0; // Variable to hold the number of vehicles

  @override
  void onInit() {
    super.onInit();
    _loadToken().then((_) => fetchNumOfVehicles());
    update(); // Retrieve token during initialization
  }

  Future<void> _loadToken() async {
    token = await _getToken();
    print("Loaded token: $token");
  }

  Future<String?> _getToken() async {
    final pref = await SharedPreferences.getInstance();
    String? token = pref.getString("token");
    print("Retrieved token: $token"); // Check what is being retrieved
    return token;
  }

  Future<void> fetchNumOfVehicles() async {
    try {
      final response = await http.get(
        Uri.parse('${Config.apiUrl}/totalVehicle'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      print("Raw response body: ${response.body}");

      if (response.statusCode == 200) {
        Map<String, dynamic> responseJson = json.decode(response.body);
        numOfVehicles = responseJson['totalVehicles'];
        print("$numOfVehicles, numOfvehicle"); // Update the variable
        update(); // Notify listeners about the update
      } else {
        print("Failed to fetch vehicles: ${response.statusCode}");
      }
    } catch (e) {
      alertError("An error occurred, please try again later.");
    }
  }

   Future<void> removeTokenFromLocalStorage() async {
    final pref = await SharedPreferences.getInstance();
    bool results = await pref.remove("token");
    print("token removed: $results");
  }
  Future<void>getCurrentUser()async{
    
  }
}
