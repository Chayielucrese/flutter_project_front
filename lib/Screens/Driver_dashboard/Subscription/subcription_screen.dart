import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/subcription%20Component.dart';
import 'package:get/get.dart';

class DriverSubscriptionPage extends StatelessWidget {
  const DriverSubscriptionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Subscriptions",
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
        padding: const EdgeInsets.all(15.0),
        children: [
          _buildSubscriptionCard(
            name: "Instant Service Only",
            price: "2000 FCFA",
            description: "Access to instant service rides only.",
            onPressed: () {
              Get.to(() => SubscribeNowPage(
                planName: "Instant Service Only",
                planPrice: "2000 FCFA",
                planDescription: "Access to instant service rides only.",
              ));
            },
          ),
          _buildSubscriptionCard(
            name: "Advanced Service Only",
            price: "3000 FCFA",
            description: "Access to advanced service rides only.",
            onPressed: () {
              Get.to(() => SubscribeNowPage(
                planName: "Advanced Service Only",
                planPrice: "3000",
                planDescription: "Access to advanced service rides only.",
              ));
            },
          ),
          _buildSubscriptionCard(
            name: "Full Access",
            price: "5000 FCFA",
            description: "Access to both instant and advanced service rides.",
            onPressed: () {
              Get.to(() =>  SubscribeNowPage(
                planName: "Full Access",
                planPrice: "5000",
                planDescription: "Access to both instant and advanced service rides.",
              ));
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // You can implement additional functionality if needed
        },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.pink,
      ),
    );
  }

  Widget _buildSubscriptionCard({
    required String name,
    required String price,
    required String description,
    required VoidCallback onPressed,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text(
              "Price: $price",
              style: TextStyle(fontSize: 16, color: Colors.pink),
            ),
            SizedBox(height: 5),
            Text(
              "Description: $description",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
            ElevatedButton(
              onPressed: onPressed,
              child: Text('Subscribe Now', style: TextStyle(color:Colors.white),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
              ),
            ),],)
          ],
        ),
      ),
    );
  }
}
