import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter_application_1/Components/TextField.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Client_dashboard/RequestForm/request_form_ctrl.dart';

import 'package:http/http.dart' as http;

class ReservationScreen extends StatelessWidget {
  ReservationScreen({super.key});

  final String API_KEY = 'f466daa73fca415bbbc3f11b71517dc3';
  RequestFormController thisContoller = Get.put(RequestFormController());
  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestFormController>(
      initState: (_) {
        thisContoller.pickupPointController.addListener(() {
          if (thisContoller.pickupPointController.text.isNotEmpty) {
            thisContoller
                .fetchLocations(thisContoller.pickupPointController.text);
          } else {
            thisContoller.clearLocations();
          }
        });
      },
      builder: (controller) => DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Book a Ride',
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.pink,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Get.toNamed(AppRoutes.clientwelcome);
              },
            ),
            bottom: const TabBar(
              tabs: [
                Tab(
                  child: Text(
                    "Instant Booking",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                Tab(
                  child: Text("Advance Booking",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
              indicatorColor: Colors.white,
            ),
          ),
          body: TabBarView(
            children: [
              // Instant Booking Tab
              _buildBookingForm(context, controller, isInstantBooking: true),
              // Advance Booking Tab
              _buildBookingForm(context, controller, isInstantBooking: false),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookingForm(
      BuildContext context, RequestFormController controller,
      {required bool isInstantBooking}) {
    return Stack(
      children: [
        // Background image
        Positioned.fill(
          child: Image.asset(
            'Assets/order-ride-removebg-preview.png', // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        // Form in the bottom section
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            color: Colors.white.withOpacity(
                0.8), // Semi-transparent background for readability
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DropdownSearch<PlacesModel>(
                      dropdownBuilder: (context, selectedItem) {
                        return Text(selectedItem?.suburb ?? 'Select Location');
                      },
                      popupProps: PopupProps.menu(showSearchBox: true),
                      asyncItems: (String filter) async {
                        print(filter);

                        final uri = Uri.parse(
                          "https://api.geoapify.com/v1/geocode/autocomplete",
                        ).replace(
                          queryParameters: {
                            'text':"Cameroon",
                            'format': 'json',
                            'apiKey': 'f466daa73fca415bbbc3f11b71517dc3',
                          },
                        );

                        final response = await http.get(uri);
                        print(response.body);

                        Map<String, dynamic> data = jsonDecode(response.body);

                        // Access the 'results' list safely
                        List<dynamic> results = data['results'] ?? [];

                        // Handle potential nulls in the list and provide default values
                        var models = results.map((item) {
                          return PlacesModel.fromJson(
                              item as Map<String, dynamic>);
                        }).toList();

                        return models;
                      },
                      onChanged: (PlacesModel? data) {
                        print(data);
                      }),

                  const SizedBox(height: 20),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return const Iterable<String>.empty();
                      }
                      return locations.where((String location) {
                        return location
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      });
                    },
                    onSelected: (String selection) {
                      controller.destinationController.text = selection;
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      return appTextField(
                        controller: fieldTextEditingController,
                        icon: Icons.location_on,
                        labelText: "Destination",
                      );
                    },
                  ),
                  // Other fields and widgets...
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

List<String> locations = [
  'Yaoundé',
  'Douala',
  'Bamenda',
  'Bafoussam',
  'Garoua',
  'Maroua',
  'Ngaoundéré',
  'Bertoua',
  'Ebolowa',
  'Kribi',
  'Limbe',
  'Kumba',
];

class PlacesModel {
  final String id;
  final DateTime createdAt;
  final String country;
  final String suburb;

  PlacesModel({
    required this.id,
    required this.createdAt,
    required this.country,
    required this.suburb
  });

  factory PlacesModel.fromJson(Map<String, dynamic> json) {
    return PlacesModel(
      id: json["id"] ?? "", // Provide a default value if null
      createdAt: json["createdAt"] != null
          ? DateTime.parse(json["createdAt"])
          : DateTime.now(), // Handle null and provide current DateTime
      country: json["name"] ?? "Unknown", // Provide a default value if null
      suburb: json["avatar"] ?? "", // Provide a default value if null
    );
  }

  static List<PlacesModel> fromJsonList(List<dynamic> list) {
    return list
        .map((item) => PlacesModel.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  @override
  String toString() => suburb;
}
