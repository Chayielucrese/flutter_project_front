import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/DetailPage.dart';
import 'package:get/get.dart';

class AdvancedServiceRequestPage extends StatelessWidget {
  final List<Map<String, String>> advancedRequests = [];

   AdvancedServiceRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: advancedRequests.isEmpty
          ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Center(
                child: Text(
                  'No requests available at the moment ',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
              ),
            ])
          : ListView.builder(
              itemCount: advancedRequests.length,
              itemBuilder: (context, index) {
                final request = advancedRequests[index];
                return Card(
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Request ID: ${request['requestId']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Passenger Name: ${request['passengerName']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Pickup Location: ${request['pickupLocation']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Destination: ${request['destination']}',
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 10),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Showp the DetailedRequestPage as a popup

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return DetailedRequestPage(
                                        requestId: request['requestId']!,
                                        passengerName:
                                            request['passengerName']!,
                                        pickupLocation:
                                            request['pickupLocation']!,
                                        destination: request['destination']!,
                                        fare: request['fare']!,
                                      );
                                    },
                                  );
                                },
                                child: const Text(
                                  'View Request',
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.pink,
                                ),
                              ),
                            ]),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
