import 'dart:convert';

import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ClientWelcomeController extends AppController {
  var rides = <String, String>{}.obs;

  TokenController token = Get.put(TokenController());

  @override
  void onInit() {
    super.onInit();
    token.loadToken().then((_) => getRides());

    print('${token.loadToken()}');
  }

  Future<void> getRides() async {
    try {
      final res = await ride();
      if (res.statusCode == 200) {
        final response = json.decode(res.body);
        final ridesList = response['success'] as List<dynamic>;

        // Update the rides map with name and description
        rides.assignAll(
            {for (var ride in ridesList) ride['name']: ride['description']});
      } else {
        print("Failed to get rides: ${res.statusCode}");
      }
    } catch (e) {
      print("Error occurred while fetching rides: $e");
    }
  }

  Future<http.Response> ride() async {
    return await http.get(
      Uri.parse("${Config.apiUrl}/getRides"),
      headers: {
        'Authorization': 'Bearer ${token.loadToken()}',
        'Content-Type': 'application/json',
      },
    );
  }
}
