import 'dart:convert';
import 'dart:core';

import 'package:flutter_application_1/Config/default_api_link.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Controller/token_ctrl.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class DriverSubscriptionController extends AppController {
  TokenController tokens = Get.put(TokenController());

  List<dynamic> subscriptionPlans = [];

  void initState() {
    super.onInit();
    getTokenAndLoadSubscriptionDetails();
    print("hello i am here");
    update();
  }

  void getTokenAndLoadSubscriptionDetails() async {
    String? myToken = await tokens.retriveToken();
    if (myToken != null) {
      subscriptionDetails(myToken);
      update();
    } else {
      print("No token found");
      // Handle the case where the token is null
    }
  }

  String name = "";
  String description = "";
  String price = "";

  Future<void> subscriptionDetails(String newToken) async {

    try {
      final response = await fetchSubscriptionPlans(newToken);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        subscriptionPlans = data['reservationTypeList'];
        update();
        print( "$subscriptionPlans : your array");
      } else {
        // Handle errors here
        print('Failed to load subscription plans');
      }
    } catch (e) {
      print("Error occurred while fetching subscriptionDetails: $e");
    }
  }

  Future<http.Response> fetchSubscriptionPlans(myToken) async {
    return await http.get(
      Uri.parse('${Config.apiUrl}/getAllReservationTtypes'),
      headers: {
        'Authorization': 'Bearer $myToken',
        'Content-Type': 'application/json',
      },
    );
  }
}
