import 'package:flutter/material.dart';
import 'package:flutter_application_1/Components/subcription%20Component.dart';
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:flutter_application_1/Screens/Driver_dashboard/Subscription/subcription_ctrl.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
// Ensure correct path
import 'package:flutter_application_1/Routes/app_routes.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DriverSubscriptionPage extends StatefulWidget {
  const DriverSubscriptionPage({super.key});

  @override
  _DriverSubscriptionPageState createState() => _DriverSubscriptionPageState();
}

class _DriverSubscriptionPageState extends State<DriverSubscriptionPage> {

 

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: ((didpop) {
        if (didpop) {
          return;
        } else {
          Get.toNamed(AppRoutes.driverStats);
        }
      }),
      child: GetBuilder<DriverSubscriptionController>(
      builder: (controller) => Scaffold(
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
        body: ListView.builder(
          padding: const EdgeInsets.all(15.0),
          itemCount: controller.subscriptionPlans.length,
          itemBuilder: (context, index) {
            final plan = controller.subscriptionPlans[index];
            return _buildSubscriptionCard(
              name: plan['name'],
              price: plan['price'],
              description: plan['description'],
              onPressed: () {
                Get.to(() => SubscribeNowPage(
                      planName: plan['name'],
                      planPrice: plan['price'],
                      planDescription: plan['description'],
                    ));
              },
            );
          },
        ),
      ),
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
                  child: Text(
                    'Subscribe Now',
                    style: TextStyle(color: Colors.white),
                  ),
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
