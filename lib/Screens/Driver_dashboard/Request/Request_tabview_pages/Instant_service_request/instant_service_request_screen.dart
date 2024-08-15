import 'package:flutter/material.dart';

class InstanceServiceRequestPage extends StatelessWidget {
  const InstanceServiceRequestPage({Key? key}) : super(key: key);

  final List<Map<String, String>> instanceRequests = const [
    {
      'requestId': 'REQ125',
      'passengerName': 'Alice Johnson',
      'pickupLocation': 'Green Park',
      'destination': 'University',
    },
    {
      'requestId': 'REQ126',
      'passengerName': 'Bob Williams',
      'pickupLocation': 'Train Station',
      'destination': 'Shopping Mall',
    },
    // Add more instance request data here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: instanceRequests.length,
        itemBuilder: (context, index) {
          final request = instanceRequests[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Request ID: ${request['requestId']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Passenger Name: ${request['passengerName']}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Pickup Location: ${request['pickupLocation']}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Destination: ${request['destination']}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Implement functionality for accepting the request
                        },
                        child: const Text('Accept Request', style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
