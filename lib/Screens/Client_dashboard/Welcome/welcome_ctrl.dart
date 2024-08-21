import 'dart:convert';

import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ClientWelcomeController extends AppController {
  var rides = <String, String>{}.obs;

  TokenController token = Get.put(TokenController());

  @override
  void onInit() {
    super.onInit();
    token.loadToken().then((_) => getRides());

  }
  

  Future<void> getRides() async {
    try {
      final res = await ride();
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        final ridesList = response['msg'] as List<dynamic>;

     
        rides.assignAll(
            {for (var ride in ridesList) ride['name']: ride['description']});
            update();
      } else {
        print("Failed to get rides: ${res.statusCode}");
      }
    } catch (e) {
      print("Error occurred while fetching rides: $e");
    }
  }
   Future<void> removeTokenFromLocalStorage() async {
    final pref = await SharedPreferences.getInstance();
    bool results = await pref.remove("token");
    print("token removed: $results");
  }

  Future<http.Response> ride() async {
   
    final tok = await token.retriveToken();
    return await http.get(
      Uri.parse("${Config.apiUrl}/getRides"),
      headers: {
        'Authorization': 'Bearer $tok',
        'Content-Type': 'application/json',
      },
    );
  }
//find driver with availability status true

// Future<http.Response> getAvailableDriver () async{
//   final response = await http.get(Uri.parse("${Config.apiUrl}/"))
// }
    
}
