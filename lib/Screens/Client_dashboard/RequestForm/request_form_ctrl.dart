import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/Controller/app_ctrl.dart';
import 'package:flutter_application_1/Screens/Client_dashboard/RequestForm/request_form_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';

import 'package:http/http.dart' as http;

class RequestFormController extends AppController {
  final  pickupPointController = TextEditingController();
  final destinationController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final reservationType = TextEditingController();
  var pickupPointText = ''.obs; // RxString
final Debouncer _debouncer = Debouncer(milliseconds: 300);
  @override
   void onInit() {
    super.onInit();
    pickupPointController.addListener(() {
      _debouncer.run(() {
        if (pickupPointController.text.isNotEmpty) {
          fetchLocations(pickupPointController.text);
        } else {
          locations.clear();
        }
      });
    });
  }

  void onPickupPointChanged(PlacesModel? selectedPlace) {
    pickupPointController.text = selectedPlace!.suburb;
    update();
  }

  List<PlacesModel> locations = [];
Future<void> fetchLocations(String filter) async {
  final uri = Uri.parse(
    "https://api.geoapify.com/v1/geocode/autocomplete",
  ).replace(
    queryParameters: {
      'text': '$filter, Cameroon', // Adding country context
      'format': 'json',
      'apiKey': 'f466daa73fca415bbbc3f11b71517dc3',
    },
  );

  final response = await http.get(uri);
  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> results = data['results'] ?? [];

    // Print the entire response to debug what's being returned
    print("API Response: ${response.body}");

    // Map results to PlacesModel, include more result types
    var filteredModels = results.map((item) {
   var place = PlacesModel.fromJson(item as Map<String, dynamic>);
   if (place.country == 'country' || 
       place.suburb == 'suburb' 
   ){
     return place;
   }
   return null; // Filter out irrelevant locations
 }).where((element) => element != null).toList();


    // Update the observable list directly
    locations.assignAll(filteredModels.cast<PlacesModel>());
  } else {
    print("Failed to load locations");
  }
}


  void clearLocations() {
    locations = [];
    update();
  }

  @override
  void onClose() {
    pickupPointController.dispose();
    super.onClose();
  }
}


class Debouncer {
  final int milliseconds;
  Timer? _timer;

  Debouncer({required this.milliseconds});

  run(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}