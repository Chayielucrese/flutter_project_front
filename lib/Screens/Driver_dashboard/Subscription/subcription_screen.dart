import 'package:flutter/material.dart';

class DriverSubscriptionPage extends StatelessWidget {
  const DriverSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subscription Plans",
          style: TextStyle(
            color: Colors.pink,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.pink),
      ),
      body: ListView(
        padding: EdgeInsets.all(15),
        children: [
          _buildSubscriptionCard(
            title: "Instant Ride Access",
            price: "5000FCFA/month",
            description:
                "Access to instant ride notifications and the ability to accept only instant service rides.",
            features: [
              "Instant ride notifications",
              "Accept only instant rides",
              "Basic support"
            ],
          ),
          SizedBox(height: 15),
          _buildSubscriptionCard(
            title: "Advanced Ride Access",
            price: "6000FCFA/month",
            description:
                "Access to advanced ride requests and the ability to accept only scheduled rides.",
            features: [
              "Access to advanced ride requests",
              "Accept only advanced rides",
              "Standard support"
            ],
          ),
          SizedBox(height: 15),
          _buildSubscriptionCard(
            title: "Complete Ride Access",
            price: "10000FCFA/month",
            description:
                "Access to both instant and advanced ride requests, with notifications for both types.",
            features: [
              "Access to both instant and advanced rides",
              "Premium support",
              "Additional features like ride analytics"
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String title,
    required String price,
    required String description,
    required List<String> features,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              price,
              style: TextStyle(fontSize: 16, color: Colors.pink),
            ),
            SizedBox(height: 10),
            Text(
              description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              "Features:",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ...features.map((feature) => Text(
                  "• $feature",
                  style: TextStyle(fontSize: 16),
                )),
            SizedBox(height: 10),
            Row(
               mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Handle subscription purchase
                  },
                  child: Text('Subscribe Now',
                      style: TextStyle(color: Colors.white)),
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
  }
}
