import 'package:flutter/material.dart';

class DetailedRequestPage extends StatelessWidget {
  final String requestId;
  final String passengerName;
  final String pickupLocation;
  final String destination;
  final String fare;

  DetailedRequestPage({
    required this.requestId,
    required this.passengerName,
    required this.pickupLocation,
    required this.destination,
    required this.fare,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Request Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Request ID: $requestId', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('Passenger Name: $passengerName'),
          SizedBox(height: 5),
          Text('Pickup Location: $pickupLocation'),
          SizedBox(height: 5),
          Text('Destination: $destination'),
          SizedBox(height: 5),
          Text('Fare: $fare'),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.pink,
          ),
        ),
        ElevatedButton(
          onPressed: () {
            // Add functionality for accepting the request
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Accept Request'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
          ),
        ),
      ],
    );
  }
}
