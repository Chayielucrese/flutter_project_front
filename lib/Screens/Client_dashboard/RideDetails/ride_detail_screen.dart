import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RideDetailsPage extends StatelessWidget {
   String rideType="Car";

  RideDetailsPage(String s, {required this.rideType});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('$rideType Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Ride Type Section
            Text(
              '$rideType Ride',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
            SizedBox(height: 10),
            Text(
              "Comfortable & Safe",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(height: 20),

            // Fare Details Section
            Text(
              "Fare Details",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.attach_money, color: Colors.pink),
              title: Text("Base Fare"),
              trailing: Text("0 FCFA"),
            ),
            ListTile(
              leading: Icon(Icons.access_time, color: Colors.pink),
              title: Text("Estimated Time"),
              trailing: Text("5 mins"),
            ),
            ListTile(
              leading: Icon(Icons.location_on, color: Colors.pink),
              title: Text("Estimated Distance"),
              trailing: Text("2 km"),
            ),
            SizedBox(height: 20),

            // Payment Options Section
            Text(
              "Select Payment Method",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.pink),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PaymentOption(
                  label: "Wallet",
                  icon: Icons.account_balance_wallet,
                ),
                PaymentOption(
                  label: "Cash",
                  icon: Icons.money,
                ),
              ],
            ),
            Spacer(),

            // Confirm Ride Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Proceed with the ride confirmation
                  Get.snackbar("Ride Confirmed", "Your $rideType ride has been confirmed!",
                      backgroundColor: Colors.pink, colorText: Colors.white);
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pink,
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero, // Square borders
                  ),
                ),
                child: Text("Confirm Ride", style: TextStyle(fontSize: 18)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PaymentOption extends StatelessWidget {
  final String label;
  final IconData icon;

  const PaymentOption({
    Key? key,
    required this.label,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.pink,
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Square borders
        ),
      ),
    );
  }
}
